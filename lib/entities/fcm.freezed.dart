// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fcm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Fcm {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Fcm);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Fcm()';
  }
}

/// @nodoc
class $FcmCopyWith<$Res> {
  $FcmCopyWith(Fcm _, $Res Function(Fcm) __);
}

/// @nodoc

class Active extends Fcm {
  const Active(
      {required this.firebaseOptions,
      required this.vapidKey,
      required this.secondsToast,
      required final List<String> topics,
      required this.token})
      : _topics = topics,
        super._();

  final FirebaseOptions? firebaseOptions;
  final String? vapidKey;
  final int secondsToast;
  final List<String> _topics;
  List<String> get topics {
    if (_topics is EqualUnmodifiableListView) return _topics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topics);
  }

  final String token;

  /// Create a copy of Fcm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ActiveCopyWith<Active> get copyWith =>
      _$ActiveCopyWithImpl<Active>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Active &&
            (identical(other.firebaseOptions, firebaseOptions) ||
                other.firebaseOptions == firebaseOptions) &&
            (identical(other.vapidKey, vapidKey) ||
                other.vapidKey == vapidKey) &&
            (identical(other.secondsToast, secondsToast) ||
                other.secondsToast == secondsToast) &&
            const DeepCollectionEquality().equals(other._topics, _topics) &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(runtimeType, firebaseOptions, vapidKey,
      secondsToast, const DeepCollectionEquality().hash(_topics), token);

  @override
  String toString() {
    return 'Fcm.active(firebaseOptions: $firebaseOptions, vapidKey: $vapidKey, secondsToast: $secondsToast, topics: $topics, token: $token)';
  }
}

/// @nodoc
abstract mixin class $ActiveCopyWith<$Res> implements $FcmCopyWith<$Res> {
  factory $ActiveCopyWith(Active value, $Res Function(Active) _then) =
      _$ActiveCopyWithImpl;
  @useResult
  $Res call(
      {FirebaseOptions? firebaseOptions,
      String? vapidKey,
      int secondsToast,
      List<String> topics,
      String token});
}

/// @nodoc
class _$ActiveCopyWithImpl<$Res> implements $ActiveCopyWith<$Res> {
  _$ActiveCopyWithImpl(this._self, this._then);

  final Active _self;
  final $Res Function(Active) _then;

  /// Create a copy of Fcm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? firebaseOptions = freezed,
    Object? vapidKey = freezed,
    Object? secondsToast = null,
    Object? topics = null,
    Object? token = null,
  }) {
    return _then(Active(
      firebaseOptions: freezed == firebaseOptions
          ? _self.firebaseOptions
          : firebaseOptions // ignore: cast_nullable_to_non_nullable
              as FirebaseOptions?,
      vapidKey: freezed == vapidKey
          ? _self.vapidKey
          : vapidKey // ignore: cast_nullable_to_non_nullable
              as String?,
      secondsToast: null == secondsToast
          ? _self.secondsToast
          : secondsToast // ignore: cast_nullable_to_non_nullable
              as int,
      topics: null == topics
          ? _self._topics
          : topics // ignore: cast_nullable_to_non_nullable
              as List<String>,
      token: null == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class Inactive extends Fcm {
  const Inactive() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Inactive);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Fcm.inactive()';
  }
}

// dart format on
