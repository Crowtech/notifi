import 'dart:math';

import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../entities/user_role.dart';
import '../riverpod/current_user.dart';
import 'auth_controller.dart';
import 'package:logger/logger.dart' as logger;

import 'nest_auth2.dart';
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
  final isAuth = ref.watch(nestAuthProvider);
  // final userId = await ref.watch(
  //   authControllerProvider.selectAsync(
  //     (value) => value.map(
  //       signedIn: (signedIn) => signedIn.id,
  //       signedOut: (signedOut) => null,
  //     ),
  //   ),
  // );

  if (isAuth == false) return const UserRole.none();
  final user = ref.read(nestAuthProvider.notifier).currentUser;

  logNoStack.i("Permissions: User is ${user.toString()}");

  if (user.token == null) return const UserRole.none();

  bool hasExpired = JwtDecoder.isExpired(user.token!);
  if (hasExpired) {
    logNoStack.e("Permissions: User is ${user.toString()} token has expired");
    return const UserRole.none();
  }
  DateTime expirationDate = JwtDecoder.getExpirationDate(user.token!);

  // 2025-01-13 13:04:18.000
  logNoStack.i("${user.email} token expiry datetime is $expirationDate");
  // use token to extract roles
  Duration tokenTime = JwtDecoder.getTokenTime(user.token!);
  logNoStack.i("${user.email} token duration is ${tokenTime.inMinutes}");

  Map<String, dynamic> jwtMap = JwtDecoder.decode(user.token!);
  List rolesList = jwtMap['roles'];
  String rolesStr = "";
  for (var i = 0; i < rolesList.length; i++) {
    rolesStr += "${rolesList[i]}\n";
  }
  logNoStack.i("PERMISSIONS: Roles for ${user.email} are $rolesStr");

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
