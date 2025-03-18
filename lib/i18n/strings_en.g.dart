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
	String get notfound_404 => '404 - Page not found!';
	late final TranslationsMenuEn menu = TranslationsMenuEn._(_root);
	String get about_us => 'About Us';
	late final TranslationsAccountEn account = TranslationsAccountEn._(_root);
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
	String get image_uploaded_success => 'Image uploaded successfully';
	String get image_uploaded_failure => 'Image failed to upload';
	String get intro_title => 'Welcome to Crowtech';
	String get intro_description => 'Advanced Design';
	String get location_permission_denied => 'Location permissions are denied';
	String get location_services_disabled => 'Location services are disabled. Please enable the services';
	String get location_permission_permanent_denied => 'Location permissions are permanently denied, we cannot request permissions.';
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
	String get openstreetmap => 'OpenStreetMap contributors';
	late final TranslationsResourceEn resource = TranslationsResourceEn._(_root);
	late final TranslationsResourcesEn resources = TranslationsResourcesEn._(_root);
	late final TranslationsResponseEn response = TranslationsResponseEn._(_root);
	late final TranslationsSelectEn select = TranslationsSelectEn._(_root);
	String get privacy_policy => 'Privacy Policy';
	String get profile => 'Profile';
	String get pulltorefresh => 'Pull to refresh';
	String get reset_offset => 'Reset Offset';
	String get resetting_exposure_point => 'Resetting exposure point';
	String get resetting_focus_point => 'Resetting focus point';
	late final TranslationsSearchEn search = TranslationsSearchEn._(_root);
	String get settings => 'Settings';
	String get splash_text => 'Splash Screen';
	String get still => 'Still';
	String get terms_and_conditions => 'Terms & Conditions';
	String get test_page => 'Test Page';
	late final TranslationsUnknownEn unknown = TranslationsUnknownEn._(_root);
	String get update_account => 'Update Account';
	String get zoom_in => 'Zoom In';
	String get zoom_out => 'Zoom out';
	Map<String, String> get locales => {
		'en': 'English',
		'zh': 'Chinese',
	};
}

// Path: menu
class TranslationsMenuEn {
	TranslationsMenuEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get account => 'Account Menu';
	String get product => 'Product Menu';
}

// Path: account
class TranslationsAccountEn {
	TranslationsAccountEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Account';
	String get change_password => 'Change password';
	String get email_taken => 'Email already taken.';
	String get firstname_characters_bad => 'Firstname must not contain non Alphabetic characters';
	String get lastname_characters_bad => 'Lastname must only contain Alphabetic characters, spaces, or dashes';
	String get avatar_url => 'Choose from gallery';
	String get organisation_name_taken => 'Organisation already taken';
	String get take_a_picture => 'Take a picture';
	String get update => 'Update User Account';
	String get update_failure => 'Update failed';
	String get update_success => 'Update successful';
	String get username_taken => 'Username already taken.';
}

// Path: resource
class TranslationsResourceEn {
	TranslationsResourceEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get artifact => 'Artifact';
	String get equipment => 'Equipment';
	String get location => 'Location';
	String get organization => 'Organization';
	String get person => 'Person';
	String get unknown => 'Unknown';
	String get vehicle => 'Vehicle';
}

// Path: resources
class TranslationsResourcesEn {
	TranslationsResourcesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get artifact => 'Artifacts';
	String get equipment => 'Equipment';
	String get location => 'Locations';
	String get organization => 'Organizations';
	String get person => 'People';
	String get unknown => 'Unknown';
	String get vehicle => 'Vehicles';
}

// Path: response
class TranslationsResponseEn {
	TranslationsResponseEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get ok => 'OK';
	String get cancel => 'Cancel';
	String get reset => 'Reset';
}

// Path: select
class TranslationsSelectEn {
	TranslationsSelectEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get departments => 'Select Departments ..';
	String get drivers => 'Select Drivers ..';
	String get groups => 'Select Groups ..';
	String get items => 'Select Items ..';
	String get organizations => 'Select Organizations ..';
	String get equipment => 'Select Equipment ..';
	String get locations => 'Select Locations ..';
	String get members => 'Select Members';
	String get people => 'Select People ..';
	String get resources => 'Select Resources ..';
	String get teams => 'Select Teams ..';
	String get vehicles => 'Select Vehicles ..';
}

// Path: search
class TranslationsSearchEn {
	TranslationsSearchEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get artifact => 'Search by name';
	String get equipment => 'Search by name or model...';
	String get location => 'Search by location name...';
	String get organization => 'Search by name or web address...';
	String get person => 'Search by name or email...';
	String get unknown => 'Search by name';
	String get vehicle => 'Search by vehicle name or code...';
}

// Path: unknown
class TranslationsUnknownEn {
	TranslationsUnknownEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get person => 'Unnamed User';
	String get organization => 'Unnamed Organization';
	String get group => 'Unnamed Group';
	String get equipment => 'Unnamed Equipment';
	String get artifact => 'Unnamed Artifact';
	String get location => 'Unnamed Location';
	String get resource => 'Unnamed Resource';
	String get unknown => 'Unknown';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app_title': return 'Crowtech';
			case 'notfound_404': return '404 - Page not found!';
			case 'menu.account': return 'Account Menu';
			case 'menu.product': return 'Product Menu';
			case 'about_us': return 'About Us';
			case 'account.title': return 'Account';
			case 'account.change_password': return 'Change password';
			case 'account.email_taken': return 'Email already taken.';
			case 'account.firstname_characters_bad': return 'Firstname must not contain non Alphabetic characters';
			case 'account.lastname_characters_bad': return 'Lastname must only contain Alphabetic characters, spaces, or dashes';
			case 'account.avatar_url': return 'Choose from gallery';
			case 'account.organisation_name_taken': return 'Organisation already taken';
			case 'account.take_a_picture': return 'Take a picture';
			case 'account.update': return 'Update User Account';
			case 'account.update_failure': return 'Update failed';
			case 'account.update_success': return 'Update successful';
			case 'account.username_taken': return 'Username already taken.';
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
			case 'image_uploaded_success': return 'Image uploaded successfully';
			case 'image_uploaded_failure': return 'Image failed to upload';
			case 'intro_title': return 'Welcome to Crowtech';
			case 'intro_description': return 'Advanced Design';
			case 'location_permission_denied': return 'Location permissions are denied';
			case 'location_services_disabled': return 'Location services are disabled. Please enable the services';
			case 'location_permission_permanent_denied': return 'Location permissions are permanently denied, we cannot request permissions.';
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
			case 'openstreetmap': return 'OpenStreetMap contributors';
			case 'resource.artifact': return 'Artifact';
			case 'resource.equipment': return 'Equipment';
			case 'resource.location': return 'Location';
			case 'resource.organization': return 'Organization';
			case 'resource.person': return 'Person';
			case 'resource.unknown': return 'Unknown';
			case 'resource.vehicle': return 'Vehicle';
			case 'resources.artifact': return 'Artifacts';
			case 'resources.equipment': return 'Equipment';
			case 'resources.location': return 'Locations';
			case 'resources.organization': return 'Organizations';
			case 'resources.person': return 'People';
			case 'resources.unknown': return 'Unknown';
			case 'resources.vehicle': return 'Vehicles';
			case 'response.ok': return 'OK';
			case 'response.cancel': return 'Cancel';
			case 'response.reset': return 'Reset';
			case 'select.departments': return 'Select Departments ..';
			case 'select.drivers': return 'Select Drivers ..';
			case 'select.groups': return 'Select Groups ..';
			case 'select.items': return 'Select Items ..';
			case 'select.organizations': return 'Select Organizations ..';
			case 'select.equipment': return 'Select Equipment ..';
			case 'select.locations': return 'Select Locations ..';
			case 'select.members': return 'Select Members';
			case 'select.people': return 'Select People ..';
			case 'select.resources': return 'Select Resources ..';
			case 'select.teams': return 'Select Teams ..';
			case 'select.vehicles': return 'Select Vehicles ..';
			case 'privacy_policy': return 'Privacy Policy';
			case 'profile': return 'Profile';
			case 'pulltorefresh': return 'Pull to refresh';
			case 'reset_offset': return 'Reset Offset';
			case 'resetting_exposure_point': return 'Resetting exposure point';
			case 'resetting_focus_point': return 'Resetting focus point';
			case 'search.artifact': return 'Search by name';
			case 'search.equipment': return 'Search by name or model...';
			case 'search.location': return 'Search by location name...';
			case 'search.organization': return 'Search by name or web address...';
			case 'search.person': return 'Search by name or email...';
			case 'search.unknown': return 'Search by name';
			case 'search.vehicle': return 'Search by vehicle name or code...';
			case 'settings': return 'Settings';
			case 'splash_text': return 'Splash Screen';
			case 'still': return 'Still';
			case 'terms_and_conditions': return 'Terms & Conditions';
			case 'test_page': return 'Test Page';
			case 'unknown.person': return 'Unnamed User';
			case 'unknown.organization': return 'Unnamed Organization';
			case 'unknown.group': return 'Unnamed Group';
			case 'unknown.equipment': return 'Unnamed Equipment';
			case 'unknown.artifact': return 'Unnamed Artifact';
			case 'unknown.location': return 'Unnamed Location';
			case 'unknown.resource': return 'Unnamed Resource';
			case 'unknown.unknown': return 'Unknown';
			case 'update_account': return 'Update Account';
			case 'zoom_in': return 'Zoom In';
			case 'zoom_out': return 'Zoom out';
			case 'locales.en': return 'English';
			case 'locales.zh': return 'Chinese';
			default: return null;
		}
	}
}

