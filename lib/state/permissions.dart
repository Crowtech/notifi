import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../entities/user_role.dart';
import 'auth_controller.dart';
import 'package:logger/logger.dart' as logger;
part 'permissions.g.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);


/// If our user is signed out, this provider returns [UserRole.none]
/// Otherwise, it mocks a network request and gives out some [UserRole].
@riverpod
Future<UserRole> permissions(PermissionsRef ref) async {
  final userId = await ref.watch(
    authControllerProvider.selectAsync(
      (value) => value.map(
        signedIn: (signedIn) => signedIn.id,
        signedOut: (signedOut) => null,
      ),
    ),
  );

  if (userId == null) return const UserRole.none();

  logNoStack.i("Permissions from the user are set here! the id of the user is $userId");

  return _requestMock();
}

/// Gives a random [UserRole] based on a dice roll.
UserRole _requestMock() {
  // mock
  final random = Random().nextDouble();

  if (random < 0.25) {
    return const UserRole.admin();
  } else if (random < 0.5) {
    return const UserRole.user();
  } else {
    return const UserRole.guest();
  }
}
