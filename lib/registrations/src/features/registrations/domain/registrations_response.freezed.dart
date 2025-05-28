// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registrations_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RegistrationsResponse _$RegistrationsResponseFromJson(
    Map<String, dynamic> json) {
  return _RegistrationsResponse.fromJson(json);
}

/// @nodoc
mixin _$RegistrationsResponse {
  @JsonKey(name: 'startIndex')
  int get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'items')
  List<Registration> get results => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_results')
  int get totalResults => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalItems')
  int get totalPages => throw _privateConstructorUsedError;
  List<String> get errors => throw _privateConstructorUsedError;

  /// Serializes this RegistrationsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegistrationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegistrationsResponseCopyWith<RegistrationsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegistrationsResponseCopyWith<$Res> {
  factory $RegistrationsResponseCopyWith(RegistrationsResponse value,
          $Res Function(RegistrationsResponse) then) =
      _$RegistrationsResponseCopyWithImpl<$Res, RegistrationsResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'startIndex') int page,
      @JsonKey(name: 'items') List<Registration> results,
      @JsonKey(name: 'total_results') int totalResults,
      @JsonKey(name: 'totalItems') int totalPages,
      List<String> errors});
}

/// @nodoc
class _$RegistrationsResponseCopyWithImpl<$Res,
        $Val extends RegistrationsResponse>
    implements $RegistrationsResponseCopyWith<$Res> {
  _$RegistrationsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegistrationsResponse
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
              as List<Registration>,
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
abstract class _$$RegistrationsResponseImplCopyWith<$Res>
    implements $RegistrationsResponseCopyWith<$Res> {
  factory _$$RegistrationsResponseImplCopyWith(
          _$RegistrationsResponseImpl value,
          $Res Function(_$RegistrationsResponseImpl) then) =
      __$$RegistrationsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'startIndex') int page,
      @JsonKey(name: 'items') List<Registration> results,
      @JsonKey(name: 'total_results') int totalResults,
      @JsonKey(name: 'totalItems') int totalPages,
      List<String> errors});
}

/// @nodoc
class __$$RegistrationsResponseImplCopyWithImpl<$Res>
    extends _$RegistrationsResponseCopyWithImpl<$Res,
        _$RegistrationsResponseImpl>
    implements _$$RegistrationsResponseImplCopyWith<$Res> {
  __$$RegistrationsResponseImplCopyWithImpl(_$RegistrationsResponseImpl _value,
      $Res Function(_$RegistrationsResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegistrationsResponse
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
    return _then(_$RegistrationsResponseImpl(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Registration>,
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
class _$RegistrationsResponseImpl implements _RegistrationsResponse {
  _$RegistrationsResponseImpl(
      {@JsonKey(name: 'startIndex') required this.page,
      @JsonKey(name: 'items') required final List<Registration> results,
      @JsonKey(name: 'total_results') required this.totalResults,
      @JsonKey(name: 'totalItems') required this.totalPages,
      final List<String> errors = const []})
      : _results = results,
        _errors = errors;

  factory _$RegistrationsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegistrationsResponseImplFromJson(json);

  @override
  @JsonKey(name: 'startIndex')
  final int page;
  final List<Registration> _results;
  @override
  @JsonKey(name: 'items')
  List<Registration> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  @JsonKey(name: 'total_results')
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
    return 'RegistrationsResponse(page: $page, results: $results, totalResults: $totalResults, totalPages: $totalPages, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegistrationsResponseImpl &&
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

  /// Create a copy of RegistrationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegistrationsResponseImplCopyWith<_$RegistrationsResponseImpl>
      get copyWith => __$$RegistrationsResponseImplCopyWithImpl<
          _$RegistrationsResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegistrationsResponseImplToJson(
      this,
    );
  }
}

abstract class _RegistrationsResponse implements RegistrationsResponse {
  factory _RegistrationsResponse(
      {@JsonKey(name: 'startIndex') required final int page,
      @JsonKey(name: 'items') required final List<Registration> results,
      @JsonKey(name: 'total_results') required final int totalResults,
      @JsonKey(name: 'totalItems') required final int totalPages,
      final List<String> errors}) = _$RegistrationsResponseImpl;

  factory _RegistrationsResponse.fromJson(Map<String, dynamic> json) =
      _$RegistrationsResponseImpl.fromJson;

  @override
  @JsonKey(name: 'startIndex')
  int get page;
  @override
  @JsonKey(name: 'items')
  List<Registration> get results;
  @override
  @JsonKey(name: 'total_results')
  int get totalResults;
  @override
  @JsonKey(name: 'totalItems')
  int get totalPages;
  @override
  List<String> get errors;

  /// Create a copy of RegistrationsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegistrationsResponseImplCopyWith<_$RegistrationsResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
