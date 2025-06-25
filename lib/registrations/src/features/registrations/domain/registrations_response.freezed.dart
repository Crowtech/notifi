// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registrations_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegistrationsResponse {
  int get startIndex;
  List<Registration> get items;
  int get resultCount;
  int get totalItems;

  /// Create a copy of RegistrationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RegistrationsResponseCopyWith<RegistrationsResponse> get copyWith =>
      _$RegistrationsResponseCopyWithImpl<RegistrationsResponse>(
          this as RegistrationsResponse, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RegistrationsResponse &&
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
    return 'RegistrationsResponse(startIndex: $startIndex, items: $items, resultCount: $resultCount, totalItems: $totalItems)';
  }
}

/// @nodoc
abstract mixin class $RegistrationsResponseCopyWith<$Res> {
  factory $RegistrationsResponseCopyWith(RegistrationsResponse value,
          $Res Function(RegistrationsResponse) _then) =
      _$RegistrationsResponseCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'startIndex') int startIndex,
      @JsonKey(name: 'items') List<Registration> items,
      @JsonKey(name: 'resultCount') int resultCount,
      @JsonKey(name: 'totalItems') int totalItems});
}

/// @nodoc
class _$RegistrationsResponseCopyWithImpl<$Res>
    implements $RegistrationsResponseCopyWith<$Res> {
  _$RegistrationsResponseCopyWithImpl(this._self, this._then);

  final RegistrationsResponse _self;
  final $Res Function(RegistrationsResponse) _then;

  /// Create a copy of RegistrationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startIndex = null,
    Object? items = null,
    Object? resultCount = null,
    Object? totalItems = null,
  }) {
    return _then(RegistrationsResponse(
      startIndex: null == startIndex
          ? _self.startIndex
          : startIndex // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Registration>,
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
