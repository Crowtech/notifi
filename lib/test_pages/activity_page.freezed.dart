// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  return _Activity.fromJson(json);
}

/// @nodoc
mixin _$Activity {
  String get activity => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  int get participants => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;

  /// Serializes this Activity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivityCopyWith<Activity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityCopyWith<$Res> {
  factory $ActivityCopyWith(Activity value, $Res Function(Activity) then) =
      _$ActivityCopyWithImpl<$Res, Activity>;
  @useResult
  $Res call({String activity, String type, int participants, double price});
}

/// @nodoc
class _$ActivityCopyWithImpl<$Res, $Val extends Activity>
    implements $ActivityCopyWith<$Res> {
  _$ActivityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activity = null,
    Object? type = null,
    Object? participants = null,
    Object? price = null,
  }) {
    return _then(_value.copyWith(
      activity: null == activity
          ? _value.activity
          : activity // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      participants: null == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActivityImplCopyWith<$Res>
    implements $ActivityCopyWith<$Res> {
  factory _$$ActivityImplCopyWith(
          _$ActivityImpl value, $Res Function(_$ActivityImpl) then) =
      __$$ActivityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String activity, String type, int participants, double price});
}

/// @nodoc
class __$$ActivityImplCopyWithImpl<$Res>
    extends _$ActivityCopyWithImpl<$Res, _$ActivityImpl>
    implements _$$ActivityImplCopyWith<$Res> {
  __$$ActivityImplCopyWithImpl(
      _$ActivityImpl _value, $Res Function(_$ActivityImpl) _then)
      : super(_value, _then);

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activity = null,
    Object? type = null,
    Object? participants = null,
    Object? price = null,
  }) {
    return _then(_$ActivityImpl(
      activity: null == activity
          ? _value.activity
          : activity // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      participants: null == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivityImpl implements _Activity {
  _$ActivityImpl(
      {required this.activity,
      required this.type,
      required this.participants,
      required this.price});

  factory _$ActivityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityImplFromJson(json);

  @override
  final String activity;
  @override
  final String type;
  @override
  final int participants;
  @override
  final double price;

  @override
  String toString() {
    return 'Activity(activity: $activity, type: $type, participants: $participants, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityImpl &&
            (identical(other.activity, activity) ||
                other.activity == activity) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.participants, participants) ||
                other.participants == participants) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, activity, type, participants, price);

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityImplCopyWith<_$ActivityImpl> get copyWith =>
      __$$ActivityImplCopyWithImpl<_$ActivityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityImplToJson(
      this,
    );
  }
}

abstract class _Activity implements Activity {
  factory _Activity(
      {required final String activity,
      required final String type,
      required final int participants,
      required final double price}) = _$ActivityImpl;

  factory _Activity.fromJson(Map<String, dynamic> json) =
      _$ActivityImpl.fromJson;

  @override
  String get activity;
  @override
  String get type;
  @override
  int get participants;
  @override
  double get price;

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivityImplCopyWith<_$ActivityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
