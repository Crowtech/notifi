import 'package:flutter/material.dart';
import 'package:notifi/norganizations/domain/norganization.dart';
import 'package:notifi/organizations/src/common_widgets/nest_poster.dart';

import 'package:notifi/organizations/src/common_widgets/top_gradient.dart';
import 'package:notifi/norganizations/norganization_poster.dart';

class NOrganizationListTile extends StatelessWidget {
  const NOrganizationListTile({
    super.key,
    required this.norganization,
    // debugging hint to show the tile index
    this.debugIndex,
    this.onPressed,
  });
  final NOrganization norganization;
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
                  width: posterHeight * NOrganizationPoster.width / NOrganizationPoster.height,
                  height: posterHeight,
                  child: NestPoster(imagePath: norganization.avatarUrl),
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
                  norganization.name!,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (norganization.created != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Released: ${norganization.created}',
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
