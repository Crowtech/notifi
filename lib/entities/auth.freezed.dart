// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Auth {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Auth);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Auth()';
  }
}

/// @nodoc
class $AuthCopyWith<$Res> {
  $AuthCopyWith(Auth _, $Res Function(Auth) __);
}

/// @nodoc

class SignedIn extends Auth {
  const SignedIn(
      {required this.id,
      required this.displayName,
      required this.email,
      required this.resourcecode,
      required this.token})
      : super._();

  final int id;
  final String displayName;
  final String email;
  final String resourcecode;
  final String token;

  /// Create a copy of Auth
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignedInCopyWith<SignedIn> get copyWith =>
      _$SignedInCopyWithImpl<SignedIn>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignedIn &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.resourcecode, resourcecode) ||
                other.resourcecode == resourcecode) &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, displayName, email, resourcecode, token);

  @override
  String toString() {
    return 'Auth.signedIn(id: $id, displayName: $displayName, email: $email, resourcecode: $resourcecode, token: $token)';
  }
}

/// @nodoc
abstract mixin class $SignedInCopyWith<$Res> implements $AuthCopyWith<$Res> {
  factory $SignedInCopyWith(SignedIn value, $Res Function(SignedIn) _then) =
      _$SignedInCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String displayName,
      String email,
      String resourcecode,
      String token});
}

/// @nodoc
class _$SignedInCopyWithImpl<$Res> implements $SignedInCopyWith<$Res> {
  _$SignedInCopyWithImpl(this._self, this._then);

  final SignedIn _self;
  final $Res Function(SignedIn) _then;

  /// Create a copy of Auth
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? email = null,
    Object? resourcecode = null,
    Object? token = null,
  }) {
    return _then(SignedIn(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      resourcecode: null == resourcecode
          ? _self.resourcecode
          : resourcecode // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class SignedOut extends Auth {
  const SignedOut() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SignedOut);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Auth.signedOut()';
  }
}

// dart format on
