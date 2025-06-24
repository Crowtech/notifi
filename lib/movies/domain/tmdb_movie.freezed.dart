// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tmdb_movie.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
TMDBMovie _$TMDBMovieFromJson(Map<String, dynamic> json) {
  return _TMDBMovieBasic.fromJson(json);
}

/// @nodoc
mixin _$TMDBMovie {
  int get id;
  String get title;
  @JsonKey(name: 'poster_path')
  String? get posterPath;
  @JsonKey(name: 'release_date')
  String? get releaseDate;

  /// Create a copy of TMDBMovie
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TMDBMovieCopyWith<TMDBMovie> get copyWith =>
      _$TMDBMovieCopyWithImpl<TMDBMovie>(this as TMDBMovie, _$identity);

  /// Serializes this TMDBMovie to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TMDBMovie &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, posterPath, releaseDate);

  @override
  String toString() {
    return 'TMDBMovie(id: $id, title: $title, posterPath: $posterPath, releaseDate: $releaseDate)';
  }
}

/// @nodoc
abstract mixin class $TMDBMovieCopyWith<$Res> {
  factory $TMDBMovieCopyWith(TMDBMovie value, $Res Function(TMDBMovie) _then) =
      _$TMDBMovieCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String title,
      @JsonKey(name: 'poster_path') String? posterPath,
      @JsonKey(name: 'release_date') String? releaseDate});
}

/// @nodoc
class _$TMDBMovieCopyWithImpl<$Res> implements $TMDBMovieCopyWith<$Res> {
  _$TMDBMovieCopyWithImpl(this._self, this._then);

  final TMDBMovie _self;
  final $Res Function(TMDBMovie) _then;

  /// Create a copy of TMDBMovie
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? posterPath = freezed,
    Object? releaseDate = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      posterPath: freezed == posterPath
          ? _self.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseDate: freezed == releaseDate
          ? _self.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TMDBMovieBasic implements TMDBMovie {
  _TMDBMovieBasic(
      {required this.id,
      required this.title,
      @JsonKey(name: 'poster_path') this.posterPath,
      @JsonKey(name: 'release_date') this.releaseDate});
  factory _TMDBMovieBasic.fromJson(Map<String, dynamic> json) =>
      _$TMDBMovieBasicFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @override
  @JsonKey(name: 'release_date')
  final String? releaseDate;

  /// Create a copy of TMDBMovie
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TMDBMovieBasicCopyWith<_TMDBMovieBasic> get copyWith =>
      __$TMDBMovieBasicCopyWithImpl<_TMDBMovieBasic>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TMDBMovieBasicToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TMDBMovieBasic &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, posterPath, releaseDate);

  @override
  String toString() {
    return 'TMDBMovie(id: $id, title: $title, posterPath: $posterPath, releaseDate: $releaseDate)';
  }
}

/// @nodoc
abstract mixin class _$TMDBMovieBasicCopyWith<$Res>
    implements $TMDBMovieCopyWith<$Res> {
  factory _$TMDBMovieBasicCopyWith(
          _TMDBMovieBasic value, $Res Function(_TMDBMovieBasic) _then) =
      __$TMDBMovieBasicCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      @JsonKey(name: 'poster_path') String? posterPath,
      @JsonKey(name: 'release_date') String? releaseDate});
}

/// @nodoc
class __$TMDBMovieBasicCopyWithImpl<$Res>
    implements _$TMDBMovieBasicCopyWith<$Res> {
  __$TMDBMovieBasicCopyWithImpl(this._self, this._then);

  final _TMDBMovieBasic _self;
  final $Res Function(_TMDBMovieBasic) _then;

  /// Create a copy of TMDBMovie
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? posterPath = freezed,
    Object? releaseDate = freezed,
  }) {
    return _then(_TMDBMovieBasic(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      posterPath: freezed == posterPath
          ? _self.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseDate: freezed == releaseDate
          ? _self.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
