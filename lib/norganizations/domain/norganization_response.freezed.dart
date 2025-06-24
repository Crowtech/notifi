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
  int get page;
  @JsonKey(name: 'items')
  List<NOrganization> get results;
  @JsonKey(name: 'resultCount')
  int get totalResults;
  @JsonKey(name: 'totalItems')
  int get totalPages;
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
            (identical(other.page, page) || other.page == page) &&
            const DeepCollectionEquality().equals(other.results, results) &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            const DeepCollectionEquality().equals(other.errors, errors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      page,
      const DeepCollectionEquality().hash(results),
      totalResults,
      totalPages,
      const DeepCollectionEquality().hash(errors));

  @override
  String toString() {
    return 'NOrganizationsResponse(page: $page, results: $results, totalResults: $totalResults, totalPages: $totalPages, errors: $errors)';
  }
}

/// @nodoc
abstract mixin class $NOrganizationsResponseCopyWith<$Res> {
  factory $NOrganizationsResponseCopyWith(NOrganizationsResponse value,
          $Res Function(NOrganizationsResponse) _then) =
      _$NOrganizationsResponseCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'startIndex') int page,
      @JsonKey(name: 'items') List<NOrganization> results,
      @JsonKey(name: 'resultCount') int totalResults,
      @JsonKey(name: 'totalItems') int totalPages,
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
    Object? page = null,
    Object? results = null,
    Object? totalResults = null,
    Object? totalPages = null,
    Object? errors = null,
  }) {
    return _then(_self.copyWith(
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      results: null == results
          ? _self.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<NOrganization>,
      totalResults: null == totalResults
          ? _self.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _self.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
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
      {@JsonKey(name: 'startIndex') required this.page,
      @JsonKey(name: 'items') required final List<NOrganization> results,
      @JsonKey(name: 'resultCount') required this.totalResults,
      @JsonKey(name: 'totalItems') required this.totalPages,
      final List<String> errors = const []})
      : _results = results,
        _errors = errors;
  factory _NOrganizationsResponse.fromJson(Map<String, dynamic> json) =>
      _$NOrganizationsResponseFromJson(json);

  @override
  @JsonKey(name: 'startIndex')
  final int page;
  final List<NOrganization> _results;
  @override
  @JsonKey(name: 'items')
  List<NOrganization> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  @JsonKey(name: 'resultCount')
  final int totalResults;
  @override
  @JsonKey(name: 'totalItems')
  final int totalPages;
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
            (identical(other.page, page) || other.page == page) &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      page,
      const DeepCollectionEquality().hash(_results),
      totalResults,
      totalPages,
      const DeepCollectionEquality().hash(_errors));

  @override
  String toString() {
    return 'NOrganizationsResponse(page: $page, results: $results, totalResults: $totalResults, totalPages: $totalPages, errors: $errors)';
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
      {@JsonKey(name: 'startIndex') int page,
      @JsonKey(name: 'items') List<NOrganization> results,
      @JsonKey(name: 'resultCount') int totalResults,
      @JsonKey(name: 'totalItems') int totalPages,
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
    Object? page = null,
    Object? results = null,
    Object? totalResults = null,
    Object? totalPages = null,
    Object? errors = null,
  }) {
    return _then(_NOrganizationsResponse(
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      results: null == results
          ? _self._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<NOrganization>,
      totalResults: null == totalResults
          ? _self.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _self.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      errors: null == errors
          ? _self._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
