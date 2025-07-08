import 'package:flutter/material.dart';


import '../../../../../../organizations/src/common_widgets/nest_poster.dart';
import '../../../../../../organizations/src/common_widgets/top_gradient.dart';
import '../../../../../../models/registration.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;

class RegistrationListTile extends StatelessWidget {
  const RegistrationListTile({
    super.key,
    required this.registration,
    // debugging hint to show the tile index
    this.debugIndex,
    this.onPressed,
  });
  final Registration registration;
  final int? debugIndex;
  final VoidCallback? onPressed;

  static const posterHeight = 80.0;

  @override
  Widget build(BuildContext context) {
    String inviteeAvatar = registration.getAvatarUrl();
      if (registration.organization!=null) {
      if (registration.organization?.getAvatarUrl() != null) {
        inviteeAvatar = registration.organization!.getAvatarUrl();
      } 
    }
   
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
                  child: NestPoster(imagePath: inviteeAvatar),
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
                  "${nt.t.invite.invitee}: ${registration.email} ${registration.inviteeFirstname ?? ''} ${registration.inviteeLastname ?? ''}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "${nt.t.invite.organization}: ${registration.organization!.name} ",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "${nt.t.invite.inviter}: ${registration.inviter!.name} ",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                 Text(
                  "${nt.t.invite.approver}: ${registration.approver!.name} ",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (registration.created != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    '${nt.t.created}: ${registration.created}',
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
