import 'package:flutter/material.dart';
import 'package:notifi/riverpod/language/language_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;

part 'localization_provider.g.dart';

/// provider used to access the AppLocalizations object for the current locale
@riverpod
/*nt.AppLocaleUtils*/ nt.AppLocaleUtils appLocalizations(AppLocalizationsRef ref) {
  //AppLocalizations appLocalizations(AppLocalizationsRef ref) {
  // Watch for language saved in the database. If there is none, use the device locale
  final language = ref.watch(currentLanguageProvider).asData?.value;
  final List<String> supportedLocales = nt.AppLocaleUtils.supportedLocalesRaw;
  if (language != null && supportedLocales.contains(language.code)) {
    // 2. initialize from the saved language
 
   Locale locale = basicLocaleListResolution([Locale(language.code)], nt.AppLocaleUtils.supportedLocales);
    ref.state = nt.AppLocaleUtils.instance; //lookupAppLocalizations(locale);
   //ref.state = lookupAppLocalizations(basicLocaleListResolution([Locale(language.code)], AppLocalizations.supportedLocales)); supportedLocales

  } else {
    // 1. initialize from the initial locale
    ref.state = nt.AppLocaleUtils.instance; //lookupAppLocalizations(basicLocaleListResolution(
       // [WidgetsBinding.instance.platformDispatcher.locale], nt.AppLocaleUtils.supportedLocales));
  }

  // 2. create an observer to update the state


  final observer = _LocaleObserver((locales) {
    ref.state = nt.AppLocaleUtils.instance; //lookupAppLocalizations(basicLocaleListResolution(
       // [WidgetsBinding.instance.platformDispatcher.locale], nt.AppLocaleUtils.supportedLocales));
  });
  // 3. register the observer and dispose it when no longer needed
  final binding = WidgetsBinding.instance;
  binding.addObserver(observer);
  ref.onDispose(() => binding.removeObserver(observer));
  // 4. return the state
  return ref.state;
}

/// observer used to notify the caller when the locale changes
class _LocaleObserver extends WidgetsBindingObserver {
  _LocaleObserver(this._didChangeLocales);
  final void Function(List<Locale>? locales) _didChangeLocales;
  @override
  void didChangeLocales(List<Locale>? locales) {
    _didChangeLocales(locales);
  }
}

//  Switch(
//               value: TranslationProvider.of(context).locale == AppLocale.es,
//               onChanged: (languageSwitched) {
//                 final newLocale =
//                     languageSwitched ? AppLocale.es : AppLocale.en;
//                 LocaleSettings.setLocale(newLocale);
//               },
//             ),