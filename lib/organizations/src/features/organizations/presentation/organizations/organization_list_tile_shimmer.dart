import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:notifi/organizations/src/common_widgets/nest_poster.dart';

import 'organization_list_tile.dart';

class OrganizationListTileShimmer extends StatelessWidget {
  const OrganizationListTileShimmer({super.key});

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
              width: OrganizationListTile.posterHeight *
                  NestPoster.width /
                  NestPoster.height,
              height: OrganizationListTile.posterHeight,
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
