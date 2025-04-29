
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minio/io.dart';
import 'package:minio/minio.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/models/person.dart';
import 'package:notifi/state/nest_auth2.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xml/xml.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart' as logger;

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class HtmlTextEditor extends ConsumerStatefulWidget {
  HtmlTextEditor({super.key});

    @override
  ConsumerState<HtmlTextEditor> createState() =>
      _HtmlTextEditorState();
}

class _HtmlTextEditorState
    extends ConsumerState<HtmlTextEditor> {
  final GlobalKey<FormFieldState> itemFormFieldKey =
      GlobalKey<FormFieldState>();


 late QuillEditorController controller;

  ///[customToolBarList] pass the custom toolbarList to show only selected styles in the editor

  final customToolBarList = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.align,
    ToolBarStyle.color,
    ToolBarStyle.background,
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.clean,
    ToolBarStyle.addTable,
    ToolBarStyle.editTable,
  ];

  final _toolbarColor = Colors.grey.shade200;
  final _backgroundColor = Colors.white70;
  final _toolbarIconColor = Colors.black87;
  final _editorTextStyle = const TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontFamily: 'Roboto');
  final _hintTextStyle = const TextStyle(
      fontSize: 18, color: Colors.black38, fontWeight: FontWeight.normal);

  bool _hasFocus = false;

  @override
  void initState() {
    controller = QuillEditorController();
    controller.onTextChanged((text) {
      logNoStack.i('listening to $text');
    });
    controller.onEditorLoaded(() {
      logNoStack.i('Editor Loaded :)');
    });
    super.initState();
  }

  @override
  void dispose() {
    /// please do not forget to dispose the controller
    controller.dispose();
    super.dispose();
  }
//  Person currentUser = ref.read(nestAuthProvider.notifier).currentUser;
//     void tap2clipboard(String text) =>
//       Clipboard.setData(ClipboardData(text: text)).then((_) {
//          ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(nt.t.copied_to_clipboard(item: nt.t.text)))
//       );
//       });

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
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            ToolBar(
              toolBarColor: _toolbarColor,
              padding: const EdgeInsets.all(8),
              iconSize: 25,
              iconColor: _toolbarIconColor,
              activeIconColor: Colors.greenAccent.shade400,
              controller: controller,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              customButtons: [
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                      color: _hasFocus ? Colors.green : Colors.grey,
                      borderRadius: BorderRadius.circular(15)),
                ),
                InkWell(
                    onTap: () => unFocusEditor(),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.black,
                    )),
                InkWell(
                    onTap: () async {
                      var selectedText = await controller.getSelectedText();
                      logNoStack.i('selectedText $selectedText');
                      var selectedHtmlText =
                          await controller.getSelectedHtmlText();
                      logNoStack.i('selectedHtmlText $selectedHtmlText');
                    },
                    child: const Icon(
                      Icons.add_circle,
                      color: Colors.black,
                    )),
              ],
            ),
            Expanded(
              child: QuillHtmlEditor(
                text: "<h1>Hello</h1>This is a quill html editor example 😊",
                hintText: 'Hint text goes here',
                controller: controller,
                isEnabled: true,
                ensureVisible: false,
                minHeight: 500,
                autoFocus: false,
                textStyle: _editorTextStyle,
                hintTextStyle: _hintTextStyle,
                hintTextAlign: TextAlign.start,
                padding: const EdgeInsets.only(left: 10, top: 10),
                hintTextPadding: const EdgeInsets.only(left: 20),
                backgroundColor: _backgroundColor,
                inputAction: InputAction.newline,
                onEditingComplete: (s) => logNoStack.i('Editing completed $s'),
                loadingBuilder: (context) {
                  return const Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 1,
                    color: Colors.red,
                  ));
                },
                onFocusChanged: (focus) {
                  logNoStack.i('has focus $focus');
                  setState(() {
                    _hasFocus = focus;
                  });
                },
                onTextChanged: (text) => logNoStack.i('widget text change $text'),
                onEditorCreated: () {
                  logNoStack.i('Editor has been loaded');
                  setHtmlText('Testing text on load');
                },
                onEditorResized: (height) =>
                    logNoStack.i('Editor resized $height'),
                onSelectionChanged: (sel) =>
                     logNoStack.i('index ${sel.index}, range ${sel.length}'),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          width: double.maxFinite,
          color: _toolbarColor,
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
               textButton(
                  text: 'Save to Minio',
                  onPressed: () {
                    saveHtmlToMinio("TPL_TEST.html");
                  }),
              textButton(
                  text: 'Set Text',
                  onPressed: () {
                    setHtmlText('This text is set by you 🫵');
                  }),
              textButton(
                  text: 'Get Text',
                  onPressed: () {
                    getHtmlText();
                  }),
              textButton(
                  text: 'Insert Video',
                  onPressed: () {
                    ////insert
                    insertVideoURL(
                        'https://www.youtube.com/watch?v=4AoFA19gbLo');
                    insertVideoURL('https://vimeo.com/440421754');
                    insertVideoURL(
                        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4');
                  }),
              textButton(
                  text: 'Insert Image',
                  onPressed: () {
                    insertNetworkImage('https://i.imgur.com/0DVAOec.gif');
                  }),
              textButton(
                  text: 'Insert Index',
                  onPressed: () {
                    insertHtmlText("This text is set by the insertText method",
                        index: 10);
                  }),
              textButton(
                  text: 'Undo',
                  onPressed: () {
                    controller.undo();
                  }),
              textButton(
                  text: 'Redo',
                  onPressed: () {
                    controller.redo();
                  }),
              textButton(
                  text: 'Clear History',
                  onPressed: () async {
                    controller.clearHistory();
                  }),
              textButton(
                  text: 'Clear Editor',
                  onPressed: () {
                    controller.clear();
                  }),
              textButton(
                  text: 'Get Delta',
                  onPressed: () async {
                    var delta = await controller.getDelta();
                    debugPrint('delta');
                    debugPrint(jsonEncode(delta));
                  }),
              textButton(
                  text: 'Set Delta',
                  onPressed: () {
                    final Map<dynamic, dynamic> deltaMap = {
                      "ops": [
                        {
                          "insert": {
                            "video":
                                "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
                          }
                        },
                        {
                          "insert": {
                            "video": "https://www.youtube.com/embed/4AoFA19gbLo"
                          }
                        },
                        {"insert": "Hello"},
                        {
                          "attributes": {"header": 1},
                          "insert": "\n"
                        },
                        {"insert": "You just set the Delta text 😊\n"}
                      ]
                    };
                    controller.setDelta(deltaMap);
                  }),
            ],
          ),
        ),
      ),
    );
  }

   Widget textButton({required String text, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: _toolbarIconColor,
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: _toolbarColor),
          )),
    );
  }

  ///[getHtmlText] to get the html text from editor
  void getHtmlText() async {
    String? htmlText = await controller.getText();
    logNoStack.i(htmlText);
  }

  ///[setHtmlText] to set the html text to editor
  void setHtmlText(String text) async {
    await controller.setText(text);
  }

  ///[insertNetworkImage] to set the html text to editor
  void insertNetworkImage(String url) async {
    await controller.embedImage(url);
  }

  ///[insertVideoURL] to set the video url to editor
  ///this method recognises the inserted url and sanitize to make it embeddable url
  ///eg: converts youtube video to embed video, same for vimeo
  void insertVideoURL(String url) async {
    await controller.embedVideo(url);
  }

  /// to set the html text to editor
  /// if index is not set, it will be inserted at the cursor postion
  void insertHtmlText(String text, {int? index}) async {
    await controller.insertText(text, index: index);
  }

  /// to clear the editor
  void clearEditor() => controller.clear();

  /// to enable/disable the editor
  void enableEditor(bool enable) => controller.enableEditor(enable);

  /// method to un focus editor
  void unFocusEditor() => controller.unFocus();
  
  void saveHtmlToMinio(String filename) async {
   String? htmlText = await controller.getText();
    logNoStack.i(htmlText);
    String path2 = "";
    logNoStack.i("SAVE HTML: about to work out  file path");
    if (kIsWeb) {
        path2 = "/$filename";
    } else {
          Directory directory = await getApplicationDocumentsDirectory();
        path2 = path.join(directory.path, '$filename');
    }
    logNoStack.i("SAVE HTML: path2 = $path2");
    final file = File('${path2}');
    File file2 = await file.writeAsString(htmlText, flush: true);
    saveFileToMinio(file2);
  }

  void saveFileToMinio(File? file) async {
    logNoStack.i("SAVE HTML: about to get minio ${file!.path}");
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

    var filename = path.basename(file!.path);
    final etag =
        await minio.fPutObject(defaultRealm, filename, file.path);
    logNoStack.i("uploaded file ${file.path} with etag $etag");

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
