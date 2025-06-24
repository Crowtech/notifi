// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orgs.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Org {
  int get orgid;
  int get id;
  String get code;
  DateTime get created;
  DateTime get updated;
  String get name;
  String get description;
  String get location;
  String get devicecode;
  String get avatarUrl;
  GPS get gps;
  bool get selected;
  String get orgType;
  String get url;

  /// Create a copy of Org
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OrgCopyWith<Org> get copyWith =>
      _$OrgCopyWithImpl<Org>(this as Org, _$identity);

  /// Serializes this Org to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Org &&
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

  @override
  String toString() {
    return 'Org(orgid: $orgid, id: $id, code: $code, created: $created, updated: $updated, name: $name, description: $description, location: $location, devicecode: $devicecode, avatarUrl: $avatarUrl, gps: $gps, selected: $selected, orgType: $orgType, url: $url)';
  }
}

/// @nodoc
abstract mixin class $OrgCopyWith<$Res> {
  factory $OrgCopyWith(Org value, $Res Function(Org) _then) = _$OrgCopyWithImpl;
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
class _$OrgCopyWithImpl<$Res> implements $OrgCopyWith<$Res> {
  _$OrgCopyWithImpl(this._self, this._then);

  final Org _self;
  final $Res Function(Org) _then;

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
    return _then(_self.copyWith(
      orgid: null == orgid
          ? _self.orgid
          : orgid // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _self.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updated: null == updated
          ? _self.updated
          : updated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      devicecode: null == devicecode
          ? _self.devicecode
          : devicecode // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      gps: null == gps
          ? _self.gps
          : gps // ignore: cast_nullable_to_non_nullable
              as GPS,
      selected: null == selected
          ? _self.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
      orgType: null == orgType
          ? _self.orgType
          : orgType // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Org implements Org {
  _Org(
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
  factory _Org.fromJson(Map<String, dynamic> json) => _$OrgFromJson(json);

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

  /// Create a copy of Org
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OrgCopyWith<_Org> get copyWith =>
      __$OrgCopyWithImpl<_Org>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OrgToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Org &&
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

  @override
  String toString() {
    return 'Org(orgid: $orgid, id: $id, code: $code, created: $created, updated: $updated, name: $name, description: $description, location: $location, devicecode: $devicecode, avatarUrl: $avatarUrl, gps: $gps, selected: $selected, orgType: $orgType, url: $url)';
  }
}

/// @nodoc
abstract mixin class _$OrgCopyWith<$Res> implements $OrgCopyWith<$Res> {
  factory _$OrgCopyWith(_Org value, $Res Function(_Org) _then) =
      __$OrgCopyWithImpl;
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
class __$OrgCopyWithImpl<$Res> implements _$OrgCopyWith<$Res> {
  __$OrgCopyWithImpl(this._self, this._then);

  final _Org _self;
  final $Res Function(_Org) _then;

  /// Create a copy of Org
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_Org(
      orgid: null == orgid
          ? _self.orgid
          : orgid // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _self.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updated: null == updated
          ? _self.updated
          : updated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      devicecode: null == devicecode
          ? _self.devicecode
          : devicecode // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      gps: null == gps
          ? _self.gps
          : gps // ignore: cast_nullable_to_non_nullable
              as GPS,
      selected: null == selected
          ? _self.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
      orgType: null == orgType
          ? _self.orgType
          : orgType // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
