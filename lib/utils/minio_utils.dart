import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:minio/minio.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:notifi/models/message_template.dart';
import 'package:notifi/state/nest_auth2.dart';
import 'package:status_alert/status_alert.dart';
import 'package:xml/xml.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

Future<String> loadHtmlFromMinio(WidgetRef ref, String filename) async {
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
  
  // String? htmlText = await _controller!.document.toPlainText();
  var response = await getMinioTokenResponse(ref);

  logNoStack.i("LOAD_HTML: Minio reponse=> $response");
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
  print(stream.contentLength);

  // Write object data stream to file

  logNoStack.i("LOADING HTML: data = $data");
//      const codec = ParchmentHtmlCodec();
//     // String html = '<hr>'; // works
//    // String html = data; // fails
//      final ParchmentDocument doc = codec.decode(data);
// //     Delta delta = codec.decode(html).toDelta(); // Fleather compatible Delta
// //  ParchmentDocument doc = ParchmentDocument.fromDelta(delta);
//   logNoStack.i("LOADING HTML: doc created");
//     // String html = '<p><hr></p><p>a</p><p></p>'; // fails
// //      Delta delta = codec.decode(html); // Fleather compatible Delta
// //  ParchmentDocument document = ParchmentDocument.fromDelta(delta);

  return data;
}

Future<String?> loadDocument() async {
  final file = File(Directory.systemTemp.path + "/quick_start.json");
  if (await file.exists()) {
    logNoStack.i("LOAD_DOC: quick start file exists");
    final contents = await file.readAsString();
    return contents;
  }
  return null;
}

void saveDocument(BuildContext context, String contents) {
  // Parchment documents can be easily serialized to JSON by passing to
  // `jsonEncode` directly
  logNoStack.i("DSAVE_DOC: doc saving to quick_start");

  // For this example we save our document to a temporary file.

  final file = File('${Directory.systemTemp.path}/quick_start.json');
  // And show a snack bar on success.
  file.writeAsString(contents).then((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Saved.')),
    );
  });
}

void saveFileToMinio(
    WidgetRef ref,BuildContext context, String filename, String htmlText) async {
    filename = filename.toLowerCase();
    logNoStack.i("SAVE HTML1: filename $filename");
    if (!filename.startsWith("${MessageTemplate.PREFIX.toLowerCase()}")) {
      filename = "${MessageTemplate.PREFIX.toLowerCase()}$filename";
    }
    logNoStack.i("SAVE HTML2: filename $filename");
    if (!filename.endsWith(".html")) {
      filename = "$filename.html";
    }
    logNoStack.i("SAVE HTML3: filename $filename");
  logNoStack.i("SAVE HTML: about to get minio $htmlText");
  var response = await getMinioTokenResponse(ref);

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

  logNoStack.i("accessKeyId=$accessKeyId , secretAccessKey = $secretAccessKey");

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
  String bucketName = "templates";
  String objectName = filename;
  String usercode = ref.read(nestAuthProvider.notifier).currentUser.code!;
  Map<String, String> metadata = {
    'Content-Type': 'text/html',
    'author': usercode,
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
      configuration: const IconConfiguration(icon: Icons.done),
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

Future<dynamic> getMinioTokenResponse(WidgetRef ref) async {
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
