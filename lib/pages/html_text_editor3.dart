import 'dart:convert';
import 'dart:io';

import 'package:fleather/fleather.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/forms/template_form.dart';
import 'package:notifi/state/nest_auth2.dart';
import 'package:status_alert/status_alert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:parchment/codecs.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:xml/xml.dart';
//import 'package:web/web.dart' as web;

import 'package:logger/logger.dart' as logger;
import 'package:minio/minio.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);


class HtmlTextEditor3 extends ConsumerStatefulWidget {
  HtmlTextEditor3({super.key});

  @override
  ConsumerState<HtmlTextEditor3> createState() => _HtmlTextEditor3State();
}

class _HtmlTextEditor3State extends ConsumerState<HtmlTextEditor3> {
  final FocusNode _focusNode = FocusNode();
  final GlobalKey<EditorState> _editorKey = GlobalKey();
  FleatherController? _controller;
  String templateCode = "";

  @override
  void initState() {
    super.initState();
    if (kIsWeb) BrowserContextMenu.disableContextMenu();
    _initController();
    _loadDocument().then((document) {
      setState(() {
        _controller = FleatherController(document: document);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (kIsWeb) BrowserContextMenu.enableContextMenu();
  }

  Future<void> _initController() async {
    try {
      final result = await rootBundle.loadString('assets/welcome.json');
      final heuristics = ParchmentHeuristics(
        formatRules: [],
        insertRules: [
          ForceNewlineForInsertsAroundInlineImageRule(),
        ],
        deleteRules: [],
      ).merge(ParchmentHeuristics.fallback);
      final doc = ParchmentDocument.fromJson(
        jsonDecode(result),
        heuristics: heuristics,
      );
      _controller = FleatherController(document: doc);
    } catch (err, st) {
      if (kDebugMode) {
        print('Cannot read welcome.json: $err\n$st');
      }
      _controller = FleatherController();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, title: const Text('Html Text Editor'),
      actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _saveDocument(context),
          ),
        ],),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final picker = ImagePicker();
          final image = await picker.pickImage(source: ImageSource.gallery);
          if (image != null) {
            final selection = _controller!.selection;
            _controller!.replaceText(
              selection.baseOffset,
              selection.extentOffset - selection.baseOffset,
              EmbeddableObject('image', inline: false, data: {
                'source_type': kIsWeb ? 'url' : 'file',
                'source': image.path,
              }),
            );
            _controller!.replaceText(
              selection.baseOffset + 1,
              0,
              '\n',
              selection:
                  TextSelection.collapsed(offset: selection.baseOffset + 2),
            );
          }
        },
        child: const Icon(Icons.add_a_photo),
      ),
      body: _controller == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                CreateTemplateForm(
                  formCode: "template",
                  templateCode: templateCode,
                  onSubmit: loadHtmlFromMinio,
                ),
                FleatherToolbar.basic(
                    controller: _controller!, editorKey: _editorKey),
                Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
                Expanded(
                  child: FleatherEditor(
                    controller: _controller!,
                    focusNode: _focusNode,
                    editorKey: _editorKey,
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: MediaQuery.of(context).padding.bottom,
                    ),
                    onLaunchUrl: _launchUrl,
                    maxContentWidth: 800,
                    embedBuilder: _embedBuilder,
                    spellCheckConfiguration: SpellCheckConfiguration(
                        spellCheckService: DefaultSpellCheckService(),
                        misspelledSelectionColor: Colors.red,
                        misspelledTextStyle:
                            DefaultTextStyle.of(context).style),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _embedBuilder(BuildContext context, EmbedNode node) {
    if (node.value.type == 'icon') {
      final data = node.value.data;
      return const Icon(
        Icons.star,
        color: Colors.red,
        size: 18,
      );
      // Icons.rocket_launch_outlined
      // return Icon(
      //    IconData(int.parse(data['codePoint']), fontFamily: data['fontFamily']),
      //   color: Color(int.parse(data['color'])),
      //   size: 18,
      // );
    }

    if (node.value.type == 'image') {
      final sourceType = node.value.data['source_type'];
      ImageProvider? image;
      if (sourceType == 'assets') {
        image = AssetImage(node.value.data['source']);
      } else if (sourceType == 'file') {
        image = FileImage(File(node.value.data['source']));
      } else if (sourceType == 'url') {
        image = NetworkImage(node.value.data['source']);
      }
      if (image != null) {
        return Padding(
          // Caret takes 2 pixels, hence not symmetric padding values.
          padding: const EdgeInsets.only(left: 4, right: 2, top: 2, bottom: 2),
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(image: image, fit: BoxFit.cover),
            ),
          ),
        );
      }
    }

    return defaultFleatherEmbedBuilder(context, node);
  }

  void _launchUrl(String? url) async {
    if (url == null) return;
    final uri = Uri.parse(url);
    final canLaunch = await canLaunchUrl(uri);
    if (canLaunch) {
      await launchUrl(uri);
    }
  }

  void loadHtmlFromMinio(String filename) async {
    logNoStack.i("Loading $filename");
    filename = "TPL_TEST.html";
   // String? htmlText = await _controller!.document.toPlainText();
    var response = await getMinioTokenResponse();

    logNoStack.i("SAVE HTML: Minio reponse=> $response");
    final document = XmlDocument.parse(response);

    String accessKeyId = document
        .getElement('AssumeRoleWithWebIdentityResponse')!
        .getElement('AssumeRoleWithWebIdentityResult')!
        .getElement('Credentials')!
        .getElement('AccessKeyId')!
        .innerText;
    String secretAccessKey = document
        .getElement('AssumeRoleWithWebIdentityResponse')!
        .getElement('AssumeRoleWithWebIdentityResult')!
        .getElement('Credentials')!
        .getElement('SecretAccessKey')!
        .innerText;
    String sessionToken = document
        .getElement('AssumeRoleWithWebIdentityResponse')!
        .getElement('AssumeRoleWithWebIdentityResult')!
        .getElement('Credentials')!
        .getElement('SessionToken')!
        .innerText;

    logNoStack
        .i("accessKeyId=$accessKeyId , secretAccessKey = $secretAccessKey");

    final minioUri = defaultMinioEndpointUrl.substring('https://'.length);
    final minio = Minio(
      endPoint: minioUri,
      port: 443,
      accessKey: accessKeyId,
      secretKey: secretAccessKey,
      sessionToken: sessionToken,
      useSSL: true,
      // enableTrace: true,
    );
    String bucket = defaultRealm;
    String object = filename;
    Map<String, String> metadata = {
      'Content-Type': 'text/html',
    };
    var stream = await minio.getObject(bucket, object);
    // Get object length
    logNoStack.i("GetObject length = ${stream.contentLength}");

    // Write object data stream to file
    String data = "";
    await for (var chunk in stream) {
      data += utf8.decode(chunk);
    }
    // Get object length
    print(stream.contentLength);

    // Write object data stream to file

    logNoStack.i("LOADING HTML: data = $data");
     const codec = ParchmentHtmlCodec();
    // String html = '<hr>'; // works
    String html = data; // fails
    Delta delta = codec.decode(html).toDelta(); // Fleather compatible Delta
 ParchmentDocument doc = ParchmentDocument.fromDelta(delta);
    // String html = '<p><hr></p><p>a</p><p></p>'; // fails
//      Delta delta = codec.decode(html); // Fleather compatible Delta
//  ParchmentDocument document = ParchmentDocument.fromDelta(delta);

    //final ParchmentDocument doc = codec.decode(html);
    _controller = FleatherController(document: doc);
    setState(() {});
 


  }

/// Loads the document asynchronously from a file if it exists, otherwise
  /// returns default document.
  Future<ParchmentDocument> _loadDocument() async {
    final file = File(Directory.systemTemp.path + "/quick_start.json");
    if (await file.exists()) {
      final contents = await file.readAsString();
      return ParchmentDocument.fromJson(jsonDecode(contents));
    }
    final Delta delta = Delta()
      ..insert("Fleather Quick Start\n");
    return ParchmentDocument.fromDelta(delta);
  }

   void _saveDocument(BuildContext context) {
    // Parchment documents can be easily serialized to JSON by passing to
    // `jsonEncode` directly
    final contents = jsonEncode(_controller!.document);
    // For this example we save our document to a temporary file.

    final file = File('${Directory.systemTemp.path}/quick_start.json');
    // And show a snack bar on success.
    file.writeAsString(contents).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved.')),
      );
    });
  }

  void saveHtmlToMinio(String filename) async {
   // String? htmlText = await controller.getText();
   // logNoStack.i(htmlText);
    // String path2 = "";
    // File file2 ;
    // logNoStack.i("SAVE HTML: about to work out  file path");
    // if (kIsWeb) {
    //   path2 = "/$filename";
    //   final bytes = utf8.encode(htmlText);
    //   final web.HTMLAnchorElement anchor = web.document.createElement('a')
    //       as web.HTMLAnchorElement
    //     ..href = "data:application/octet-stream;base64,${base64Encode(bytes)}"
    //     ..style.display = 'none'
    //     ..download = filename;

    //   web.document.body!.appendChild(anchor);
    //   file2 = File('${filename}');
    // } else {
    //   Directory directory = await getApplicationDocumentsDirectory();
    //   path2 = path.join(directory.path, '$filename');
    //    final file = File('${path2}');
    // file2 = await file.writeAsString(htmlText, flush: true);
    // }
    // logNoStack.i("SAVE HTML: path2 = $path2");

   // saveFileToMinio(filename, htmlText);
  }

  void saveFileToMinio(String filename, String htmlText) async {
    logNoStack.i("SAVE HTML: about to get minio $htmlText");
    var response = await getMinioTokenResponse();

    logNoStack.i("SAVE HTML: Minio reponse=> $response");
    final document = XmlDocument.parse(response);

    String accessKeyId = document
        .getElement('AssumeRoleWithWebIdentityResponse')!
        .getElement('AssumeRoleWithWebIdentityResult')!
        .getElement('Credentials')!
        .getElement('AccessKeyId')!
        .innerText;
    String secretAccessKey = document
        .getElement('AssumeRoleWithWebIdentityResponse')!
        .getElement('AssumeRoleWithWebIdentityResult')!
        .getElement('Credentials')!
        .getElement('SecretAccessKey')!
        .innerText;
    String sessionToken = document
        .getElement('AssumeRoleWithWebIdentityResponse')!
        .getElement('AssumeRoleWithWebIdentityResult')!
        .getElement('Credentials')!
        .getElement('SessionToken')!
        .innerText;

    logNoStack
        .i("accessKeyId=$accessKeyId , secretAccessKey = $secretAccessKey");

    final minioUri = defaultMinioEndpointUrl.substring('https://'.length);
    final minio = Minio(
      endPoint: minioUri,
      port: 443,
      accessKey: accessKeyId,
      secretKey: secretAccessKey,
      sessionToken: sessionToken,
      useSSL: true,
      // enableTrace: true,
    );

//  var metaData = {
//       'Content-Type': 'image/jpg',
//       'Content-Language': 123,
//       'X-Amz-Meta-Testing': 1234,
//       example: 5678,
//     };
    Uint8List data = Uint8List.fromList(utf8.encode(htmlText));

    // Step 3: Upload
    String bucketName = defaultRealm;
    String objectName = filename;
    Map<String, String> metadata = {
      'Content-Type': 'text/html',
    };
    try {
      await minio.putObject(
        bucketName,
        objectName,
        Stream.value(data),
        size: data.length,
        metadata: metadata,
      );
      debugPrint('✅ File uploaded successfully');
       StatusAlert.show(
                                      context,
                                      duration: const Duration(seconds: 2),
                                      title: nt.t.template,
                                      subtitle: nt.t.form.saved,
                                      configuration: const IconConfiguration(
                                          icon: Icons.done),
                                      maxWidth: 300,
                                    );
    } catch (e) {
      debugPrint('❌ Upload failed: $e');
      
    }
// if (!kIsWeb) {
//  var filename = path.basename(file.path);
//    final etag = await minio.fPutObject(defaultRealm, filename, file.path);
//    // final etag = await minio.fPutObject(defaultRealm, filename, file.path);
//     logNoStack.i("uploaded file ${file.path} with etag $etag");
// } else {
//   logNoStack.i("SAVE HTML: about to upload file ${file.path}");
// }

// read it and print out
//  final reader = web.FileReader();
//    reader.readAsText();

//    await reader.onLoad.first;
//OpenResult result = await OpenFile.open("$filename");

    // String data = await file.readAsString();
    //logNoStack.i("SAVE HTML: read file data = $result");
  }

  Future<dynamic> getMinioTokenResponse() async {
    String? token = ref.read(nestAuthProvider.notifier).token!;
    final Uri uri = Uri.parse(
        "$defaultMinioEndpointUrl?Action=AssumeRoleWithWebIdentity&Version=2011-06-15&WebIdentityToken=$token");
    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
    );
    return response.body;
  }

}

/// This is an example insert rule that will insert a new line before and
/// after inline image embed.
class ForceNewlineForInsertsAroundInlineImageRule extends InsertRule {
  @override
  Delta? apply(Delta document, int index, Object data) {
    if (data is! String) return null;

    final iter = DeltaIterator(document);
    final previous = iter.skip(index);
    final target = iter.next();
    final cursorBeforeInlineEmbed = _isInlineImage(target.data);
    final cursorAfterInlineEmbed =
        previous != null && _isInlineImage(previous.data);

    if (cursorBeforeInlineEmbed || cursorAfterInlineEmbed) {
      final delta = Delta()..retain(index);
      if (cursorAfterInlineEmbed && !data.startsWith('\n')) {
        delta.insert('\n');
      }
      delta.insert(data);
      if (cursorBeforeInlineEmbed && !data.endsWith('\n')) {
        delta.insert('\n');
      }
      return delta;
    }
    return null;
  }

  bool _isInlineImage(Object data) {
    if (data is EmbeddableObject) {
      return data.type == 'image' && data.inline;
    }
    if (data is Map) {
      return data[EmbeddableObject.kTypeKey] == 'image' &&
          data[EmbeddableObject.kInlineKey];
    }
    return false;
  }
}
