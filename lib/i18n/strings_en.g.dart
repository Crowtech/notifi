///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	String get app_title => 'Crowtech';
	String get deviceid => 'DeviceID';
	String get email => 'Email';
	String get firstname => 'Firstname';
	String get intro_title => 'Welcome to Crowtech';
	String get intro_description => 'Advanced Design';
	String get movement_status => 'Is Moving?';
	String get highlight_title => 'Generate Context-Aware Translations';
	String get highlight_description => 'Generate context-aware aware translatinons with GPT';
	String get lastname => 'Lastname';
	String get login => 'Login';
	String get logout => 'Logout';
	String get moving => 'Moving';
	String get odometer => 'Odometer';
	String get still => 'Still';
	Map<String, String> get locales => {
		'en': 'English',
		'zh': 'Chinese',
	};
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app_title': return 'Crowtech';
			case 'deviceid': return 'DeviceID';
			case 'email': return 'Email';
			case 'firstname': return 'Firstname';
			case 'intro_title': return 'Welcome to Crowtech';
			case 'intro_description': return 'Advanced Design';
			case 'movement_status': return 'Is Moving?';
			case 'highlight_title': return 'Generate Context-Aware Translations';
			case 'highlight_description': return 'Generate context-aware aware translatinons with GPT';
			case 'lastname': return 'Lastname';
			case 'login': return 'Login';
			case 'logout': return 'Logout';
			case 'moving': return 'Moving';
			case 'odometer': return 'Odometer';
			case 'still': return 'Still';
			case 'locales.en': return 'English';
			case 'locales.zh': return 'Chinese';
			default: return null;
		}
	}
}

