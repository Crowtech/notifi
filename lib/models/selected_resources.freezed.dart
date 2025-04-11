// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selected_resources.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SelectedResources _$SelectedResourcesFromJson(Map<String, dynamic> json) {
  return _SelectedResources.fromJson(json);
}

/// @nodoc
mixin _$SelectedResources {
  List<int> get selectedResourceIds => throw _privateConstructorUsedError;
  List<int> get unselectedResourceIds => throw _privateConstructorUsedError;

  /// Serializes this SelectedResources to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SelectedResources
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SelectedResourcesCopyWith<SelectedResources> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectedResourcesCopyWith<$Res> {
  factory $SelectedResourcesCopyWith(
    SelectedResources value,
    $Res Function(SelectedResources) then,
  ) = _$SelectedResourcesCopyWithImpl<$Res, SelectedResources>;
  @useResult
  $Res call({List<int> selectedResourceIds, List<int> unselectedResourceIds});
}

/// @nodoc
class _$SelectedResourcesCopyWithImpl<$Res, $Val extends SelectedResources>
    implements $SelectedResourcesCopyWith<$Res> {
  _$SelectedResourcesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectedResources
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedResourceIds = null,
    Object? unselectedResourceIds = null,
  }) {
    return _then(
      _value.copyWith(
            selectedResourceIds:
                null == selectedResourceIds
                    ? _value.selectedResourceIds
                    : selectedResourceIds // ignore: cast_nullable_to_non_nullable
                        as List<int>,
            unselectedResourceIds:
                null == unselectedResourceIds
                    ? _value.unselectedResourceIds
                    : unselectedResourceIds // ignore: cast_nullable_to_non_nullable
                        as List<int>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SelectedResourcesImplCopyWith<$Res>
    implements $SelectedResourcesCopyWith<$Res> {
  factory _$$SelectedResourcesImplCopyWith(
    _$SelectedResourcesImpl value,
    $Res Function(_$SelectedResourcesImpl) then,
  ) = __$$SelectedResourcesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<int> selectedResourceIds, List<int> unselectedResourceIds});
}

/// @nodoc
class __$$SelectedResourcesImplCopyWithImpl<$Res>
    extends _$SelectedResourcesCopyWithImpl<$Res, _$SelectedResourcesImpl>
    implements _$$SelectedResourcesImplCopyWith<$Res> {
  __$$SelectedResourcesImplCopyWithImpl(
    _$SelectedResourcesImpl _value,
    $Res Function(_$SelectedResourcesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SelectedResources
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedResourceIds = null,
    Object? unselectedResourceIds = null,
  }) {
    return _then(
      _$SelectedResourcesImpl(
        selectedResourceIds:
            null == selectedResourceIds
                ? _value._selectedResourceIds
                : selectedResourceIds // ignore: cast_nullable_to_non_nullable
                    as List<int>,
        unselectedResourceIds:
            null == unselectedResourceIds
                ? _value._unselectedResourceIds
                : unselectedResourceIds // ignore: cast_nullable_to_non_nullable
                    as List<int>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SelectedResourcesImpl implements _SelectedResources {
  _$SelectedResourcesImpl({
    required final List<int> selectedResourceIds,
    required final List<int> unselectedResourceIds,
  }) : _selectedResourceIds = selectedResourceIds,
       _unselectedResourceIds = unselectedResourceIds;

  factory _$SelectedResourcesImpl.fromJson(Map<String, dynamic> json) =>
      _$$SelectedResourcesImplFromJson(json);

  final List<int> _selectedResourceIds;
  @override
  List<int> get selectedResourceIds {
    if (_selectedResourceIds is EqualUnmodifiableListView)
      return _selectedResourceIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedResourceIds);
  }

  final List<int> _unselectedResourceIds;
  @override
  List<int> get unselectedResourceIds {
    if (_unselectedResourceIds is EqualUnmodifiableListView)
      return _unselectedResourceIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unselectedResourceIds);
  }

  @override
  String toString() {
    return 'SelectedResources(selectedResourceIds: $selectedResourceIds, unselectedResourceIds: $unselectedResourceIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectedResourcesImpl &&
            const DeepCollectionEquality().equals(
              other._selectedResourceIds,
              _selectedResourceIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._unselectedResourceIds,
              _unselectedResourceIds,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_selectedResourceIds),
    const DeepCollectionEquality().hash(_unselectedResourceIds),
  );

  /// Create a copy of SelectedResources
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectedResourcesImplCopyWith<_$SelectedResourcesImpl> get copyWith =>
      __$$SelectedResourcesImplCopyWithImpl<_$SelectedResourcesImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SelectedResourcesImplToJson(this);
  }
}

abstract class _SelectedResources implements SelectedResources {
  factory _SelectedResources({
    required final List<int> selectedResourceIds,
    required final List<int> unselectedResourceIds,
  }) = _$SelectedResourcesImpl;

  factory _SelectedResources.fromJson(Map<String, dynamic> json) =
      _$SelectedResourcesImpl.fromJson;

  @override
  List<int> get selectedResourceIds;
  @override
  List<int> get unselectedResourceIds;

  /// Create a copy of SelectedResources
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectedResourcesImplCopyWith<_$SelectedResourcesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
