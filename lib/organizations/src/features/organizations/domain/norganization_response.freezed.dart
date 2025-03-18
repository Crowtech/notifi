// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'norganization_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NOrganizationsResponse _$NOrganizationsResponseFromJson(
    Map<String, dynamic> json) {
  return _NOrganizationsResponse.fromJson(json);
}

/// @nodoc
mixin _$NOrganizationsResponse {
  @JsonKey(name: 'startIndex')
  int get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'items')
  List<NOrganization> get results => throw _privateConstructorUsedError;
  @JsonKey(name: 'resultCount')
  int get totalResults => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalItems')
  int get totalPages => throw _privateConstructorUsedError;
  List<String> get errors => throw _privateConstructorUsedError;

  /// Serializes this NOrganizationsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NOrganizationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NOrganizationsResponseCopyWith<NOrganizationsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NOrganizationsResponseCopyWith<$Res> {
  factory $NOrganizationsResponseCopyWith(NOrganizationsResponse value,
          $Res Function(NOrganizationsResponse) then) =
      _$NOrganizationsResponseCopyWithImpl<$Res, NOrganizationsResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'startIndex') int page,
      @JsonKey(name: 'items') List<NOrganization> results,
      @JsonKey(name: 'resultCount') int totalResults,
      @JsonKey(name: 'totalItems') int totalPages,
      List<String> errors});
}

/// @nodoc
class _$NOrganizationsResponseCopyWithImpl<$Res,
        $Val extends NOrganizationsResponse>
    implements $NOrganizationsResponseCopyWith<$Res> {
  _$NOrganizationsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<NOrganization>,
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
abstract class _$$NOrganizationsResponseImplCopyWith<$Res>
    implements $NOrganizationsResponseCopyWith<$Res> {
  factory _$$NOrganizationsResponseImplCopyWith(
          _$NOrganizationsResponseImpl value,
          $Res Function(_$NOrganizationsResponseImpl) then) =
      __$$NOrganizationsResponseImplCopyWithImpl<$Res>;
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
class __$$NOrganizationsResponseImplCopyWithImpl<$Res>
    extends _$NOrganizationsResponseCopyWithImpl<$Res,
        _$NOrganizationsResponseImpl>
    implements _$$NOrganizationsResponseImplCopyWith<$Res> {
  __$$NOrganizationsResponseImplCopyWithImpl(
      _$NOrganizationsResponseImpl _value,
      $Res Function(_$NOrganizationsResponseImpl) _then)
      : super(_value, _then);

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
    return _then(_$NOrganizationsResponseImpl(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<NOrganization>,
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
class _$NOrganizationsResponseImpl implements _NOrganizationsResponse {
  _$NOrganizationsResponseImpl(
      {@JsonKey(name: 'startIndex') required this.page,
      @JsonKey(name: 'items') required final List<NOrganization> results,
      @JsonKey(name: 'resultCount') required this.totalResults,
      @JsonKey(name: 'totalItems') required this.totalPages,
      final List<String> errors = const []})
      : _results = results,
        _errors = errors;

  factory _$NOrganizationsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$NOrganizationsResponseImplFromJson(json);

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

  @override
  String toString() {
    return 'NOrganizationsResponse(page: $page, results: $results, totalResults: $totalResults, totalPages: $totalPages, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NOrganizationsResponseImpl &&
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

  /// Create a copy of NOrganizationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NOrganizationsResponseImplCopyWith<_$NOrganizationsResponseImpl>
      get copyWith => __$$NOrganizationsResponseImplCopyWithImpl<
          _$NOrganizationsResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NOrganizationsResponseImplToJson(
      this,
    );
  }
}

abstract class _NOrganizationsResponse implements NOrganizationsResponse {
  factory _NOrganizationsResponse(
      {@JsonKey(name: 'startIndex') required final int page,
      @JsonKey(name: 'items') required final List<NOrganization> results,
      @JsonKey(name: 'resultCount') required final int totalResults,
      @JsonKey(name: 'totalItems') required final int totalPages,
      final List<String> errors}) = _$NOrganizationsResponseImpl;

  factory _NOrganizationsResponse.fromJson(Map<String, dynamic> json) =
      _$NOrganizationsResponseImpl.fromJson;

  @override
  @JsonKey(name: 'startIndex')
  int get page;
  @override
  @JsonKey(name: 'items')
  List<NOrganization> get results;
  @override
  @JsonKey(name: 'resultCount')
  int get totalResults;
  @override
  @JsonKey(name: 'totalItems')
  int get totalPages;
  @override
  List<String> get errors;

  /// Create a copy of NOrganizationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NOrganizationsResponseImplCopyWith<_$NOrganizationsResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OrganizationsResponse _$OrganizationsResponseFromJson(
    Map<String, dynamic> json) {
  return _OrganizationsResponse.fromJson(json);
}

/// @nodoc
mixin _$OrganizationsResponse {
  @JsonKey(name: 'startIndex')
  int get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'items')
  List<Organization> get results => throw _privateConstructorUsedError;
  @JsonKey(name: 'resultCount')
  int get totalResults => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalItems')
  int get totalPages => throw _privateConstructorUsedError;
  List<String> get errors => throw _privateConstructorUsedError;

  /// Serializes this OrganizationsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrganizationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrganizationsResponseCopyWith<OrganizationsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizationsResponseCopyWith<$Res> {
  factory $OrganizationsResponseCopyWith(OrganizationsResponse value,
          $Res Function(OrganizationsResponse) then) =
      _$OrganizationsResponseCopyWithImpl<$Res, OrganizationsResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'startIndex') int page,
      @JsonKey(name: 'items') List<Organization> results,
      @JsonKey(name: 'resultCount') int totalResults,
      @JsonKey(name: 'totalItems') int totalPages,
      List<String> errors});
}

/// @nodoc
class _$OrganizationsResponseCopyWithImpl<$Res,
        $Val extends OrganizationsResponse>
    implements $OrganizationsResponseCopyWith<$Res> {
  _$OrganizationsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrganizationsResponse
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
              as List<Organization>,
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
abstract class _$$OrganizationsResponseImplCopyWith<$Res>
    implements $OrganizationsResponseCopyWith<$Res> {
  factory _$$OrganizationsResponseImplCopyWith(
          _$OrganizationsResponseImpl value,
          $Res Function(_$OrganizationsResponseImpl) then) =
      __$$OrganizationsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'startIndex') int page,
      @JsonKey(name: 'items') List<Organization> results,
      @JsonKey(name: 'resultCount') int totalResults,
      @JsonKey(name: 'totalItems') int totalPages,
      List<String> errors});
}

/// @nodoc
class __$$OrganizationsResponseImplCopyWithImpl<$Res>
    extends _$OrganizationsResponseCopyWithImpl<$Res,
        _$OrganizationsResponseImpl>
    implements _$$OrganizationsResponseImplCopyWith<$Res> {
  __$$OrganizationsResponseImplCopyWithImpl(_$OrganizationsResponseImpl _value,
      $Res Function(_$OrganizationsResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrganizationsResponse
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
    return _then(_$OrganizationsResponseImpl(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Organization>,
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
class _$OrganizationsResponseImpl implements _OrganizationsResponse {
  _$OrganizationsResponseImpl(
      {@JsonKey(name: 'startIndex') required this.page,
      @JsonKey(name: 'items') required final List<Organization> results,
      @JsonKey(name: 'resultCount') required this.totalResults,
      @JsonKey(name: 'totalItems') required this.totalPages,
      final List<String> errors = const []})
      : _results = results,
        _errors = errors;

  factory _$OrganizationsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrganizationsResponseImplFromJson(json);

  @override
  @JsonKey(name: 'startIndex')
  final int page;
  final List<Organization> _results;
  @override
  @JsonKey(name: 'items')
  List<Organization> get results {
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
    return 'OrganizationsResponse(page: $page, results: $results, totalResults: $totalResults, totalPages: $totalPages, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrganizationsResponseImpl &&
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

  /// Create a copy of OrganizationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrganizationsResponseImplCopyWith<_$OrganizationsResponseImpl>
      get copyWith => __$$OrganizationsResponseImplCopyWithImpl<
          _$OrganizationsResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrganizationsResponseImplToJson(
      this,
    );
  }
}

abstract class _OrganizationsResponse implements OrganizationsResponse {
  factory _OrganizationsResponse(
      {@JsonKey(name: 'startIndex') required final int page,
      @JsonKey(name: 'items') required final List<Organization> results,
      @JsonKey(name: 'resultCount') required final int totalResults,
      @JsonKey(name: 'totalItems') required final int totalPages,
      final List<String> errors}) = _$OrganizationsResponseImpl;

  factory _OrganizationsResponse.fromJson(Map<String, dynamic> json) =
      _$OrganizationsResponseImpl.fromJson;

  @override
  @JsonKey(name: 'startIndex')
  int get page;
  @override
  @JsonKey(name: 'items')
  List<Organization> get results;
  @override
  @JsonKey(name: 'resultCount')
  int get totalResults;
  @override
  @JsonKey(name: 'totalItems')
  int get totalPages;
  @override
  List<String> get errors;

  /// Create a copy of OrganizationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrganizationsResponseImplCopyWith<_$OrganizationsResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
