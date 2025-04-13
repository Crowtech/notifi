// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nperson_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NPersonsResponse _$NPersonsResponseFromJson(Map<String, dynamic> json) {
  return _NPersonsResponse.fromJson(json);
}

/// @nodoc
mixin _$NPersonsResponse {
  @JsonKey(name: 'startIndex')
  int get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'items')
  List<NPerson> get results => throw _privateConstructorUsedError;
  @JsonKey(name: 'resultCount')
  int get totalResults => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalItems')
  int get totalPages => throw _privateConstructorUsedError;
  List<String> get errors => throw _privateConstructorUsedError;

  /// Serializes this NPersonsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NPersonsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NPersonsResponseCopyWith<NPersonsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NPersonsResponseCopyWith<$Res> {
  factory $NPersonsResponseCopyWith(
          NPersonsResponse value, $Res Function(NPersonsResponse) then) =
      _$NPersonsResponseCopyWithImpl<$Res, NPersonsResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'startIndex') int page,
      @JsonKey(name: 'items') List<NPerson> results,
      @JsonKey(name: 'resultCount') int totalResults,
      @JsonKey(name: 'totalItems') int totalPages,
      List<String> errors});
}

/// @nodoc
class _$NPersonsResponseCopyWithImpl<$Res, $Val extends NPersonsResponse>
    implements $NPersonsResponseCopyWith<$Res> {
  _$NPersonsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<NPerson>,
      totalResults: null == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      errors: null == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NPersonsResponseImplCopyWith<$Res>
    implements $NPersonsResponseCopyWith<$Res> {
  factory _$$NPersonsResponseImplCopyWith(_$NPersonsResponseImpl value,
          $Res Function(_$NPersonsResponseImpl) then) =
      __$$NPersonsResponseImplCopyWithImpl<$Res>;
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
class __$$NPersonsResponseImplCopyWithImpl<$Res>
    extends _$NPersonsResponseCopyWithImpl<$Res, _$NPersonsResponseImpl>
    implements _$$NPersonsResponseImplCopyWith<$Res> {
  __$$NPersonsResponseImplCopyWithImpl(_$NPersonsResponseImpl _value,
      $Res Function(_$NPersonsResponseImpl) _then)
      : super(_value, _then);

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
    return _then(_$NPersonsResponseImpl(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<NPerson>,
      totalResults: null == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      errors: null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NPersonsResponseImpl implements _NPersonsResponse {
  _$NPersonsResponseImpl(
      {@JsonKey(name: 'startIndex') required this.page,
      @JsonKey(name: 'items') required final List<NPerson> results,
      @JsonKey(name: 'resultCount') required this.totalResults,
      @JsonKey(name: 'totalItems') required this.totalPages,
      final List<String> errors = const []})
      : _results = results,
        _errors = errors;

  factory _$NPersonsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$NPersonsResponseImplFromJson(json);

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

  @override
  String toString() {
    return 'NPersonsResponse(page: $page, results: $results, totalResults: $totalResults, totalPages: $totalPages, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NPersonsResponseImpl &&
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

  /// Create a copy of NPersonsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NPersonsResponseImplCopyWith<_$NPersonsResponseImpl> get copyWith =>
      __$$NPersonsResponseImplCopyWithImpl<_$NPersonsResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NPersonsResponseImplToJson(
      this,
    );
  }
}

abstract class _NPersonsResponse implements NPersonsResponse {
  factory _NPersonsResponse(
      {@JsonKey(name: 'startIndex') required final int page,
      @JsonKey(name: 'items') required final List<NPerson> results,
      @JsonKey(name: 'resultCount') required final int totalResults,
      @JsonKey(name: 'totalItems') required final int totalPages,
      final List<String> errors}) = _$NPersonsResponseImpl;

  factory _NPersonsResponse.fromJson(Map<String, dynamic> json) =
      _$NPersonsResponseImpl.fromJson;

  @override
  @JsonKey(name: 'startIndex')
  int get page;
  @override
  @JsonKey(name: 'items')
  List<NPerson> get results;
  @override
  @JsonKey(name: 'resultCount')
  int get totalResults;
  @override
  @JsonKey(name: 'totalItems')
  int get totalPages;
  @override
  List<String> get errors;

  /// Create a copy of NPersonsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NPersonsResponseImplCopyWith<_$NPersonsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
