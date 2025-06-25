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
  @JsonKey(name: 'startIndex')
  int get startIndex;
  @JsonKey(name: 'items')
  List<Registration> get items;
  @JsonKey(name: 'total_results')
  int get totalResults;
  @JsonKey(name: 'totalItems')
  int get totalItems;
  List<String> get errors;

  /// Create a copy of RegistrationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RegistrationsResponseCopyWith<RegistrationsResponse> get copyWith =>
      _$RegistrationsResponseCopyWithImpl<RegistrationsResponse>(
          this as RegistrationsResponse, _$identity);

  /// Serializes this RegistrationsResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RegistrationsResponse &&
            (identical(other.startIndex, startIndex) ||
                other.startIndex == startIndex) &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults) &&
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
      totalResults,
      totalItems,
      const DeepCollectionEquality().hash(errors));

  @override
  String toString() {
    return 'RegistrationsResponse(startIndex: $startIndex, items: $items, totalResults: $totalResults, totalItems: $totalItems, errors: $errors)';
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
      @JsonKey(name: 'total_results') int totalResults,
      @JsonKey(name: 'totalItems') int totalItems,
      List<String> errors});
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
    Object? totalResults = null,
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
              as List<Registration>,
      totalResults: null == totalResults
          ? _self.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
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
class _RegistrationsResponse implements RegistrationsResponse {
  _RegistrationsResponse(
      {@JsonKey(name: 'startIndex') required this.startIndex,
      @JsonKey(name: 'items') required final List<Registration> items,
      @JsonKey(name: 'total_results') required this.totalResults,
      @JsonKey(name: 'totalItems') required this.totalItems,
      final List<String> errors = const []})
      : _items = items,
        _errors = errors;
  factory _RegistrationsResponse.fromJson(Map<String, dynamic> json) =>
      _$RegistrationsResponseFromJson(json);

  @override
  @JsonKey(name: 'startIndex')
  final int startIndex;
  final List<Registration> _items;
  @override
  @JsonKey(name: 'items')
  List<Registration> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey(name: 'total_results')
  final int totalResults;
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

  /// Create a copy of RegistrationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RegistrationsResponseCopyWith<_RegistrationsResponse> get copyWith =>
      __$RegistrationsResponseCopyWithImpl<_RegistrationsResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RegistrationsResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RegistrationsResponse &&
            (identical(other.startIndex, startIndex) ||
                other.startIndex == startIndex) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults) &&
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
      totalResults,
      totalItems,
      const DeepCollectionEquality().hash(_errors));

  @override
  String toString() {
    return 'RegistrationsResponse(startIndex: $startIndex, items: $items, totalResults: $totalResults, totalItems: $totalItems, errors: $errors)';
  }
}

/// @nodoc
abstract mixin class _$RegistrationsResponseCopyWith<$Res>
    implements $RegistrationsResponseCopyWith<$Res> {
  factory _$RegistrationsResponseCopyWith(_RegistrationsResponse value,
          $Res Function(_RegistrationsResponse) _then) =
      __$RegistrationsResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'startIndex') int startIndex,
      @JsonKey(name: 'items') List<Registration> items,
      @JsonKey(name: 'total_results') int totalResults,
      @JsonKey(name: 'totalItems') int totalItems,
      List<String> errors});
}

/// @nodoc
class __$RegistrationsResponseCopyWithImpl<$Res>
    implements _$RegistrationsResponseCopyWith<$Res> {
  __$RegistrationsResponseCopyWithImpl(this._self, this._then);

  final _RegistrationsResponse _self;
  final $Res Function(_RegistrationsResponse) _then;

  /// Create a copy of RegistrationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? startIndex = null,
    Object? items = null,
    Object? totalResults = null,
    Object? totalItems = null,
    Object? errors = null,
  }) {
    return _then(_RegistrationsResponse(
      startIndex: null == startIndex
          ? _self.startIndex
          : startIndex // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Registration>,
      totalResults: null == totalResults
          ? _self.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
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
