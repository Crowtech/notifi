import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/registrations_repository.dart';
import '../../../../../../models/registration.dart';
import '../registrations/registration_list_tile.dart';
import '../registrations/registration_list_tile_shimmer.dart';

import 'package:notifi/i18n/strings.g.dart' as nt;


class RegistrationDetailsScreen extends ConsumerWidget {
  const RegistrationDetailsScreen(
      {super.key, required this.registrationId, required this.registration});
  final int registrationId;
  final Registration? registration;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (registration != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(registration!.name!),
        ),
        body: Column(
          children: [
            RegistrationListTile(registration: registration!),
          ],
        ),
      );
    } else {
      final registrationAsync = ref.watch(registrationProvider(registrationId: registrationId));
      return registrationAsync.when(
        error: (e, st) => Scaffold(
          appBar: AppBar(
            title: Text(registration?.name ?? nt.t.error),
          ),
          body: Center(child: Text(e.toString())),
        ),
        loading: () => Scaffold(
          appBar: AppBar(
            title: Text(registration?.name ?? nt.t.loading),
          ),
          body: const Column(
            children: [
              RegistrationListTileShimmer(),
            ],
          ),
        ),
        data: (registration) => Scaffold(
          appBar: AppBar(
            title: Text(registration.name!),
          ),
          body: Column(
            children: [
              RegistrationListTile(registration: registration),
            ],
          ),
        ),
      );
    }
  }
}
