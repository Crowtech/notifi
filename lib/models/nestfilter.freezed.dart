// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nestfilter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NestFilter {
  @JsonKey(name: 'orgIdList')
  List<int> get orgIdList => throw _privateConstructorUsedError;
  @JsonKey(name: 'resourceCodeList')
  List<String> get resourceCodeList => throw _privateConstructorUsedError;
  @JsonKey(name: 'resourceIdList')
  List<int> get resourceIdList => throw _privateConstructorUsedError;
  @JsonKey(name: 'deviceCodeList')
  List<String> get deviceCodeList => throw _privateConstructorUsedError;
  @JsonKey(name: 'query')
  String get query => throw _privateConstructorUsedError;
  @JsonKey(name: 'limit')
  int get limit => throw _privateConstructorUsedError;
  @JsonKey(name: 'offset')
  int get offset => throw _privateConstructorUsedError;
  @JsonKey(name: 'sortby')
  String get sortby => throw _privateConstructorUsedError;
  @JsonKey(name: 'caseinsensitive')
  bool get caseinsensitive => throw _privateConstructorUsedError;
  @JsonKey(name: 'distinctField')
  String get distinctField => throw _privateConstructorUsedError;

  /// Create a copy of NestFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NestFilterCopyWith<NestFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NestFilterCopyWith<$Res> {
  factory $NestFilterCopyWith(
          NestFilter value, $Res Function(NestFilter) then) =
      _$NestFilterCopyWithImpl<$Res, NestFilter>;
  @useResult
  $Res call(
      {@JsonKey(name: 'orgIdList') List<int> orgIdList,
      @JsonKey(name: 'resourceCodeList') List<String> resourceCodeList,
      @JsonKey(name: 'resourceIdList') List<int> resourceIdList,
      @JsonKey(name: 'deviceCodeList') List<String> deviceCodeList,
      @JsonKey(name: 'query') String query,
      @JsonKey(name: 'limit') int limit,
      @JsonKey(name: 'offset') int offset,
      @JsonKey(name: 'sortby') String sortby,
      @JsonKey(name: 'caseinsensitive') bool caseinsensitive,
      @JsonKey(name: 'distinctField') String distinctField});
}

/// @nodoc
class _$NestFilterCopyWithImpl<$Res, $Val extends NestFilter>
    implements $NestFilterCopyWith<$Res> {
  _$NestFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NestFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orgIdList = null,
    Object? resourceCodeList = null,
    Object? resourceIdList = null,
    Object? deviceCodeList = null,
    Object? query = null,
    Object? limit = null,
    Object? offset = null,
    Object? sortby = null,
    Object? caseinsensitive = null,
    Object? distinctField = null,
  }) {
    return _then(_value.copyWith(
      orgIdList: null == orgIdList
          ? _value.orgIdList
          : orgIdList // ignore: cast_nullable_to_non_nullable
              as List<int>,
      resourceCodeList: null == resourceCodeList
          ? _value.resourceCodeList
          : resourceCodeList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      resourceIdList: null == resourceIdList
          ? _value.resourceIdList
          : resourceIdList // ignore: cast_nullable_to_non_nullable
              as List<int>,
      deviceCodeList: null == deviceCodeList
          ? _value.deviceCodeList
          : deviceCodeList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      sortby: null == sortby
          ? _value.sortby
          : sortby // ignore: cast_nullable_to_non_nullable
              as String,
      caseinsensitive: null == caseinsensitive
          ? _value.caseinsensitive
          : caseinsensitive // ignore: cast_nullable_to_non_nullable
              as bool,
      distinctField: null == distinctField
          ? _value.distinctField
          : distinctField // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NestFilterImplCopyWith<$Res>
    implements $NestFilterCopyWith<$Res> {
  factory _$$NestFilterImplCopyWith(
          _$NestFilterImpl value, $Res Function(_$NestFilterImpl) then) =
      __$$NestFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'orgIdList') List<int> orgIdList,
      @JsonKey(name: 'resourceCodeList') List<String> resourceCodeList,
      @JsonKey(name: 'resourceIdList') List<int> resourceIdList,
      @JsonKey(name: 'deviceCodeList') List<String> deviceCodeList,
      @JsonKey(name: 'query') String query,
      @JsonKey(name: 'limit') int limit,
      @JsonKey(name: 'offset') int offset,
      @JsonKey(name: 'sortby') String sortby,
      @JsonKey(name: 'caseinsensitive') bool caseinsensitive,
      @JsonKey(name: 'distinctField') String distinctField});
}

/// @nodoc
class __$$NestFilterImplCopyWithImpl<$Res>
    extends _$NestFilterCopyWithImpl<$Res, _$NestFilterImpl>
    implements _$$NestFilterImplCopyWith<$Res> {
  __$$NestFilterImplCopyWithImpl(
      _$NestFilterImpl _value, $Res Function(_$NestFilterImpl) _then)
      : super(_value, _then);

  /// Create a copy of NestFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orgIdList = null,
    Object? resourceCodeList = null,
    Object? resourceIdList = null,
    Object? deviceCodeList = null,
    Object? query = null,
    Object? limit = null,
    Object? offset = null,
    Object? sortby = null,
    Object? caseinsensitive = null,
    Object? distinctField = null,
  }) {
    return _then(_$NestFilterImpl(
      orgIdList: null == orgIdList
          ? _value._orgIdList
          : orgIdList // ignore: cast_nullable_to_non_nullable
              as List<int>,
      resourceCodeList: null == resourceCodeList
          ? _value._resourceCodeList
          : resourceCodeList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      resourceIdList: null == resourceIdList
          ? _value._resourceIdList
          : resourceIdList // ignore: cast_nullable_to_non_nullable
              as List<int>,
      deviceCodeList: null == deviceCodeList
          ? _value._deviceCodeList
          : deviceCodeList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      sortby: null == sortby
          ? _value.sortby
          : sortby // ignore: cast_nullable_to_non_nullable
              as String,
      caseinsensitive: null == caseinsensitive
          ? _value.caseinsensitive
          : caseinsensitive // ignore: cast_nullable_to_non_nullable
              as bool,
      distinctField: null == distinctField
          ? _value.distinctField
          : distinctField // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$NestFilterImpl extends _NestFilter {
  const _$NestFilterImpl(
      {@JsonKey(name: 'orgIdList') final List<int> orgIdList = const [],
      @JsonKey(name: 'resourceCodeList')
      final List<String> resourceCodeList = const [],
      @JsonKey(name: 'resourceIdList')
      final List<int> resourceIdList = const [],
      @JsonKey(name: 'deviceCodeList')
      final List<String> deviceCodeList = const [],
      @JsonKey(name: 'query') this.query = '',
      @JsonKey(name: 'limit') this.limit = 10,
      @JsonKey(name: 'offset') this.offset = 0,
      @JsonKey(name: 'sortby') this.sortby = '',
      @JsonKey(name: 'caseinsensitive') this.caseinsensitive = true,
      @JsonKey(name: 'distinctField') this.distinctField = ''})
      : _orgIdList = orgIdList,
        _resourceCodeList = resourceCodeList,
        _resourceIdList = resourceIdList,
        _deviceCodeList = deviceCodeList,
        super._();

  final List<int> _orgIdList;
  @override
  @JsonKey(name: 'orgIdList')
  List<int> get orgIdList {
    if (_orgIdList is EqualUnmodifiableListView) return _orgIdList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orgIdList);
  }

  final List<String> _resourceCodeList;
  @override
  @JsonKey(name: 'resourceCodeList')
  List<String> get resourceCodeList {
    if (_resourceCodeList is EqualUnmodifiableListView)
      return _resourceCodeList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_resourceCodeList);
  }

  final List<int> _resourceIdList;
  @override
  @JsonKey(name: 'resourceIdList')
  List<int> get resourceIdList {
    if (_resourceIdList is EqualUnmodifiableListView) return _resourceIdList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_resourceIdList);
  }

  final List<String> _deviceCodeList;
  @override
  @JsonKey(name: 'deviceCodeList')
  List<String> get deviceCodeList {
    if (_deviceCodeList is EqualUnmodifiableListView) return _deviceCodeList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deviceCodeList);
  }

  @override
  @JsonKey(name: 'query')
  final String query;
  @override
  @JsonKey(name: 'limit')
  final int limit;
  @override
  @JsonKey(name: 'offset')
  final int offset;
  @override
  @JsonKey(name: 'sortby')
  final String sortby;
  @override
  @JsonKey(name: 'caseinsensitive')
  final bool caseinsensitive;
  @override
  @JsonKey(name: 'distinctField')
  final String distinctField;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NestFilterImpl &&
            const DeepCollectionEquality()
                .equals(other._orgIdList, _orgIdList) &&
            const DeepCollectionEquality()
                .equals(other._resourceCodeList, _resourceCodeList) &&
            const DeepCollectionEquality()
                .equals(other._resourceIdList, _resourceIdList) &&
            const DeepCollectionEquality()
                .equals(other._deviceCodeList, _deviceCodeList) &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.sortby, sortby) || other.sortby == sortby) &&
            (identical(other.caseinsensitive, caseinsensitive) ||
                other.caseinsensitive == caseinsensitive) &&
            (identical(other.distinctField, distinctField) ||
                other.distinctField == distinctField));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_orgIdList),
      const DeepCollectionEquality().hash(_resourceCodeList),
      const DeepCollectionEquality().hash(_resourceIdList),
      const DeepCollectionEquality().hash(_deviceCodeList),
      query,
      limit,
      offset,
      sortby,
      caseinsensitive,
      distinctField);

  /// Create a copy of NestFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NestFilterImplCopyWith<_$NestFilterImpl> get copyWith =>
      __$$NestFilterImplCopyWithImpl<_$NestFilterImpl>(this, _$identity);
}

abstract class _NestFilter extends NestFilter {
  const factory _NestFilter(
      {@JsonKey(name: 'orgIdList') final List<int> orgIdList,
      @JsonKey(name: 'resourceCodeList') final List<String> resourceCodeList,
      @JsonKey(name: 'resourceIdList') final List<int> resourceIdList,
      @JsonKey(name: 'deviceCodeList') final List<String> deviceCodeList,
      @JsonKey(name: 'query') final String query,
      @JsonKey(name: 'limit') final int limit,
      @JsonKey(name: 'offset') final int offset,
      @JsonKey(name: 'sortby') final String sortby,
      @JsonKey(name: 'caseinsensitive') final bool caseinsensitive,
      @JsonKey(name: 'distinctField')
      final String distinctField}) = _$NestFilterImpl;
  const _NestFilter._() : super._();

  @override
  @JsonKey(name: 'orgIdList')
  List<int> get orgIdList;
  @override
  @JsonKey(name: 'resourceCodeList')
  List<String> get resourceCodeList;
  @override
  @JsonKey(name: 'resourceIdList')
  List<int> get resourceIdList;
  @override
  @JsonKey(name: 'deviceCodeList')
  List<String> get deviceCodeList;
  @override
  @JsonKey(name: 'query')
  String get query;
  @override
  @JsonKey(name: 'limit')
  int get limit;
  @override
  @JsonKey(name: 'offset')
  int get offset;
  @override
  @JsonKey(name: 'sortby')
  String get sortby;
  @override
  @JsonKey(name: 'caseinsensitive')
  bool get caseinsensitive;
  @override
  @JsonKey(name: 'distinctField')
  String get distinctField;

  /// Create a copy of NestFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NestFilterImplCopyWith<_$NestFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
