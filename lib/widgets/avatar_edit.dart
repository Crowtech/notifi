import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minio/io.dart';
import 'package:minio/minio.dart';
import 'package:notifi/api_utils.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:notifi/models/person.dart';
import 'package:notifi/riverpod/refresh_widget.dart';
import 'package:notifi/state/nest_auth2.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart' as logger;
import 'package:path_provider/path_provider.dart';
import 'package:xml/xml.dart';
import 'package:path/path.dart' as path;

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class EditableAvatar extends ConsumerStatefulWidget {
  final String? imageUrl;
  double diameter;

  EditableAvatar({super.key, this.imageUrl, this.diameter = 50});

  @override
  _EditableAvatarState createState() => _EditableAvatarState();
}

class _EditableAvatarState extends ConsumerState<EditableAvatar> {
  File? _image;
  String? _imageUrl;
  String? token;
  Person? currentPerson;
  bool _fileExists = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      logNoStack
          .i("AVATAR_EDIT: initState Setting image from [${widget.imageUrl}]");
      currentPerson = ref.read(nestAuthProvider.notifier).currentUser;
      if (widget.imageUrl == null ||
          widget.imageUrl!.isEmpty ||
          widget.imageUrl == 'null') {
        var image = await getImageFileFromAssets('images/default-avatar.webp');
        bool fileExists = await image.exists();
        setState(() {
          _image = image;
          _imageUrl = null;
          _fileExists = fileExists;
        });
      } else {
        setState(() {
          _image = null;
          _imageUrl =
              "$defaultImageProxyUrl/${widget.diameter}x/${widget.imageUrl}";
          _fileExists = false;
        });
      }
    });
  }

  Future<dynamic> getMinioTokenResponse() async {
    token = ref.read(nestAuthProvider.notifier).token!;
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

  void saveFileToMinio(File? file) async {
    var response = await getMinioTokenResponse();

    debugPrint("AVATAR_EDIT: Minio reponse=> $response");
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

    var avatarFilename = path.basename(file!.path);
    final etag =
        await minio.fPutObject(defaultRealm, avatarFilename, file.path);
    logNoStack.i("uploaded file ${file.path} with etag $etag");

// set the person's api avatar_url
    currentPerson!.avatarUrl =
        "$defaultMinioEndpointUrl/$defaultRealm/$avatarFilename";

    ref.read(nestAuthProvider.notifier).updateCurrentUser(currentPerson!);
    var jsonDataStr = jsonEncode(currentPerson!);
    logNoStack.i(
        "AVATAR_EDIT: put url = $defaultAPIBaseUrl$defaultApiPrefixPath/persons");

    var responsePut = apiPutDataStrNoLocale(
        token!,
        "$defaultAPIBaseUrl$defaultApiPrefixPath/persons/${currentPerson!.id}",
        jsonDataStr);
    logNoStack.i(
        "AVATAR_EDIT put person is $responsePut saving ${currentPerson!.avatarUrl}");

// now refresh nestAvatar
    // ref.read(RefreshWidgetProvider(currentPerson!.code!).notifier).refresh();
    ref.read(RefreshWidgetProvider(currentPerson!.code!).notifier).refresh();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(
      maxWidth: 800,
      imageQuality: 50,
      source:
          source, // source can be either ImageSource.camera or ImageSource.gallery
      maxHeight: 800,
    );

    if (pickedFile != null) {
      final extension = pickedFile.path.split('.').last;

      var filecode = DateTime.now().toIso8601String();
      if (!kIsWeb) {
        logNoStack.i("DirectorySystemPath=${Directory.systemTemp.path}");
        logNoStack.i("CurrentPersonCode=${currentPerson!.code}");
        logNoStack.i("FileCode+ext $filecode.$extension");

        final newFile = File(
            '${Directory.systemTemp.path}/${currentPerson!.code}-avatar-$filecode.$extension');
        final showFile = File(pickedFile.path);

        await pickedFile.saveTo(newFile.path);
        logNoStack.i("AVATAR_EDIT: New path: ${newFile.path}");
      
      setState(() {
        _image = showFile;
        _fileExists = true;
      });
      
      // ref.read(minIOUploadProvider.notifier).uploadImageToMinIO(_image!);

      saveFileToMinio(newFile);
      } else {
                final showFile = File(pickedFile.path);
        logNoStack.i("AVATAR_EDIT: New path: $showFile");
      
      setState(() {
        _image = showFile;
        _fileExists = true;
      });
      }
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: Text(nt.t.account.avatar_url),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: Text(nt.t.account.take_a_picture),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    logNoStack.i(
        "AVATAR_EDIT: BUILD: url=[${widget.imageUrl == null ? 'IS NULL' : 'NOT NULL'}] _image=[$_image]");
    if (!_fileExists) {
      logNoStack.i("AVATAR_EDIT: BUILD:_image is NULL");
    } else {
      logNoStack.i("AVATAR_EDIT: BUILD:_image is NOT NULL");
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => _showImageSourceActionSheet(context),
          child: CircleAvatar(
            radius: widget.diameter,
            backgroundImage: _fileExists
                ? FileImage(_image!)
                : (_imageUrl != null
                        ? NetworkImage(_imageUrl!)
                        : const AssetImage('assets/images/default-avatar.webp'))
                    as ImageProvider,
            child: const Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                radius: 16,
                child: Icon(
                  Icons.camera_alt,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }
}
