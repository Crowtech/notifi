// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'norganization_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NOrganizationsResponse {
  @JsonKey(name: 'startIndex')
  int get startIndex;
  @JsonKey(name: 'items')
  List<NOrganization> get items;
  @JsonKey(name: 'resultCount')
  int get resultCount;
  @JsonKey(name: 'totalItems')
  int get totalItems;
  List<String> get errors;

  /// Create a copy of NOrganizationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NOrganizationsResponseCopyWith<NOrganizationsResponse> get copyWith =>
      _$NOrganizationsResponseCopyWithImpl<NOrganizationsResponse>(
          this as NOrganizationsResponse, _$identity);

  /// Serializes this NOrganizationsResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NOrganizationsResponse &&
            (identical(other.startIndex, startIndex) ||
                other.startIndex == startIndex) &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.resultCount, resultCount) ||
                other.resultCount == resultCount) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            const DeepCollectionEquality().equals(other.errors, errors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      startIndex,
      const DeepCollectionEquality().hash(items),
      resultCount,
      totalItems,
      const DeepCollectionEquality().hash(errors));

  @override
  String toString() {
    return 'NOrganizationsResponse(startIndex: $startIndex, items: $items, resultCount: $resultCount, totalItems: $totalItems, errors: $errors)';
  }
}

/// @nodoc
abstract mixin class $NOrganizationsResponseCopyWith<$Res> {
  factory $NOrganizationsResponseCopyWith(NOrganizationsResponse value,
          $Res Function(NOrganizationsResponse) _then) =
      _$NOrganizationsResponseCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'startIndex') int startIndex,
      @JsonKey(name: 'items') List<NOrganization> items,
      @JsonKey(name: 'resultCount') int resultCount,
      @JsonKey(name: 'totalItems') int totalItems,
      List<String> errors});
}

/// @nodoc
class _$NOrganizationsResponseCopyWithImpl<$Res>
    implements $NOrganizationsResponseCopyWith<$Res> {
  _$NOrganizationsResponseCopyWithImpl(this._self, this._then);

  final NOrganizationsResponse _self;
  final $Res Function(NOrganizationsResponse) _then;

  /// Create a copy of NOrganizationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startIndex = null,
    Object? items = null,
    Object? resultCount = null,
    Object? totalItems = null,
    Object? errors = null,
  }) {
    return _then(_self.copyWith(
      startIndex: null == startIndex
          ? _self.startIndex
          : startIndex // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<NOrganization>,
      resultCount: null == resultCount
          ? _self.resultCount
          : resultCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalItems: null == totalItems
          ? _self.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      errors: null == errors
          ? _self.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _NOrganizationsResponse implements NOrganizationsResponse {
  _NOrganizationsResponse(
      {@JsonKey(name: 'startIndex') required this.startIndex,
      @JsonKey(name: 'items') required final List<NOrganization> items,
      @JsonKey(name: 'resultCount') required this.resultCount,
      @JsonKey(name: 'totalItems') required this.totalItems,
      final List<String> errors = const []})
      : _items = items,
        _errors = errors;
  factory _NOrganizationsResponse.fromJson(Map<String, dynamic> json) =>
      _$NOrganizationsResponseFromJson(json);

  @override
  @JsonKey(name: 'startIndex')
  final int startIndex;
  final List<NOrganization> _items;
  @override
  @JsonKey(name: 'items')
  List<NOrganization> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey(name: 'resultCount')
  final int resultCount;
  @override
  @JsonKey(name: 'totalItems')
  final int totalItems;
  final List<String> _errors;
  @override
  @JsonKey()
  List<String> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  /// Create a copy of NOrganizationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NOrganizationsResponseCopyWith<_NOrganizationsResponse> get copyWith =>
      __$NOrganizationsResponseCopyWithImpl<_NOrganizationsResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NOrganizationsResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NOrganizationsResponse &&
            (identical(other.startIndex, startIndex) ||
                other.startIndex == startIndex) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.resultCount, resultCount) ||
                other.resultCount == resultCount) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      startIndex,
      const DeepCollectionEquality().hash(_items),
      resultCount,
      totalItems,
      const DeepCollectionEquality().hash(_errors));

  @override
  String toString() {
    return 'NOrganizationsResponse(startIndex: $startIndex, items: $items, resultCount: $resultCount, totalItems: $totalItems, errors: $errors)';
  }
}

/// @nodoc
abstract mixin class _$NOrganizationsResponseCopyWith<$Res>
    implements $NOrganizationsResponseCopyWith<$Res> {
  factory _$NOrganizationsResponseCopyWith(_NOrganizationsResponse value,
          $Res Function(_NOrganizationsResponse) _then) =
      __$NOrganizationsResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'startIndex') int startIndex,
      @JsonKey(name: 'items') List<NOrganization> items,
      @JsonKey(name: 'resultCount') int resultCount,
      @JsonKey(name: 'totalItems') int totalItems,
      List<String> errors});
}

/// @nodoc
class __$NOrganizationsResponseCopyWithImpl<$Res>
    implements _$NOrganizationsResponseCopyWith<$Res> {
  __$NOrganizationsResponseCopyWithImpl(this._self, this._then);

  final _NOrganizationsResponse _self;
  final $Res Function(_NOrganizationsResponse) _then;

  /// Create a copy of NOrganizationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? startIndex = null,
    Object? items = null,
    Object? resultCount = null,
    Object? totalItems = null,
    Object? errors = null,
  }) {
    return _then(_NOrganizationsResponse(
      startIndex: null == startIndex
          ? _self.startIndex
          : startIndex // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<NOrganization>,
      resultCount: null == resultCount
          ? _self.resultCount
          : resultCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalItems: null == totalItems
          ? _self.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      errors: null == errors
          ? _self._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
