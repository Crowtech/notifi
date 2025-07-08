import 'package:flutter/material.dart';
import 'package:notifi/models/person.dart';
import 'package:notifi/organizations/src/common_widgets/nest_poster.dart';

import 'package:notifi/organizations/src/common_widgets/top_gradient.dart';
import '../../nperson_poster.dart';

class NPersonListTile extends StatelessWidget {
  const NPersonListTile({
    super.key,
    required this.nperson,
    // debugging hint to show the tile index
    this.debugIndex,
    this.onPressed,
  });
  final Person nperson;
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
                  width: posterHeight * NPersonPoster.width / NPersonPoster.height,
                  height: posterHeight,
                  child: NestPoster(imagePath: nperson.avatarUrl),
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
                  nperson.name!,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (nperson.created != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Released: ${nperson.created}',
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
