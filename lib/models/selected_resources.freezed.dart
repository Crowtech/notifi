// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selected_resources.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SelectedResources {
  List<int> get selectedResourceIds;
  List<int> get unselectedResourceIds;

  /// Create a copy of SelectedResources
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SelectedResourcesCopyWith<SelectedResources> get copyWith =>
      _$SelectedResourcesCopyWithImpl<SelectedResources>(
          this as SelectedResources, _$identity);

  /// Serializes this SelectedResources to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SelectedResources &&
            const DeepCollectionEquality()
                .equals(other.selectedResourceIds, selectedResourceIds) &&
            const DeepCollectionEquality()
                .equals(other.unselectedResourceIds, unselectedResourceIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(selectedResourceIds),
      const DeepCollectionEquality().hash(unselectedResourceIds));

  @override
  String toString() {
    return 'SelectedResources(selectedResourceIds: $selectedResourceIds, unselectedResourceIds: $unselectedResourceIds)';
  }
}

/// @nodoc
abstract mixin class $SelectedResourcesCopyWith<$Res> {
  factory $SelectedResourcesCopyWith(
          SelectedResources value, $Res Function(SelectedResources) _then) =
      _$SelectedResourcesCopyWithImpl;
  @useResult
  $Res call({List<int> selectedResourceIds, List<int> unselectedResourceIds});
}

/// @nodoc
class _$SelectedResourcesCopyWithImpl<$Res>
    implements $SelectedResourcesCopyWith<$Res> {
  _$SelectedResourcesCopyWithImpl(this._self, this._then);

  final SelectedResources _self;
  final $Res Function(SelectedResources) _then;

  /// Create a copy of SelectedResources
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedResourceIds = null,
    Object? unselectedResourceIds = null,
  }) {
    return _then(_self.copyWith(
      selectedResourceIds: null == selectedResourceIds
          ? _self.selectedResourceIds
          : selectedResourceIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      unselectedResourceIds: null == unselectedResourceIds
          ? _self.unselectedResourceIds
          : unselectedResourceIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SelectedResources implements SelectedResources {
  _SelectedResources(
      {required final List<int> selectedResourceIds,
      required final List<int> unselectedResourceIds})
      : _selectedResourceIds = selectedResourceIds,
        _unselectedResourceIds = unselectedResourceIds;
  factory _SelectedResources.fromJson(Map<String, dynamic> json) =>
      _$SelectedResourcesFromJson(json);

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

  /// Create a copy of SelectedResources
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SelectedResourcesCopyWith<_SelectedResources> get copyWith =>
      __$SelectedResourcesCopyWithImpl<_SelectedResources>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SelectedResourcesToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SelectedResources &&
            const DeepCollectionEquality()
                .equals(other._selectedResourceIds, _selectedResourceIds) &&
            const DeepCollectionEquality()
                .equals(other._unselectedResourceIds, _unselectedResourceIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_selectedResourceIds),
      const DeepCollectionEquality().hash(_unselectedResourceIds));

  @override
  String toString() {
    return 'SelectedResources(selectedResourceIds: $selectedResourceIds, unselectedResourceIds: $unselectedResourceIds)';
  }
}

/// @nodoc
abstract mixin class _$SelectedResourcesCopyWith<$Res>
    implements $SelectedResourcesCopyWith<$Res> {
  factory _$SelectedResourcesCopyWith(
          _SelectedResources value, $Res Function(_SelectedResources) _then) =
      __$SelectedResourcesCopyWithImpl;
  @override
  @useResult
  $Res call({List<int> selectedResourceIds, List<int> unselectedResourceIds});
}

/// @nodoc
class __$SelectedResourcesCopyWithImpl<$Res>
    implements _$SelectedResourcesCopyWith<$Res> {
  __$SelectedResourcesCopyWithImpl(this._self, this._then);

  final _SelectedResources _self;
  final $Res Function(_SelectedResources) _then;

  /// Create a copy of SelectedResources
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? selectedResourceIds = null,
    Object? unselectedResourceIds = null,
  }) {
    return _then(_SelectedResources(
      selectedResourceIds: null == selectedResourceIds
          ? _self._selectedResourceIds
          : selectedResourceIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      unselectedResourceIds: null == unselectedResourceIds
          ? _self._unselectedResourceIds
          : unselectedResourceIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

// dart format on
