// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organizations_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrganizationsResponse {
  int get startIndex;
  List<Organization> get items;
  int get resultCount;
  int get totalItems;

  /// Create a copy of OrganizationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OrganizationsResponseCopyWith<OrganizationsResponse> get copyWith =>
      _$OrganizationsResponseCopyWithImpl<OrganizationsResponse>(
          this as OrganizationsResponse, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OrganizationsResponse &&
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
    return 'OrganizationsResponse(startIndex: $startIndex, items: $items, resultCount: $resultCount, totalItems: $totalItems)';
  }
}

/// @nodoc
abstract mixin class $OrganizationsResponseCopyWith<$Res> {
  factory $OrganizationsResponseCopyWith(OrganizationsResponse value,
          $Res Function(OrganizationsResponse) _then) =
      _$OrganizationsResponseCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'startIndex') int startIndex,
      @JsonKey(name: 'items') List<Organization> items,
      @JsonKey(name: 'resultCount') int resultCount,
      @JsonKey(name: 'totalItems') int totalItems});
}

/// @nodoc
class _$OrganizationsResponseCopyWithImpl<$Res>
    implements $OrganizationsResponseCopyWith<$Res> {
  _$OrganizationsResponseCopyWithImpl(this._self, this._then);

  final OrganizationsResponse _self;
  final $Res Function(OrganizationsResponse) _then;

  /// Create a copy of OrganizationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startIndex = null,
    Object? items = null,
    Object? resultCount = null,
    Object? totalItems = null,
  }) {
    return _then(OrganizationsResponse(
      startIndex: null == startIndex
          ? _self.startIndex
          : startIndex // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Organization>,
      resultCount: null == resultCount
          ? _self.resultCount
          : resultCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalItems: null == totalItems
          ? _self.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
