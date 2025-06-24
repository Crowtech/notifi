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
  int get page;
  List<NPerson> get results;
  int get totalResults;
  int get totalPages;

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
            (identical(other.page, page) || other.page == page) &&
            const DeepCollectionEquality().equals(other.results, results) &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, page,
      const DeepCollectionEquality().hash(results), totalResults, totalPages);

  @override
  String toString() {
    return 'NPersonsResponse(page: $page, results: $results, totalResults: $totalResults, totalPages: $totalPages)';
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
      @JsonKey(name: 'totalItems') int totalPages});
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
  }) {
    return _then(NPersonsResponse(
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
    ));
  }
}

// dart format on
