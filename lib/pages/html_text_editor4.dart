import 'dart:convert';
import 'dart:io' as io show Directory, File;

import 'package:delta_to_html/delta_to_html.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';
//import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:flutter_quill_delta_from_html/flutter_quill_delta_from_html.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
//import 'package:web/web.dart' as web;

import 'package:logger/logger.dart' as logger;
import 'package:minio/minio.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/forms/template_form.dart';
import 'package:notifi/models/message_template.dart';
import 'package:notifi/models/person.dart';
import 'package:notifi/state/nest_auth2.dart';
import 'package:notifi/utils/minio_utils.dart';
import 'package:path/path.dart' as path;
import 'package:xml/xml.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class HtmlTextEditor4 extends ConsumerStatefulWidget {
  const HtmlTextEditor4({super.key});

  @override
  ConsumerState<HtmlTextEditor4> createState() => _HtmlTextEditor4State();
}

class _HtmlTextEditor4State extends ConsumerState<HtmlTextEditor4> {
  final GlobalKey<FormFieldState> itemFormFieldKey =
      GlobalKey<FormFieldState>();
  String templateCode = "";
  Map<String, dynamic> fieldValues = {}; // used to access live field values

  final QuillController _controller = () {
    return QuillController.basic(
        config: QuillControllerConfig(
      clipboardConfig: QuillClipboardConfig(
        enableExternalRichPaste: true,
        onImagePaste: (imageBytes) async {
          if (kIsWeb) {
            // Dart IO is unsupported on the web.
            return null;
          }
          // Save the image somewhere and return the image URL that will be
          // stored in the Quill Delta JSON (the document).
          final newFileName =
              'image-file-${DateTime.now().toIso8601String()}.png';
          final newPath = path.join(
            io.Directory.systemTemp.path,
            newFileName,
          );
          final file = await io.File(
            newPath,
          ).writeAsBytes(imageBytes, flush: true);
          return file.path;
        },
      ),
    ));
  }();
  final FocusNode _editorFocusNode = FocusNode();
  final ScrollController _editorScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    //_controller.document = Document.fromJson(kQuillDefaultSample);
    //loadHtmlFromMinio("TPL_TEST.html");
  }

  @override
  void dispose() {
    /// please do not forget to dispose the controller
    _controller.dispose();
    _editorScrollController.dispose();
    _editorFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Person currentUser = ref.read(nestAuthProvider.notifier).currentUser;
    void tap2clipboard(String text) =>
        Clipboard.setData(ClipboardData(text: text)).then((_) {
          // ScaffoldMessenger.of(context).showSnackBar(
          // SnackBar(content: Text(nt.t.copied_to_clipboard(item: nt.t.text)))
          //);
        });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Nest Html Text Editor'),
          actions: [
            // IconButton(
            //   icon: const Icon(Icons.output),
            //   tooltip: 'Print Delta JSON to log',
            //   onPressed: () {
            //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            //         content: Text(
            //             'The JSON Delta has been printed to the console.')));
            //     debugPrint(jsonEncode(_controller.document.toDelta().toJson()));
            //   },
            // ),
            IconButton(
              icon: const Icon(Icons.read_more),
              tooltip: 'Load Minio',
              onPressed: () {
                String filename = fieldValues['code'];
                loadHtmlFromMinio(filename);
              },
            ),
            IconButton(
              icon: const Icon(Icons.save),
              tooltip: 'Save to Minio',
              onPressed: () {
                String filename = fieldValues['code'];

                var html = DeltaToHTML.encodeJson(
                    _controller.document.toDelta().toJson());
                logNoStack.i("SAVE HTML: about to save $html to $filename");
                saveFileToMinio(ref, context, filename, html);
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            CreateTemplateForm(
              formCode: "template",
              templateCode: templateCode,
              onSubmit: loadHtmlFromMinio,
              fieldValues: fieldValues,
            ),
           // SingleChildScrollView(
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
                  QuillSimpleToolbar(
                    controller: _controller,
                    config: QuillSimpleToolbarConfig(
                      embedButtons: FlutterQuillEmbeds.toolbarButtons(),
                      showClipboardPaste: true,
                      customButtons: [
                        QuillToolbarCustomButtonOptions(
                          icon: const Icon(Icons.add_alarm_rounded),
                          onPressed: () {
                            _controller.document.insert(
                              _controller.selection.extentOffset,
                              TimeStampEmbed(
                                DateTime.now().toString(),
                              ),
                            );

                            _controller.updateSelection(
                              TextSelection.collapsed(
                                offset: _controller.selection.extentOffset + 1,
                              ),
                              ChangeSource.local,
                            );
                          },
                        ),
                      ],
                      buttonOptions: QuillSimpleToolbarButtonOptions(
                        base: QuillToolbarBaseButtonOptions(
                          afterButtonPressed: () {
                            final isDesktop = {
                              TargetPlatform.linux,
                              TargetPlatform.windows,
                              TargetPlatform.macOS
                            }.contains(defaultTargetPlatform);
                            if (isDesktop) {
                              _editorFocusNode.requestFocus();
                            }
                          },
                        ),
                        linkStyle: QuillToolbarLinkStyleButtonOptions(
                          validateLink: (link) {
                            // Treats all links as valid. When launching the URL,
                            // `https://` is prefixed if the link is incomplete (e.g., `google.com` → `https://google.com`)
                            // however this happens only within the editor.
                            return true;
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: QuillEditor(
                      focusNode: _editorFocusNode,
                      scrollController: _editorScrollController,
                      controller: _controller,
                      config: QuillEditorConfig(
                        placeholder: 'Start writing your notes...',
                        padding: const EdgeInsets.all(16),
                        embedBuilders: [
                          ...FlutterQuillEmbeds.editorBuilders(
                            imageEmbedConfig: QuillEditorImageEmbedConfig(
                              imageProviderBuilder: (context, imageUrl) {
                                // https://pub.dev/packages/flutter_quill_extensions#-image-assets
                                if (imageUrl.startsWith('assets/')) {
                                  return AssetImage(imageUrl);
                                }
                                return null;
                              },
                            ),
                            videoEmbedConfig: QuillEditorVideoEmbedConfig(
                              customVideoBuilder: (videoUrl, readOnly) {
                                // To load YouTube videos https://github.com/singerdmx/flutter-quill/releases/tag/v10.8.0
                                return null;
                              },
                            ),
                          ),
                          TimeStampEmbedBuilder(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          //  ),
        //  ],
      //  ),
        bottomNavigationBar: Visibility(
          visible: false,
          child: Wrap(
            children: [],
          ),
        ),
      ),
    );
  }

  void loadHtmlFromMinio(String filename) async {
    filename = filename.toLowerCase();
    logNoStack.i("LOAD HTML1: filename $filename");
    if (!filename.startsWith("${MessageTemplate.PREFIX}")) {
      filename = "${MessageTemplate.PREFIX}$filename";
    }
    logNoStack.i("LOAD HTML2: filename $filename");
    if (!filename.endsWith(".html")) {
      filename = "$filename.html";
    }
    logNoStack.i("LOAD HTML3: filename $filename");
    var response = await getMinioTokenResponse();

    logNoStack.i("LOAD HTML: Minio reponse=> $response");
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

    logNoStack.i(
        "LOAD_HTML: accessKeyId=$accessKeyId , secretAccessKey = $secretAccessKey");

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
    String bucket = "templates";
    String object = filename;
    Map<String, String> metadata = {
      'Content-Type': 'text/html',
    };
    var stream = await minio.getObject(bucket, object);
    // Get object length
    logNoStack.i("LOAD_HTML: GetObject length = ${stream.contentLength}");

    // Write object data stream to file
    String data = "";
    await for (var chunk in stream) {
      data += utf8.decode(chunk);
    }
    // Get object length
    logNoStack.i("LOAD HTML: GetObject length = ${stream.contentLength}");

    // Write object data stream to file

    logNoStack.i("LOAD HTML: data = $data");
    // await _controller.document.
    var delta = HtmlToDelta().convert(data, transformTableAsEmbed: false);
    _controller.document = Document.fromDelta(delta);
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

class TimeStampEmbed extends Embeddable {
  const TimeStampEmbed(
    String value,
  ) : super(timeStampType, value);

  static const String timeStampType = 'timeStamp';

  static TimeStampEmbed fromDocument(Document document) =>
      TimeStampEmbed(jsonEncode(document.toDelta().toJson()));

  Document get document => Document.fromJson(jsonDecode(data));
}

class TimeStampEmbedBuilder extends EmbedBuilder {
  @override
  String get key => 'timeStamp';

  @override
  String toPlainText(Embed node) {
    return node.value.data;
  }

  @override
  Widget build(
    BuildContext context,
    EmbedContext embedContext,
  ) {
    return Row(
      children: [
        const Icon(Icons.access_time_rounded),
        Text(embedContext.node.value.data as String),
      ],
    );
  }
}
