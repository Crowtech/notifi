// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_role.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserRole {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is UserRole);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'UserRole()';
  }
}

/// @nodoc
class $UserRoleCopyWith<$Res> {
  $UserRoleCopyWith(UserRole _, $Res Function(UserRole) __);
}

/// @nodoc

class Admin implements UserRole {
  const Admin();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Admin);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'UserRole.admin()';
  }
}

/// @nodoc

class Dev implements UserRole {
  const Dev();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Dev);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'UserRole.dev()';
  }
}

/// @nodoc

class User implements UserRole {
  const User();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is User);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'UserRole.user()';
  }
}

/// @nodoc

class Guest implements UserRole {
  const Guest();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Guest);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'UserRole.guest()';
  }
}

/// @nodoc

class None implements UserRole {
  const None();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is None);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'UserRole.none()';
  }
}

// dart format on
