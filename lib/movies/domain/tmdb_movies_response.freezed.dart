// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tmdb_movies_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TMDBMoviesResponse {
  int get page;
  List<TMDBMovie> get results;
  @JsonKey(name: 'total_results')
  int get totalResults;
  @JsonKey(name: 'total_pages')
  int get totalPages;
  List<String> get errors;

  /// Create a copy of TMDBMoviesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TMDBMoviesResponseCopyWith<TMDBMoviesResponse> get copyWith =>
      _$TMDBMoviesResponseCopyWithImpl<TMDBMoviesResponse>(
          this as TMDBMoviesResponse, _$identity);

  /// Serializes this TMDBMoviesResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TMDBMoviesResponse &&
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
    return 'TMDBMoviesResponse(page: $page, results: $results, totalResults: $totalResults, totalPages: $totalPages, errors: $errors)';
  }
}

/// @nodoc
abstract mixin class $TMDBMoviesResponseCopyWith<$Res> {
  factory $TMDBMoviesResponseCopyWith(
          TMDBMoviesResponse value, $Res Function(TMDBMoviesResponse) _then) =
      _$TMDBMoviesResponseCopyWithImpl;
  @useResult
  $Res call(
      {int page,
      List<TMDBMovie> results,
      @JsonKey(name: 'total_results') int totalResults,
      @JsonKey(name: 'total_pages') int totalPages,
      List<String> errors});
}

/// @nodoc
class _$TMDBMoviesResponseCopyWithImpl<$Res>
    implements $TMDBMoviesResponseCopyWith<$Res> {
  _$TMDBMoviesResponseCopyWithImpl(this._self, this._then);

  final TMDBMoviesResponse _self;
  final $Res Function(TMDBMoviesResponse) _then;

  /// Create a copy of TMDBMoviesResponse
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
              as List<TMDBMovie>,
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
class _TMDBMoviesResponse implements TMDBMoviesResponse {
  _TMDBMoviesResponse(
      {required this.page,
      required final List<TMDBMovie> results,
      @JsonKey(name: 'total_results') required this.totalResults,
      @JsonKey(name: 'total_pages') required this.totalPages,
      final List<String> errors = const []})
      : _results = results,
        _errors = errors;
  factory _TMDBMoviesResponse.fromJson(Map<String, dynamic> json) =>
      _$TMDBMoviesResponseFromJson(json);

  @override
  final int page;
  final List<TMDBMovie> _results;
  @override
  List<TMDBMovie> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  @JsonKey(name: 'total_results')
  final int totalResults;
  @override
  @JsonKey(name: 'total_pages')
  final int totalPages;
  final List<String> _errors;
  @override
  @JsonKey()
  List<String> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  /// Create a copy of TMDBMoviesResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TMDBMoviesResponseCopyWith<_TMDBMoviesResponse> get copyWith =>
      __$TMDBMoviesResponseCopyWithImpl<_TMDBMoviesResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TMDBMoviesResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TMDBMoviesResponse &&
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
    return 'TMDBMoviesResponse(page: $page, results: $results, totalResults: $totalResults, totalPages: $totalPages, errors: $errors)';
  }
}

/// @nodoc
abstract mixin class _$TMDBMoviesResponseCopyWith<$Res>
    implements $TMDBMoviesResponseCopyWith<$Res> {
  factory _$TMDBMoviesResponseCopyWith(
          _TMDBMoviesResponse value, $Res Function(_TMDBMoviesResponse) _then) =
      __$TMDBMoviesResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int page,
      List<TMDBMovie> results,
      @JsonKey(name: 'total_results') int totalResults,
      @JsonKey(name: 'total_pages') int totalPages,
      List<String> errors});
}

/// @nodoc
class __$TMDBMoviesResponseCopyWithImpl<$Res>
    implements _$TMDBMoviesResponseCopyWith<$Res> {
  __$TMDBMoviesResponseCopyWithImpl(this._self, this._then);

  final _TMDBMoviesResponse _self;
  final $Res Function(_TMDBMoviesResponse) _then;

  /// Create a copy of TMDBMoviesResponse
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
    return _then(_TMDBMoviesResponse(
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      results: null == results
          ? _self._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<TMDBMovie>,
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
