// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_movies_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TMDBMoviesResponse _$TMDBMoviesResponseFromJson(Map<String, dynamic> json) =>
    _TMDBMoviesResponse(
      page: (json['page'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => TMDBMovie.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalItems: (json['total_results'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
      errors: (json['errors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TMDBMoviesResponseToJson(_TMDBMoviesResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_results': instance.totalItems,
      'total_pages': instance.totalPages,
      'errors': instance.errors,
    };
