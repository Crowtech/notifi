// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fcm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Fcm {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      FirebaseOptions? firebaseOptions,
      String? vapidKey,
      int secondsToast,
      List<String> topics,
      String token,
    )
    active,
    required TResult Function() inactive,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      FirebaseOptions? firebaseOptions,
      String? vapidKey,
      int secondsToast,
      List<String> topics,
      String token,
    )?
    active,
    TResult? Function()? inactive,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      FirebaseOptions? firebaseOptions,
      String? vapidKey,
      int secondsToast,
      List<String> topics,
      String token,
    )?
    active,
    TResult Function()? inactive,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Active value) active,
    required TResult Function(Inactive value) inactive,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Active value)? active,
    TResult? Function(Inactive value)? inactive,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Active value)? active,
    TResult Function(Inactive value)? inactive,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FcmCopyWith<$Res> {
  factory $FcmCopyWith(Fcm value, $Res Function(Fcm) then) =
      _$FcmCopyWithImpl<$Res, Fcm>;
}

/// @nodoc
class _$FcmCopyWithImpl<$Res, $Val extends Fcm> implements $FcmCopyWith<$Res> {
  _$FcmCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Fcm
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ActiveImplCopyWith<$Res> {
  factory _$$ActiveImplCopyWith(
    _$ActiveImpl value,
    $Res Function(_$ActiveImpl) then,
  ) = __$$ActiveImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    FirebaseOptions? firebaseOptions,
    String? vapidKey,
    int secondsToast,
    List<String> topics,
    String token,
  });
}

/// @nodoc
class __$$ActiveImplCopyWithImpl<$Res>
    extends _$FcmCopyWithImpl<$Res, _$ActiveImpl>
    implements _$$ActiveImplCopyWith<$Res> {
  __$$ActiveImplCopyWithImpl(
    _$ActiveImpl _value,
    $Res Function(_$ActiveImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Fcm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firebaseOptions = freezed,
    Object? vapidKey = freezed,
    Object? secondsToast = null,
    Object? topics = null,
    Object? token = null,
  }) {
    return _then(
      _$ActiveImpl(
        firebaseOptions:
            freezed == firebaseOptions
                ? _value.firebaseOptions
                : firebaseOptions // ignore: cast_nullable_to_non_nullable
                    as FirebaseOptions?,
        vapidKey:
            freezed == vapidKey
                ? _value.vapidKey
                : vapidKey // ignore: cast_nullable_to_non_nullable
                    as String?,
        secondsToast:
            null == secondsToast
                ? _value.secondsToast
                : secondsToast // ignore: cast_nullable_to_non_nullable
                    as int,
        topics:
            null == topics
                ? _value._topics
                : topics // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        token:
            null == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$ActiveImpl extends Active {
  const _$ActiveImpl({
    required this.firebaseOptions,
    required this.vapidKey,
    required this.secondsToast,
    required final List<String> topics,
    required this.token,
  }) : _topics = topics,
       super._();

  @override
  final FirebaseOptions? firebaseOptions;
  @override
  final String? vapidKey;
  @override
  final int secondsToast;
  final List<String> _topics;
  @override
  List<String> get topics {
    if (_topics is EqualUnmodifiableListView) return _topics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topics);
  }

  @override
  final String token;

  @override
  String toString() {
    return 'Fcm.active(firebaseOptions: $firebaseOptions, vapidKey: $vapidKey, secondsToast: $secondsToast, topics: $topics, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveImpl &&
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
  int get hashCode => Object.hash(
    runtimeType,
    firebaseOptions,
    vapidKey,
    secondsToast,
    const DeepCollectionEquality().hash(_topics),
    token,
  );

  /// Create a copy of Fcm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveImplCopyWith<_$ActiveImpl> get copyWith =>
      __$$ActiveImplCopyWithImpl<_$ActiveImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      FirebaseOptions? firebaseOptions,
      String? vapidKey,
      int secondsToast,
      List<String> topics,
      String token,
    )
    active,
    required TResult Function() inactive,
  }) {
    return active(firebaseOptions, vapidKey, secondsToast, topics, token);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      FirebaseOptions? firebaseOptions,
      String? vapidKey,
      int secondsToast,
      List<String> topics,
      String token,
    )?
    active,
    TResult? Function()? inactive,
  }) {
    return active?.call(firebaseOptions, vapidKey, secondsToast, topics, token);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      FirebaseOptions? firebaseOptions,
      String? vapidKey,
      int secondsToast,
      List<String> topics,
      String token,
    )?
    active,
    TResult Function()? inactive,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active(firebaseOptions, vapidKey, secondsToast, topics, token);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Active value) active,
    required TResult Function(Inactive value) inactive,
  }) {
    return active(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Active value)? active,
    TResult? Function(Inactive value)? inactive,
  }) {
    return active?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Active value)? active,
    TResult Function(Inactive value)? inactive,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active(this);
    }
    return orElse();
  }
}

abstract class Active extends Fcm {
  const factory Active({
    required final FirebaseOptions? firebaseOptions,
    required final String? vapidKey,
    required final int secondsToast,
    required final List<String> topics,
    required final String token,
  }) = _$ActiveImpl;
  const Active._() : super._();

  FirebaseOptions? get firebaseOptions;
  String? get vapidKey;
  int get secondsToast;
  List<String> get topics;
  String get token;

  /// Create a copy of Fcm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActiveImplCopyWith<_$ActiveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InactiveImplCopyWith<$Res> {
  factory _$$InactiveImplCopyWith(
    _$InactiveImpl value,
    $Res Function(_$InactiveImpl) then,
  ) = __$$InactiveImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InactiveImplCopyWithImpl<$Res>
    extends _$FcmCopyWithImpl<$Res, _$InactiveImpl>
    implements _$$InactiveImplCopyWith<$Res> {
  __$$InactiveImplCopyWithImpl(
    _$InactiveImpl _value,
    $Res Function(_$InactiveImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Fcm
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InactiveImpl extends Inactive {
  const _$InactiveImpl() : super._();

  @override
  String toString() {
    return 'Fcm.inactive()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InactiveImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      FirebaseOptions? firebaseOptions,
      String? vapidKey,
      int secondsToast,
      List<String> topics,
      String token,
    )
    active,
    required TResult Function() inactive,
  }) {
    return inactive();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      FirebaseOptions? firebaseOptions,
      String? vapidKey,
      int secondsToast,
      List<String> topics,
      String token,
    )?
    active,
    TResult? Function()? inactive,
  }) {
    return inactive?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      FirebaseOptions? firebaseOptions,
      String? vapidKey,
      int secondsToast,
      List<String> topics,
      String token,
    )?
    active,
    TResult Function()? inactive,
    required TResult orElse(),
  }) {
    if (inactive != null) {
      return inactive();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Active value) active,
    required TResult Function(Inactive value) inactive,
  }) {
    return inactive(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Active value)? active,
    TResult? Function(Inactive value)? inactive,
  }) {
    return inactive?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Active value)? active,
    TResult Function(Inactive value)? inactive,
    required TResult orElse(),
  }) {
    if (inactive != null) {
      return inactive(this);
    }
    return orElse();
  }
}

abstract class Inactive extends Fcm {
  const factory Inactive() = _$InactiveImpl;
  const Inactive._() : super._();
}
