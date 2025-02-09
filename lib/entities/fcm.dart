import 'package:firebase_core/firebase_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fcm.freezed.dart';

/// NotifiConfig class for this sample application.
/// It should be self-explanatory.
@freezed
sealed class Fcm with _$Fcm {
  const factory Fcm.active({
  required FirebaseOptions? firebaseOptions,
  required String? vapidKey,
  required int secondsToast,
  required List<String> topics,
  required String token,
  }) = Active;
  const Fcm._();
  const factory Fcm.inactive() = Inactive;
  bool get isFcm => switch (this) {
        Active() => true,
        Inactive() => false,
      };

}
