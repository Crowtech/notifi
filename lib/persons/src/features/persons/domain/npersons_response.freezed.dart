// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'npersons_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NPersonsResponse {
  int get startIndex;
  set startIndex(int value);
  List<Person>? get items;
  set items(List<Person>? value);
  int? get resultCount;
  set resultCount(int? value);
  int? get totalItems;
  set totalItems(int? value);

  /// Create a copy of NPersonsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NPersonsResponseCopyWith<NPersonsResponse> get copyWith =>
      _$NPersonsResponseCopyWithImpl<NPersonsResponse>(
          this as NPersonsResponse, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NPersonsResponse &&
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
    return 'NPersonsResponse(startIndex: $startIndex, items: $items, resultCount: $resultCount, totalItems: $totalItems)';
  }
}

/// @nodoc
abstract mixin class $NPersonsResponseCopyWith<$Res> {
  factory $NPersonsResponseCopyWith(
          NPersonsResponse value, $Res Function(NPersonsResponse) _then) =
      _$NPersonsResponseCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'startIndex') int startIndex,
      @JsonKey(name: 'items') List<Person>? items,
      @JsonKey(name: 'resultCount') int? resultCount,
      @JsonKey(name: 'totalItems') int? totalItems});
}

/// @nodoc
class _$NPersonsResponseCopyWithImpl<$Res>
    implements $NPersonsResponseCopyWith<$Res> {
  _$NPersonsResponseCopyWithImpl(this._self, this._then);

  final NPersonsResponse _self;
  final $Res Function(NPersonsResponse) _then;

  /// Create a copy of NPersonsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startIndex = null,
    Object? items = freezed,
    Object? resultCount = freezed,
    Object? totalItems = freezed,
  }) {
    return _then(NPersonsResponse(
      startIndex: null == startIndex
          ? _self.startIndex
          : startIndex // ignore: cast_nullable_to_non_nullable
              as int,
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

// dart format on
