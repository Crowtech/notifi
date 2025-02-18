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
	late final TranslationsMenuEn menu = TranslationsMenuEn.internal(_root);
	String get about_us => 'About Us';
	String get account => 'Account';
	String get activity => 'Activity';
	String get audio_access_denied => 'You have denied audio access';
	String get audio_access_denied_without_prompt => 'Please go to Settings app to enable audio access';
	String get audio_access_restricted => 'Audio access is restricted';
	String authored_by({required Object name}) => 'by ${name}';
	String get auto => 'Auto';
	String get billing => 'Billing';
	String get camera_title => 'Camera';
	String get camera_access_denied_without_prompt => 'Please go to Settings app to enable camera access.';
	String get camera_access_restricted => 'Camera access is restricted';
	String get camera_denied => 'Camera access denied by user.';
	String get camera_not_found => 'No camera found.';
	String get dashboard => 'Dashboard';
	String get deviceid => 'DeviceID';
	String get edit => 'Edit';
	String get email => 'Email';
	String get exposure_mode => 'Exposure Mode';
	String get exposure_offset => 'Exposure Offset';
	String get favourite => 'Favourite';
	String get firstname => 'Firstname';
	String get focus_mode => 'Focus Mode';
	String get groups => 'Groups';
	String get help => 'Help';
	String get home => 'Home';
	String get intro_title => 'Welcome to Crowtech';
	String get intro_description => 'Advanced Design';
	String get locked => 'Locked';
	String get map => 'Map';
	String get members => 'Members';
	String get movement_status => 'Is Moving?';
	String get none => 'None';
	String get highlight_title => 'Generate Context-Aware Translations';
	String get highlight_description => 'Generate context-aware aware translatinons with GPT';
	String get lastname => 'Lastname';
	String get login => 'Login';
	String get login_page => 'Login Page';
	String get logout => 'Logout';
	String get messages => 'Messages';
	String get moving => 'Moving';
	String get odometer => 'Odometer';
	late final TranslationsResponseEn response = TranslationsResponseEn.internal(_root);
	String get privacy_policy => 'Privacy Policy';
	String get profile => 'Profile';
	String get pulltorefresh => 'Pull to refresh';
	String get reset_offset => 'Reset Offset';
	String get resetting_exposure_point => 'Resetting exposure point';
	String get resetting_focus_point => 'Resetting focus point';
	String get settings => 'Settings';
	String get still => 'Still';
	String get terms_and_conditions => 'Terms & Conditions';
	String get test_page => 'Test Page';
	String get zoom_in => 'Zoom In';
	String get zoom_out => 'Zoom out';
	Map<String, String> get locales => {
		'en': 'English',
		'zh': 'Chinese',
	};
}

// Path: menu
class TranslationsMenuEn {
	TranslationsMenuEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get account => 'Account Menu';
	String get product => 'Product Menu';
}

// Path: response
class TranslationsResponseEn {
	TranslationsResponseEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get ok => 'OK';
	String get cancel => 'Cancel';
	String get reset => 'Reset';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app_title': return 'Crowtech';
			case 'menu.account': return 'Account Menu';
			case 'menu.product': return 'Product Menu';
			case 'about_us': return 'About Us';
			case 'account': return 'Account';
			case 'activity': return 'Activity';
			case 'audio_access_denied': return 'You have denied audio access';
			case 'audio_access_denied_without_prompt': return 'Please go to Settings app to enable audio access';
			case 'audio_access_restricted': return 'Audio access is restricted';
			case 'authored_by': return ({required Object name}) => 'by ${name}';
			case 'auto': return 'Auto';
			case 'billing': return 'Billing';
			case 'camera_title': return 'Camera';
			case 'camera_access_denied_without_prompt': return 'Please go to Settings app to enable camera access.';
			case 'camera_access_restricted': return 'Camera access is restricted';
			case 'camera_denied': return 'Camera access denied by user.';
			case 'camera_not_found': return 'No camera found.';
			case 'dashboard': return 'Dashboard';
			case 'deviceid': return 'DeviceID';
			case 'edit': return 'Edit';
			case 'email': return 'Email';
			case 'exposure_mode': return 'Exposure Mode';
			case 'exposure_offset': return 'Exposure Offset';
			case 'favourite': return 'Favourite';
			case 'firstname': return 'Firstname';
			case 'focus_mode': return 'Focus Mode';
			case 'groups': return 'Groups';
			case 'help': return 'Help';
			case 'home': return 'Home';
			case 'intro_title': return 'Welcome to Crowtech';
			case 'intro_description': return 'Advanced Design';
			case 'locked': return 'Locked';
			case 'map': return 'Map';
			case 'members': return 'Members';
			case 'movement_status': return 'Is Moving?';
			case 'none': return 'None';
			case 'highlight_title': return 'Generate Context-Aware Translations';
			case 'highlight_description': return 'Generate context-aware aware translatinons with GPT';
			case 'lastname': return 'Lastname';
			case 'login': return 'Login';
			case 'login_page': return 'Login Page';
			case 'logout': return 'Logout';
			case 'messages': return 'Messages';
			case 'moving': return 'Moving';
			case 'odometer': return 'Odometer';
			case 'response.ok': return 'OK';
			case 'response.cancel': return 'Cancel';
			case 'response.reset': return 'Reset';
			case 'privacy_policy': return 'Privacy Policy';
			case 'profile': return 'Profile';
			case 'pulltorefresh': return 'Pull to refresh';
			case 'reset_offset': return 'Reset Offset';
			case 'resetting_exposure_point': return 'Resetting exposure point';
			case 'resetting_focus_point': return 'Resetting focus point';
			case 'settings': return 'Settings';
			case 'still': return 'Still';
			case 'terms_and_conditions': return 'Terms & Conditions';
			case 'test_page': return 'Test Page';
			case 'zoom_in': return 'Zoom In';
			case 'zoom_out': return 'Zoom out';
			case 'locales.en': return 'English';
			case 'locales.zh': return 'Chinese';
			default: return null;
		}
	}
}

