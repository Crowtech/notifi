import 'package:flutter/material.dart';
import 'package:notifi/movies/domain/tmdb_movie.dart';
import 'package:notifi/movies/movie_poster.dart';
import 'package:notifi/organizations/src/common_widgets/top_gradient.dart';

class MovieListTile extends StatelessWidget {
  const MovieListTile({
    super.key,
    required this.movie,
    // debugging hint to show the tile index
    this.debugIndex,
    this.onPressed,
  });
  final TMDBMovie movie;
  final int? debugIndex;
  final VoidCallback? onPressed;

  static const posterHeight = 80.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: onPressed,
            child: Stack(
              children: [
                SizedBox(
                  width: posterHeight * MoviePoster.width / MoviePoster.height,
                  height: posterHeight,
                  child: MoviePoster(imagePath: movie.posterPath),
                ),
                if (debugIndex != null) ...[
                  const Positioned.fill(child: TopGradient()),
                  Positioned(
                    left: 4,
                    top: 4,
                    child: Text(
                      '$debugIndex',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ]
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (movie.releaseDate != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Released: ${movie.releaseDate}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ],
            ),
          )
        ],
      ),
    );
  }
}
