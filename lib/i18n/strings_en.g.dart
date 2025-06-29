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
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
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

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	String get app_title => 'Crowtech';
	String get notfound_404 => '404 - Page not found!';
	late final TranslationsMenuEn menu = TranslationsMenuEn._(_root);
	String about({required Object name}) => 'About ${name}';
	String get about_us => 'About Us';
	String about_dialog({required Object title, required Object version, required Object deviceid, required Object project}) => '${title}\nVersion	${version}\nDevice	${deviceid}\n\n© ${project} 2024,2025 under license to Crowtech Pty Ltd';
	String get accept_terms_switch => 'I Accept the terms and conditions';
	late final TranslationsAccountEn account = TranslationsAccountEn._(_root);
	String get activity => 'Activity';
	String get audio_access_denied => 'You have denied audio access';
	String get audio_access_denied_without_prompt => 'Please go to Settings app to enable audio access';
	String get audio_access_restricted => 'Audio access is restricted';
	String authored_by({required Object name}) => 'by ${name}';
	String get auto => 'Auto';
	String get attributions => 'Attributions';
	String get billing => 'Billing';
	String get camera_1 => 'Camera 1';
	String get camera_2 => 'Camera 2';
	String get camera_title => 'Camera';
	String get camera_access_denied_without_prompt => 'Please go to Settings app to enable camera access.';
	String get camera_access_restricted => 'Camera access is restricted';
	String get camera_denied => 'Camera access denied by user.';
	String get camera_not_found => 'No camera found.';
	String copied_to_clipboard({required Object item}) => '${item} copied to clipboard';
	String get created => 'Created';
	String get dark => 'dark';
	String get dashboard => 'Dashboard';
	String get deviceid => 'DeviceID';
	String get devpage => 'Dev';
	String get edit => 'Edit';
	String get email => 'Email';
	String get error => 'Error';
	String get exposure_mode => 'Exposure Mode';
	String get exposure_offset => 'Exposure Offset';
	String get favourite => 'Favourite';
	late final TranslationsFormEn form = TranslationsFormEn._(_root);
	String get firstname => 'Firstname';
	String get focus_mode => 'Focus Mode';
	String get groups => 'Groups';
	String get group_types_title => 'Group Types';
	late final TranslationsGroupTypesEn group_types = TranslationsGroupTypesEn._(_root);
	String get help => 'Help';
	String get highlight_title => 'Generate Context-Aware Translations';
	String get highlight_description => 'Generate context-aware aware translatinons with GPT';
	String get home => 'Home';
	String get image_uploaded_success => 'Image uploaded successfully';
	String get image_uploaded_failure => 'Image failed to upload';
	String get intro_title => 'Welcome to Crowtech';
	String get intro_description => 'Advanced Design';
	late final TranslationsInviteEn invite = TranslationsInviteEn._(_root);
	String get language => 'Language';
	String get lastname => 'Lastname';
	String get light => 'light';
	String get loading => 'Loading...';
	String get location_permission_denied => 'Location permissions are denied';
	String get location_services_disabled => 'Location services are disabled. Please enable the services';
	String get location_permission_permanent_denied => 'Location permissions are permanently denied, we cannot request permissions.';
	String get locked => 'Locked';
	String get login => 'Login';
	String get login_page => 'Login Page';
	String get logout => 'Logout';
	String get map => 'Map';
	String get members => 'Members';
	String get member => 'Message';
	String get messages => 'Messages';
	String get movement_status => 'Is Moving?';
	String get moving => 'Moving';
	String get name => 'Name';
	String get next => 'Next';
	String get none => 'None';
	String get odometer => 'Odometer';
	String get openstreetmap => 'OpenStreetMap contributors';
	String get optional => 'Optional';
	String get organization => 'organization';
	String get organization_capitalized => 'Organization';
	String get person => 'person';
	String get person_capitalized => 'Person';
	String get previous => 'Previous';
	String get privacy_policy => 'Privacy Policy';
	String get profile => 'Profile';
	String get pulltorefresh => 'Pull to refresh';
	String get registration => 'registration';
	String get registration_capitalized => 'Registration';
	late final TranslationsResourceEn resource = TranslationsResourceEn._(_root);
	late final TranslationsResourcesEn resources = TranslationsResourcesEn._(_root);
	late final TranslationsResponseEn response = TranslationsResponseEn._(_root);
	String get saving => 'Saving ...';
	late final TranslationsSelectEn select = TranslationsSelectEn._(_root);
	String get reset_offset => 'Reset Offset';
	String get resetting_exposure_point => 'Resetting exposure point';
	String get resetting_focus_point => 'Resetting focus point';
	late final TranslationsSearchEn search = TranslationsSearchEn._(_root);
	String get settings => 'Settings';
	String get skip => 'Skip';
	String get splash_text => 'Splash Screen';
	String get still => 'Still';
	String get subject => 'subject';
	String get subject_capitalized => 'Subject';
	String get template => 'template';
	String get template_capitalized => 'Template';
	String get terms_and_conditions => 'Terms & Conditions';
	String get test_page => 'Test Page';
	String get text => 'Text';
	String get topic => 'topic';
	String get topic_capitalized => 'Topic';
	late final TranslationsUnknownEn unknown = TranslationsUnknownEn._(_root);
	String get update_account => 'Update Account';
	String get zoom_in => 'Zoom In';
	String get zoom_out => 'Zoom out';
	String get zoom_to_user => 'Zoom in to user';
	Map<String, String> get locales => {
		'en': 'English',
		'en-US': 'English-US',
		'zh': '中文',
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

// Path: form
class TranslationsFormEn {
	TranslationsFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String authorized({required Object item}) => 'I declare that I am Authorized to create this ${item}';
	String validating({required Object field}) => 'Please wait for the ${field} validation to complete';
	String already_exists({required Object item, required Object field}) => 'A ${item} with this ${field} already exists';
	String create({required Object item}) => 'Create a new ${item}';
	String edit({required Object item}) => 'Edit ${item}';
	String get error_saving => 'Error saving';
	String join({required Object item}) => 'Join ${item}';
	String get code => 'Code';
	String code_validation({required Object item}) => 'Please enter ${item} code';
	String code_hint({required Object item}) => 'Enter ${item} code';
	String get name => 'Name';
	String name_validation({required Object item}) => 'Please enter ${item} name';
	String get name_hint => 'Enter name';
	String get given_name => 'Given Name';
	String given_name_validation({required Object item}) => 'Please enter ${item} given name';
	String get given_name_hint => 'Enter Given name';
	String get family_name => 'Family Name';
	String family_name_validation({required Object item}) => 'Please enter ${item} family name';
	String get family_name_hint => 'Enter Family name';
	String description({required Object item}) => 'Description of ${item}';
	String description_validation({required Object item}) => 'Please enter ${item} description';
	String get description_hint => 'Enter description';
	String email_administration({required Object item}) => '${item} Administrator\'s Email';
	String email_administration_hint({required Object item}) => 'Please enter the ${item} administrator\'s email';
	String get email => 'Email';
	String email_validation({required Object item}) => 'Please enter valid ${item} email';
	String get email_hint => 'Enter email';
	String get message => 'Message';
	String get message_capitalized => 'Message';
	String get message_validation => 'Please enter valid message';
	String get message_hint => 'Enter message';
	String get url => 'Web Address';
	String url_validation({required Object item}) => 'Please enter valid ${item} web address e.g. https://www.google.com';
	String url_hint({required Object item}) => 'Enter ${item} web address';
	String get username => 'username';
	String get username_capitalized => 'Username';
	String get username_validation => 'Please enter valid username';
	String get username_hint => 'Enter username';
	String get subject => 'Subject';
	String subject_validation({required Object item}) => 'Please enter valid ${item}, limit to 250 characters';
	String get subject_hint => 'Enter subject';
	String get template => 'Template';
	String template_validation({required Object item}) => 'Please enter valid ${item} code e.g. TPL_XYZ123';
	String template_hint({required Object item}) => 'Enter ${item} template code';
	String get topic => 'topic';
	String get topic_capitalized => 'Topic';
	String topic_validation({required Object item}) => 'Please enter valid ${item}';
	String topic_hint({required Object item}) => 'Enter ${item}';
	String org_type({required Object item}) => '${item} Type';
	String get saved => 'Saved';
	String deleted({required Object item}) => 'Deleted ${item}';
}

// Path: group_types
class TranslationsGroupTypesEn {
	TranslationsGroupTypesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get kDefault => 'Default';
	String get commercial => 'Commercial';
	String get government => 'Government';
	String get unknown => 'Unknown';
	String get private => 'Private';
	String get person => 'Person';
	String get org => 'Organization';
	String get group => 'Group';
	String get family => 'Family';
	String get friends => 'Friends';
	String get education => 'Education';
	String get team => 'Team';
	String get department => 'Department';
	String get company => 'Company';
}

// Path: invite
class TranslationsInviteEn {
	TranslationsInviteEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get organization => 'Organization';
	String get approve => 'Approve';
	String get reject => 'Reject';
	String get reject_sure => 'Are you sure?';
	String get reason => 'reason?';
	String get approved => 'Approved';
	String get invited_date_time => 'Invited';
	String get approved_date_time => 'Approved';
	String get invitee => 'Invitee';
	String get inviter => 'Inviter';
	String get approver => 'Approver';
}

// Path: resource
class TranslationsResourceEn {
	TranslationsResourceEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get artifact => 'Artifact';
	String get equipment => 'Equipment';
	String get group => 'Group';
	String get location => 'Location';
	String get organization => 'Organization';
	String get person => 'Person';
	String get registration => 'Registration';
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
	String get group => 'Groups';
	String get location => 'Locations';
	String get organization => 'Organizations';
	String get person => 'People';
	String get registration => 'Registrations';
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
	String get delete => 'Delete';
	String get delete_sure => 'Are you sure you want to delete this item?';
	String get edit => 'Edit';
	String get save => 'Save';
	String get send => 'Send';
	String get submit => 'Submit';
	String get update => 'Update';
	String get create => 'Create';
	String get join => 'Join';
	String get sure => 'Are you sure?';
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
	String get member_groups => 'Member Groups ..';
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
			case 'about': return ({required Object name}) => 'About ${name}';
			case 'about_us': return 'About Us';
			case 'about_dialog': return ({required Object title, required Object version, required Object deviceid, required Object project}) => '${title}\nVersion	${version}\nDevice	${deviceid}\n\n© ${project} 2024,2025 under license to Crowtech Pty Ltd';
			case 'accept_terms_switch': return 'I Accept the terms and conditions';
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
			case 'attributions': return 'Attributions';
			case 'billing': return 'Billing';
			case 'camera_1': return 'Camera 1';
			case 'camera_2': return 'Camera 2';
			case 'camera_title': return 'Camera';
			case 'camera_access_denied_without_prompt': return 'Please go to Settings app to enable camera access.';
			case 'camera_access_restricted': return 'Camera access is restricted';
			case 'camera_denied': return 'Camera access denied by user.';
			case 'camera_not_found': return 'No camera found.';
			case 'copied_to_clipboard': return ({required Object item}) => '${item} copied to clipboard';
			case 'created': return 'Created';
			case 'dark': return 'dark';
			case 'dashboard': return 'Dashboard';
			case 'deviceid': return 'DeviceID';
			case 'devpage': return 'Dev';
			case 'edit': return 'Edit';
			case 'email': return 'Email';
			case 'error': return 'Error';
			case 'exposure_mode': return 'Exposure Mode';
			case 'exposure_offset': return 'Exposure Offset';
			case 'favourite': return 'Favourite';
			case 'form.authorized': return ({required Object item}) => 'I declare that I am Authorized to create this ${item}';
			case 'form.validating': return ({required Object field}) => 'Please wait for the ${field} validation to complete';
			case 'form.already_exists': return ({required Object item, required Object field}) => 'A ${item} with this ${field} already exists';
			case 'form.create': return ({required Object item}) => 'Create a new ${item}';
			case 'form.edit': return ({required Object item}) => 'Edit ${item}';
			case 'form.error_saving': return 'Error saving';
			case 'form.join': return ({required Object item}) => 'Join ${item}';
			case 'form.code': return 'Code';
			case 'form.code_validation': return ({required Object item}) => 'Please enter ${item} code';
			case 'form.code_hint': return ({required Object item}) => 'Enter ${item} code';
			case 'form.name': return 'Name';
			case 'form.name_validation': return ({required Object item}) => 'Please enter ${item} name';
			case 'form.name_hint': return 'Enter name';
			case 'form.given_name': return 'Given Name';
			case 'form.given_name_validation': return ({required Object item}) => 'Please enter ${item} given name';
			case 'form.given_name_hint': return 'Enter Given name';
			case 'form.family_name': return 'Family Name';
			case 'form.family_name_validation': return ({required Object item}) => 'Please enter ${item} family name';
			case 'form.family_name_hint': return 'Enter Family name';
			case 'form.description': return ({required Object item}) => 'Description of ${item}';
			case 'form.description_validation': return ({required Object item}) => 'Please enter ${item} description';
			case 'form.description_hint': return 'Enter description';
			case 'form.email_administration': return ({required Object item}) => '${item} Administrator\'s Email';
			case 'form.email_administration_hint': return ({required Object item}) => 'Please enter the ${item} administrator\'s email';
			case 'form.email': return 'Email';
			case 'form.email_validation': return ({required Object item}) => 'Please enter valid ${item} email';
			case 'form.email_hint': return 'Enter email';
			case 'form.message': return 'Message';
			case 'form.message_capitalized': return 'Message';
			case 'form.message_validation': return 'Please enter valid message';
			case 'form.message_hint': return 'Enter message';
			case 'form.url': return 'Web Address';
			case 'form.url_validation': return ({required Object item}) => 'Please enter valid ${item} web address e.g. https://www.google.com';
			case 'form.url_hint': return ({required Object item}) => 'Enter ${item} web address';
			case 'form.username': return 'username';
			case 'form.username_capitalized': return 'Username';
			case 'form.username_validation': return 'Please enter valid username';
			case 'form.username_hint': return 'Enter username';
			case 'form.subject': return 'Subject';
			case 'form.subject_validation': return ({required Object item}) => 'Please enter valid ${item}, limit to 250 characters';
			case 'form.subject_hint': return 'Enter subject';
			case 'form.template': return 'Template';
			case 'form.template_validation': return ({required Object item}) => 'Please enter valid ${item} code e.g. TPL_XYZ123';
			case 'form.template_hint': return ({required Object item}) => 'Enter ${item} template code';
			case 'form.topic': return 'topic';
			case 'form.topic_capitalized': return 'Topic';
			case 'form.topic_validation': return ({required Object item}) => 'Please enter valid ${item}';
			case 'form.topic_hint': return ({required Object item}) => 'Enter ${item}';
			case 'form.org_type': return ({required Object item}) => '${item} Type';
			case 'form.saved': return 'Saved';
			case 'form.deleted': return ({required Object item}) => 'Deleted ${item}';
			case 'firstname': return 'Firstname';
			case 'focus_mode': return 'Focus Mode';
			case 'groups': return 'Groups';
			case 'group_types_title': return 'Group Types';
			case 'group_types.kDefault': return 'Default';
			case 'group_types.commercial': return 'Commercial';
			case 'group_types.government': return 'Government';
			case 'group_types.unknown': return 'Unknown';
			case 'group_types.private': return 'Private';
			case 'group_types.person': return 'Person';
			case 'group_types.org': return 'Organization';
			case 'group_types.group': return 'Group';
			case 'group_types.family': return 'Family';
			case 'group_types.friends': return 'Friends';
			case 'group_types.education': return 'Education';
			case 'group_types.team': return 'Team';
			case 'group_types.department': return 'Department';
			case 'group_types.company': return 'Company';
			case 'help': return 'Help';
			case 'highlight_title': return 'Generate Context-Aware Translations';
			case 'highlight_description': return 'Generate context-aware aware translatinons with GPT';
			case 'home': return 'Home';
			case 'image_uploaded_success': return 'Image uploaded successfully';
			case 'image_uploaded_failure': return 'Image failed to upload';
			case 'intro_title': return 'Welcome to Crowtech';
			case 'intro_description': return 'Advanced Design';
			case 'invite.organization': return 'Organization';
			case 'invite.approve': return 'Approve';
			case 'invite.reject': return 'Reject';
			case 'invite.reject_sure': return 'Are you sure?';
			case 'invite.reason': return 'reason?';
			case 'invite.approved': return 'Approved';
			case 'invite.invited_date_time': return 'Invited';
			case 'invite.approved_date_time': return 'Approved';
			case 'invite.invitee': return 'Invitee';
			case 'invite.inviter': return 'Inviter';
			case 'invite.approver': return 'Approver';
			case 'language': return 'Language';
			case 'lastname': return 'Lastname';
			case 'light': return 'light';
			case 'loading': return 'Loading...';
			case 'location_permission_denied': return 'Location permissions are denied';
			case 'location_services_disabled': return 'Location services are disabled. Please enable the services';
			case 'location_permission_permanent_denied': return 'Location permissions are permanently denied, we cannot request permissions.';
			case 'locked': return 'Locked';
			case 'login': return 'Login';
			case 'login_page': return 'Login Page';
			case 'logout': return 'Logout';
			case 'map': return 'Map';
			case 'members': return 'Members';
			case 'member': return 'Message';
			case 'messages': return 'Messages';
			case 'movement_status': return 'Is Moving?';
			case 'moving': return 'Moving';
			case 'name': return 'Name';
			case 'next': return 'Next';
			case 'none': return 'None';
			case 'odometer': return 'Odometer';
			case 'openstreetmap': return 'OpenStreetMap contributors';
			case 'optional': return 'Optional';
			case 'organization': return 'organization';
			case 'organization_capitalized': return 'Organization';
			case 'person': return 'person';
			case 'person_capitalized': return 'Person';
			case 'previous': return 'Previous';
			case 'privacy_policy': return 'Privacy Policy';
			case 'profile': return 'Profile';
			case 'pulltorefresh': return 'Pull to refresh';
			case 'registration': return 'registration';
			case 'registration_capitalized': return 'Registration';
			case 'resource.artifact': return 'Artifact';
			case 'resource.equipment': return 'Equipment';
			case 'resource.group': return 'Group';
			case 'resource.location': return 'Location';
			case 'resource.organization': return 'Organization';
			case 'resource.person': return 'Person';
			case 'resource.registration': return 'Registration';
			case 'resource.unknown': return 'Unknown';
			case 'resource.vehicle': return 'Vehicle';
			case 'resources.artifact': return 'Artifacts';
			case 'resources.equipment': return 'Equipment';
			case 'resources.group': return 'Groups';
			case 'resources.location': return 'Locations';
			case 'resources.organization': return 'Organizations';
			case 'resources.person': return 'People';
			case 'resources.registration': return 'Registrations';
			case 'resources.unknown': return 'Unknown';
			case 'resources.vehicle': return 'Vehicles';
			case 'response.ok': return 'OK';
			case 'response.cancel': return 'Cancel';
			case 'response.reset': return 'Reset';
			case 'response.delete': return 'Delete';
			case 'response.delete_sure': return 'Are you sure you want to delete this item?';
			case 'response.edit': return 'Edit';
			case 'response.save': return 'Save';
			case 'response.send': return 'Send';
			case 'response.submit': return 'Submit';
			case 'response.update': return 'Update';
			case 'response.create': return 'Create';
			case 'response.join': return 'Join';
			case 'response.sure': return 'Are you sure?';
			case 'saving': return 'Saving ...';
			case 'select.departments': return 'Select Departments ..';
			case 'select.drivers': return 'Select Drivers ..';
			case 'select.groups': return 'Select Groups ..';
			case 'select.items': return 'Select Items ..';
			case 'select.organizations': return 'Select Organizations ..';
			case 'select.equipment': return 'Select Equipment ..';
			case 'select.locations': return 'Select Locations ..';
			case 'select.members': return 'Select Members';
			case 'select.member_groups': return 'Member Groups ..';
			case 'select.people': return 'Select People ..';
			case 'select.resources': return 'Select Resources ..';
			case 'select.teams': return 'Select Teams ..';
			case 'select.vehicles': return 'Select Vehicles ..';
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
			case 'skip': return 'Skip';
			case 'splash_text': return 'Splash Screen';
			case 'still': return 'Still';
			case 'subject': return 'subject';
			case 'subject_capitalized': return 'Subject';
			case 'template': return 'template';
			case 'template_capitalized': return 'Template';
			case 'terms_and_conditions': return 'Terms & Conditions';
			case 'test_page': return 'Test Page';
			case 'text': return 'Text';
			case 'topic': return 'topic';
			case 'topic_capitalized': return 'Topic';
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
			case 'zoom_to_user': return 'Zoom in to user';
			case 'locales.en': return 'English';
			case 'locales.en-US': return 'English-US';
			case 'locales.zh': return '中文';
			default: return null;
		}
	}
}

