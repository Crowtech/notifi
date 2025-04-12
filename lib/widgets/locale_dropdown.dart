import 'package:flutter/material.dart';

class LocaleDropdown extends StatefulWidget {
  const LocaleDropdown({super.key});

  @override
  _LocaleDropdownState createState() => _LocaleDropdownState();
}

class _LocaleDropdownState extends State<LocaleDropdown> {
  Locale _selectedLocale = const Locale('en'); // default locale is English

  final List<Locale> _locales = [
    const Locale('en'), // English
    const Locale('zh', 'CN'), // Simplified Chinese
  ];

  final Map<Locale, String> _localeNames = {
    const Locale('en'): 'English',
    const Locale('zh', 'CN'): '简体中文', // Simplified Chinese
  };

  void _changeLocale(Locale locale) {
    setState(() {
      _selectedLocale = locale;
    });
    // Update the app locale
    // You can use a state management solution like Provider or Riverpod to update the app locale
    // For simplicity, we'll just use a static variable here
    //Localizations.localeOf(context) = locale;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Locale>(
      value: _selectedLocale,
      onChanged: (locale) {
        if (locale != null) {
          _changeLocale(locale);
        }
      },
      items: _locales.map((locale) {
        return DropdownMenuItem<Locale>(
          value: locale,
          child: Text(_localeNames[locale]!),
        );
      }).toList(),
    );
  }
}
