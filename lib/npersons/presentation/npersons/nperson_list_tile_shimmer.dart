import 'package:flutter/material.dart';
import 'package:notifi/npersons/nperson_poster.dart';
import 'package:notifi/npersons/presentation/npersons/nperson_list_tile.dart';
import 'package:shimmer/shimmer.dart';

class NPersonListTileShimmer extends StatelessWidget {
  const NPersonListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black26,
      highlightColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Container(
              width: NPersonListTile.posterHeight *
                  NPersonPoster.width /
                  NPersonPoster.height,
              height: NPersonListTile.posterHeight,
              color: Colors.black,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 20.0,
                    color: Colors.black,
                    margin: const EdgeInsets.only(bottom: 8.0),
                  ),
                  Container(
                    width: 100.0,
                    height: 15.0,
                    color: Colors.black,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
