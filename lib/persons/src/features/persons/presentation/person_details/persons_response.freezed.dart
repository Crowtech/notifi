// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'persons_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PersonsResponse {
  @JsonKey(name: 'startIndex')
  int? get startIndex;
  @JsonKey(name: 'items')
  List<Person>? get items;
  @JsonKey(name: 'resultCount')
  int? get resultCount;
  @JsonKey(name: 'totalItems')
  int? get totalItems;

  /// Create a copy of PersonsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PersonsResponseCopyWith<PersonsResponse> get copyWith =>
      _$PersonsResponseCopyWithImpl<PersonsResponse>(
          this as PersonsResponse, _$identity);

  /// Serializes this PersonsResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PersonsResponse &&
            (identical(other.startIndex, startIndex) ||
                other.startIndex == startIndex) &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.resultCount, resultCount) ||
                other.resultCount == resultCount) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, startIndex,
      const DeepCollectionEquality().hash(items), resultCount, totalItems);

  @override
  String toString() {
    return 'PersonsResponse(startIndex: $startIndex, items: $items, resultCount: $resultCount, totalItems: $totalItems)';
  }
}

/// @nodoc
abstract mixin class $PersonsResponseCopyWith<$Res> {
  factory $PersonsResponseCopyWith(
          PersonsResponse value, $Res Function(PersonsResponse) _then) =
      _$PersonsResponseCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'startIndex') int? startIndex,
      @JsonKey(name: 'items') List<Person>? items,
      @JsonKey(name: 'resultCount') int? resultCount,
      @JsonKey(name: 'totalItems') int? totalItems});
}

/// @nodoc
class _$PersonsResponseCopyWithImpl<$Res>
    implements $PersonsResponseCopyWith<$Res> {
  _$PersonsResponseCopyWithImpl(this._self, this._then);

  final PersonsResponse _self;
  final $Res Function(PersonsResponse) _then;

  /// Create a copy of PersonsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startIndex = freezed,
    Object? items = freezed,
    Object? resultCount = freezed,
    Object? totalItems = freezed,
  }) {
    return _then(_self.copyWith(
      startIndex: freezed == startIndex
          ? _self.startIndex
          : startIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      items: freezed == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Person>?,
      resultCount: freezed == resultCount
          ? _self.resultCount
          : resultCount // ignore: cast_nullable_to_non_nullable
              as int?,
      totalItems: freezed == totalItems
          ? _self.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PersonsResponse implements PersonsResponse {
  const _PersonsResponse(
      {@JsonKey(name: 'startIndex') this.startIndex,
      @JsonKey(name: 'items') final List<Person>? items,
      @JsonKey(name: 'resultCount') this.resultCount,
      @JsonKey(name: 'totalItems') this.totalItems})
      : _items = items;
  factory _PersonsResponse.fromJson(Map<String, dynamic> json) =>
      _$PersonsResponseFromJson(json);

  @override
  @JsonKey(name: 'startIndex')
  final int? startIndex;
  final List<Person>? _items;
  @override
  @JsonKey(name: 'items')
  List<Person>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'resultCount')
  final int? resultCount;
  @override
  @JsonKey(name: 'totalItems')
  final int? totalItems;

  /// Create a copy of PersonsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PersonsResponseCopyWith<_PersonsResponse> get copyWith =>
      __$PersonsResponseCopyWithImpl<_PersonsResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PersonsResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PersonsResponse &&
            (identical(other.startIndex, startIndex) ||
                other.startIndex == startIndex) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.resultCount, resultCount) ||
                other.resultCount == resultCount) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, startIndex,
      const DeepCollectionEquality().hash(_items), resultCount, totalItems);

  @override
  String toString() {
    return 'PersonsResponse(startIndex: $startIndex, items: $items, resultCount: $resultCount, totalItems: $totalItems)';
  }
}

/// @nodoc
abstract mixin class _$PersonsResponseCopyWith<$Res>
    implements $PersonsResponseCopyWith<$Res> {
  factory _$PersonsResponseCopyWith(
          _PersonsResponse value, $Res Function(_PersonsResponse) _then) =
      __$PersonsResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'startIndex') int? startIndex,
      @JsonKey(name: 'items') List<Person>? items,
      @JsonKey(name: 'resultCount') int? resultCount,
      @JsonKey(name: 'totalItems') int? totalItems});
}

/// @nodoc
class __$PersonsResponseCopyWithImpl<$Res>
    implements _$PersonsResponseCopyWith<$Res> {
  __$PersonsResponseCopyWithImpl(this._self, this._then);

  final _PersonsResponse _self;
  final $Res Function(_PersonsResponse) _then;

  /// Create a copy of PersonsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? startIndex = freezed,
    Object? items = freezed,
    Object? resultCount = freezed,
    Object? totalItems = freezed,
  }) {
    return _then(_PersonsResponse(
      startIndex: freezed == startIndex
          ? _self.startIndex
          : startIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      items: freezed == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Person>?,
      resultCount: freezed == resultCount
          ? _self.resultCount
          : resultCount // ignore: cast_nullable_to_non_nullable
              as int?,
      totalItems: freezed == totalItems
          ? _self.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
