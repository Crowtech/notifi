import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../features/organizations/domain/list_poster.dart';


class NestPoster extends StatelessWidget {
  const NestPoster({super.key, this.imagePath});
  final String? imagePath;

  static const width = 154.0;
  static const height = 231.0;

  @override
  Widget build(BuildContext context) {
    if (imagePath != null) {
      return CachedNetworkImage(
        //fit: BoxFit.fitWidth,
        imageUrl: ListPoster.imageUrl(imagePath!, PosterSize.w154),
        placeholder: (_, __) => Shimmer.fromColors(
          baseColor: Colors.black26,
          highlightColor: Colors.black12,
          child: Container(
            width: width,
            height: height,
            color: Colors.black,
          ),
        ),
      );
    }
    return const Placeholder(
      color: Colors.black87,
    );
  }
}
