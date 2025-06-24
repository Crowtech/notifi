// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nperson_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NPersonsResponse {
  @JsonKey(name: 'startIndex')
  int get page;
  @JsonKey(name: 'items')
  List<NPerson> get results;
  @JsonKey(name: 'resultCount')
  int get totalResults;
  @JsonKey(name: 'totalItems')
  int get totalPages;
  List<String> get errors;

  /// Create a copy of NPersonsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NPersonsResponseCopyWith<NPersonsResponse> get copyWith =>
      _$NPersonsResponseCopyWithImpl<NPersonsResponse>(
          this as NPersonsResponse, _$identity);

  /// Serializes this NPersonsResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NPersonsResponse &&
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
    return 'NPersonsResponse(page: $page, results: $results, totalResults: $totalResults, totalPages: $totalPages, errors: $errors)';
  }
}

/// @nodoc
abstract mixin class $NPersonsResponseCopyWith<$Res> {
  factory $NPersonsResponseCopyWith(
          NPersonsResponse value, $Res Function(NPersonsResponse) _then) =
      _$NPersonsResponseCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'startIndex') int page,
      @JsonKey(name: 'items') List<NPerson> results,
      @JsonKey(name: 'resultCount') int totalResults,
      @JsonKey(name: 'totalItems') int totalPages,
      List<String> errors});
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
              as List<NPerson>,
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
class _NPersonsResponse implements NPersonsResponse {
  _NPersonsResponse(
      {@JsonKey(name: 'startIndex') required this.page,
      @JsonKey(name: 'items') required final List<NPerson> results,
      @JsonKey(name: 'resultCount') required this.totalResults,
      @JsonKey(name: 'totalItems') required this.totalPages,
      final List<String> errors = const []})
      : _results = results,
        _errors = errors;
  factory _NPersonsResponse.fromJson(Map<String, dynamic> json) =>
      _$NPersonsResponseFromJson(json);

  @override
  @JsonKey(name: 'startIndex')
  final int page;
  final List<NPerson> _results;
  @override
  @JsonKey(name: 'items')
  List<NPerson> get results {
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

  /// Create a copy of NPersonsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NPersonsResponseCopyWith<_NPersonsResponse> get copyWith =>
      __$NPersonsResponseCopyWithImpl<_NPersonsResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NPersonsResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NPersonsResponse &&
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
    return 'NPersonsResponse(page: $page, results: $results, totalResults: $totalResults, totalPages: $totalPages, errors: $errors)';
  }
}

/// @nodoc
abstract mixin class _$NPersonsResponseCopyWith<$Res>
    implements $NPersonsResponseCopyWith<$Res> {
  factory _$NPersonsResponseCopyWith(
          _NPersonsResponse value, $Res Function(_NPersonsResponse) _then) =
      __$NPersonsResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'startIndex') int page,
      @JsonKey(name: 'items') List<NPerson> results,
      @JsonKey(name: 'resultCount') int totalResults,
      @JsonKey(name: 'totalItems') int totalPages,
      List<String> errors});
}

/// @nodoc
class __$NPersonsResponseCopyWithImpl<$Res>
    implements _$NPersonsResponseCopyWith<$Res> {
  __$NPersonsResponseCopyWithImpl(this._self, this._then);

  final _NPersonsResponse _self;
  final $Res Function(_NPersonsResponse) _then;

  /// Create a copy of NPersonsResponse
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
    return _then(_NPersonsResponse(
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      results: null == results
          ? _self._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<NPerson>,
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
