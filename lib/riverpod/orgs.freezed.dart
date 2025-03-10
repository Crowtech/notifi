// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orgs.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Org _$OrgFromJson(Map<String, dynamic> json) {
  return _Org.fromJson(json);
}

/// @nodoc
mixin _$Org {
  int get orgid => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  DateTime get created => throw _privateConstructorUsedError;
  DateTime get updated => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String get devicecode => throw _privateConstructorUsedError;
  String get avatarUrl => throw _privateConstructorUsedError;
  GPS get gps => throw _privateConstructorUsedError;
  bool get selected => throw _privateConstructorUsedError;
  String get orgType => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  /// Serializes this Org to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Org
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrgCopyWith<Org> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrgCopyWith<$Res> {
  factory $OrgCopyWith(Org value, $Res Function(Org) then) =
      _$OrgCopyWithImpl<$Res, Org>;
  @useResult
  $Res call(
      {int orgid,
      int id,
      String code,
      DateTime created,
      DateTime updated,
      String name,
      String description,
      String location,
      String devicecode,
      String avatarUrl,
      GPS gps,
      bool selected,
      String orgType,
      String url});
}

/// @nodoc
class _$OrgCopyWithImpl<$Res, $Val extends Org> implements $OrgCopyWith<$Res> {
  _$OrgCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Org
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orgid = null,
    Object? id = null,
    Object? code = null,
    Object? created = null,
    Object? updated = null,
    Object? name = null,
    Object? description = null,
    Object? location = null,
    Object? devicecode = null,
    Object? avatarUrl = null,
    Object? gps = null,
    Object? selected = null,
    Object? orgType = null,
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      orgid: null == orgid
          ? _value.orgid
          : orgid // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updated: null == updated
          ? _value.updated
          : updated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      devicecode: null == devicecode
          ? _value.devicecode
          : devicecode // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      gps: null == gps
          ? _value.gps
          : gps // ignore: cast_nullable_to_non_nullable
              as GPS,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
      orgType: null == orgType
          ? _value.orgType
          : orgType // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrgImplCopyWith<$Res> implements $OrgCopyWith<$Res> {
  factory _$$OrgImplCopyWith(_$OrgImpl value, $Res Function(_$OrgImpl) then) =
      __$$OrgImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int orgid,
      int id,
      String code,
      DateTime created,
      DateTime updated,
      String name,
      String description,
      String location,
      String devicecode,
      String avatarUrl,
      GPS gps,
      bool selected,
      String orgType,
      String url});
}

/// @nodoc
class __$$OrgImplCopyWithImpl<$Res> extends _$OrgCopyWithImpl<$Res, _$OrgImpl>
    implements _$$OrgImplCopyWith<$Res> {
  __$$OrgImplCopyWithImpl(_$OrgImpl _value, $Res Function(_$OrgImpl) _then)
      : super(_value, _then);

  /// Create a copy of Org
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orgid = null,
    Object? id = null,
    Object? code = null,
    Object? created = null,
    Object? updated = null,
    Object? name = null,
    Object? description = null,
    Object? location = null,
    Object? devicecode = null,
    Object? avatarUrl = null,
    Object? gps = null,
    Object? selected = null,
    Object? orgType = null,
    Object? url = null,
  }) {
    return _then(_$OrgImpl(
      orgid: null == orgid
          ? _value.orgid
          : orgid // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updated: null == updated
          ? _value.updated
          : updated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      devicecode: null == devicecode
          ? _value.devicecode
          : devicecode // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      gps: null == gps
          ? _value.gps
          : gps // ignore: cast_nullable_to_non_nullable
              as GPS,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
      orgType: null == orgType
          ? _value.orgType
          : orgType // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrgImpl implements _Org {
  _$OrgImpl(
      {required this.orgid,
      required this.id,
      required this.code,
      required this.created,
      required this.updated,
      required this.name,
      required this.description,
      required this.location,
      required this.devicecode,
      required this.avatarUrl,
      required this.gps,
      required this.selected,
      required this.orgType,
      required this.url});

  factory _$OrgImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrgImplFromJson(json);

  @override
  final int orgid;
  @override
  final int id;
  @override
  final String code;
  @override
  final DateTime created;
  @override
  final DateTime updated;
  @override
  final String name;
  @override
  final String description;
  @override
  final String location;
  @override
  final String devicecode;
  @override
  final String avatarUrl;
  @override
  final GPS gps;
  @override
  final bool selected;
  @override
  final String orgType;
  @override
  final String url;

  @override
  String toString() {
    return 'Org(orgid: $orgid, id: $id, code: $code, created: $created, updated: $updated, name: $name, description: $description, location: $location, devicecode: $devicecode, avatarUrl: $avatarUrl, gps: $gps, selected: $selected, orgType: $orgType, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrgImpl &&
            (identical(other.orgid, orgid) || other.orgid == orgid) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.updated, updated) || other.updated == updated) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.devicecode, devicecode) ||
                other.devicecode == devicecode) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.gps, gps) || other.gps == gps) &&
            (identical(other.selected, selected) ||
                other.selected == selected) &&
            (identical(other.orgType, orgType) || other.orgType == orgType) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      orgid,
      id,
      code,
      created,
      updated,
      name,
      description,
      location,
      devicecode,
      avatarUrl,
      gps,
      selected,
      orgType,
      url);

  /// Create a copy of Org
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrgImplCopyWith<_$OrgImpl> get copyWith =>
      __$$OrgImplCopyWithImpl<_$OrgImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrgImplToJson(
      this,
    );
  }
}

abstract class _Org implements Org {
  factory _Org(
      {required final int orgid,
      required final int id,
      required final String code,
      required final DateTime created,
      required final DateTime updated,
      required final String name,
      required final String description,
      required final String location,
      required final String devicecode,
      required final String avatarUrl,
      required final GPS gps,
      required final bool selected,
      required final String orgType,
      required final String url}) = _$OrgImpl;

  factory _Org.fromJson(Map<String, dynamic> json) = _$OrgImpl.fromJson;

  @override
  int get orgid;
  @override
  int get id;
  @override
  String get code;
  @override
  DateTime get created;
  @override
  DateTime get updated;
  @override
  String get name;
  @override
  String get description;
  @override
  String get location;
  @override
  String get devicecode;
  @override
  String get avatarUrl;
  @override
  GPS get gps;
  @override
  bool get selected;
  @override
  String get orgType;
  @override
  String get url;

  /// Create a copy of Org
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrgImplCopyWith<_$OrgImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
