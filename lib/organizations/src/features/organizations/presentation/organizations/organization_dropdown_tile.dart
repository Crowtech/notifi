import 'package:flutter/material.dart';
import 'package:notifi/models/organization.dart';
import 'package:notifi/organizations/src/common_widgets/nest_poster.dart';


class OrganizationDropdownTile extends StatelessWidget {
  const OrganizationDropdownTile({
    super.key,
    required this.organization,
    // debugging hint to show the tile index
    this.debugIndex,
    this.onPressed,
  });
  final Organization organization;
  final int? debugIndex;
  final VoidCallback? onPressed;

  static const posterHeight = 30.0;

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
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              
              ],
            ),
          )
        ],
      ),
    );
  }
}
