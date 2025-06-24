// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TMDBMovieBasic _$TMDBMovieBasicFromJson(Map<String, dynamic> json) =>
    _TMDBMovieBasic(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String?,
    );

Map<String, dynamic> _$TMDBMovieBasicToJson(_TMDBMovieBasic instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate,
    };
