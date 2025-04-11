import 'package:flutter/material.dart';
import 'package:notifi/models/organization.dart';
import 'package:notifi/organizations/src/common_widgets/nest_poster.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;


class OrganizationListTile extends StatelessWidget {
  const OrganizationListTile({
    super.key,
    required this.organization,
    // debugging hint to show the tile index
    this.debugIndex,
    this.onPressed,
  });
  final Organization organization;
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
                  width: posterHeight * NestPoster.width / NestPoster.height,
                  height: posterHeight,
                  child: NestPoster(imagePath: organization.getAvatarUrl()),
                ),
                // if (debugIndex != null) ...[
                //   const Positioned.fill(child: TopGradient()),
                //   Positioned(
                //     left: 4,
                //     top: 4,
                //     child: Text(
                //       '$debugIndex',
                //       style: const TextStyle(color: Colors.white, fontSize: 14),
                //     ),
                //   ),
                // ]
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  organization.name!,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (organization.created != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    '${nt.t.created}: ${organization.created}',
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
