// ignore_for_file: strict_raw_type

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:logger/logger.dart' as logger;

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

/// Useful to log state change in our application
/// Read the logs and you'll better understand what's going on under the hood
/// 
/// 
/// flutter:   newValue: AsyncData<Auth>(value: Auth.signedIn(id: 1201, displayName: Panta, 
/// email: hello@pantagroup.org, resourcecode: PER_2DC66E1A_A275_4EFF_AD81_C1F1A7CCA6E0, 
/// token: eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJLMEk0UjMzc1Z3ZkJ3TU02V0czSHNrRmo4WUxqUXYyRXpoc2cwREJNc1o0In0.eyJleHAiOjE3Mzk3NjEwMTEsImlhdCI6MTczOTc2MDcxMSwiYXV0aF90aW1lIjoxNzM5NzYwNDEyLCJqdGkiOiI5NTQ0MzRkZi1kM2VhLTQyYTEtOGQwOS0yODI4NTVhOTNlNzUiLCJpc3MiOiJodHRwczovL2F1dGgucGFudGFncm91cC5vcmcvcmVhbG1zL3BhbnRhIiwiYXVkIjoiYWNjb3VudCIsInN1YiI6IjJkYzY2ZTFhLWEyNzUtNGVmZi1hZDgxLWMxZjFhN2NjYTZlMCIsInR5cCI6IkJlYXJlciIsImF6cCI6InBhbnRhIiwic2lkIjoiY2Y2ZjZhYjItZWQyYy00NTgxLWE2ZmYtZmVhYTRkNmY2MGI3IiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwczovL2FwcC5wYW50YWdyb3VwLm9yZyIsImh0dHBzOi8vb2ZmaWNlci5wYW50YS5zb2x1dGlvbnMiLCJodHRwOi8vbG9jYWxob3N0OjUwMDAiLCJodHRwczovL2FwaS5wYW50YWdyb3VwLm9yZyIsIioiLCJodHRwOi8vbG9jYWxob3N0IiwiaHR0cHM6Ly9kYXNoLnBhbnRhLnNvbHV0aW9ucyJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiZGV2Iiwib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiIsImRlZmF1bHQtcm9sZXMtcGFudGEiLCJ1c2VyIl19LCJyZXNvdXJjZV9hY2Nlc3MiOnsiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJvcGVuaWQgcHJvZmlsZSBhZGRyZXNzIGVtYWlsIG9mZmxpbmVfYWNjZXNzIiwiYWRkcmVzcyI6e30sImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoiUGFudGEgRGV2IiwicHJlZmVycmVkX3VzZXJuYW1lIjoiaGVsbG9AcGFudGFncm91cC5vcmciLCJnaXZlbl9uYW1lIjoiUGFudGEiLCJmYW1pbHlfbmFtZSI6IkRldiIsImVtYWlsIjoiaGVsbG9AcGFudGFncm91cC5vcmcifQ.Eh0uUPM86PcCD-JUMuRpR5g21n8pejeolrKt5G3OreNSA_bDtiUee-HIHUa5ckdxyLqL39o0NDRQoCl9YlegPaV6MgAbQr_AHr-Q8jVASM1pYApkxx8ozRHOQ9uiAU2pb5mNGLWnb3eV-_vEsK1TgSC60xvrITVY50tfSzT3F0dkuWHvIUt44iQV0ELvjmKTMrlLWMgkuRez_fxuvOnE2EgDw34tvKaIkxud-nRu7mY_1rjppfeySN-NxlIV79kEdlHEcp6ohVwfjyZfsYcn99IK7dMc_6pYd2T5oPrPm6b-kqxnnvwCNYoUoDOCqXtlCeFbJP7DDaEt3O_Axg_E5g))
//flutter: }
/// 
/// 
class StateLogger extends ProviderObserver {
  const StateLogger();
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    debugPrint('''
{
  provider: ${provider.name ?? provider.runtimeType},
  oldValue: $previousValue,
  newValue: $newValue
}
''');
// if (provider.name == "authControllerProvider") {
//   int startPos = newValue.toString().indexOf("Auth.signedIn");
//   String authStr = newValue.toString().substring(startPos);
//   int endPos = authStr.toString().indexOf("))");
//   authStr = authStr.substring(0,endPos);
//     logNoStack.i("Auth is signed in :$authStr");
// }
  }
}
