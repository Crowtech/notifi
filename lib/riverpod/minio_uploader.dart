import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:notifi/credentials.dart';
import 'package:riverpod/riverpod.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;

class MinIOUploadNotifier extends StateNotifier<AsyncValue<String>> {
  MinIOUploadNotifier() : super(const AsyncValue.loading());

  Future<void> uploadImageToMinIO(File image) async {
    state = const AsyncValue.loading();
    final url = "$defaultMinioEndpointUrl/$defaultRealm"; 
    final request = http.MultipartRequest('POST', Uri.parse(url));

    var pic = await http.MultipartFile.fromPath('file', image.path);
    request.files.add(pic);

    try {
      final streamedResponse = await request.send();
      if (streamedResponse.statusCode == 200) {
        state = AsyncValue.data(nt.t.image_uploaded_success);
      } else {
        throw Exception(nt.t.image_uploaded_failure);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final minIOUploadProvider = StateNotifierProvider<MinIOUploadNotifier, AsyncValue<String>>((ref) => MinIOUploadNotifier());
