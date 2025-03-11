///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsZh implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZh({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.zh,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsZh _root = this; // ignore: unused_field

	// Translations
	@override String get app_title => 'Crowtech';
	@override late final _TranslationsMenuZh menu = _TranslationsMenuZh._(_root);
	@override String get about_us => '关于我们';
	@override late final _TranslationsAccountZh account = _TranslationsAccountZh._(_root);
	@override String get activity => '活动';
	@override String get audio_access_denied => '您已拒绝音频访问';
	@override String get audio_access_denied_without_prompt => '请前往“设置”应用启用音频访问';
	@override String get audio_access_restricted => '音频访问受到限制';
	@override String authored_by({required Object name}) => '作者 ${name}';
	@override String get auto => '自动的';
	@override String get billing => '计费';
	@override String get camera_title => '相机';
	@override String get camera_access_denied_without_prompt => '请前往“设置”应用启用相机访问权限';
	@override String get camera_access_restricted => '相机访问受到限制';
	@override String get camera_denied => '您已拒绝相机访问';
	@override String get camera_not_found => '未找到相机';
	@override String get dashboard => '仪表板';
	@override String get deviceid => '设备标识符';
	@override String get edit => '编辑';
	@override String get email => '电子邮件';
	@override String get exposure_mode => '曝光模式';
	@override String get exposure_offset => '曝光偏移';
	@override String get favourite => '最喜欢的';
	@override String get firstname => '给定的名称';
	@override String get focus_mode => '专注模式';
	@override String get groups => '群组';
	@override String get help => '帮助';
	@override String get home => '家';
	@override String get image_uploaded_success => '图片上传成功';
	@override String get image_uploaded_failure => '图片上传失败';
	@override String get intro_title => '欢迎使用 Crowtech';
	@override String get intro_description => '出行即服务';
	@override String get location_permission_denied => '位置权限被拒绝';
	@override String get location_services_disabled => '定位服务已禁用。请启用该服务';
	@override String get location_permission_permanent_denied => '位置权限被永久拒绝，我们无法请求权限。';
	@override String get locked => '已锁定';
	@override String get movement_status => '是移動的嗎';
	@override String get none => '没有任何';
	@override String get highlight_title => '生成上下文感知的翻译';
	@override String get highlight_description => '使用 GPT 生成上下文感知的翻译';
	@override String get lastname => '姓';
	@override String get login => '登录';
	@override String get login_page => '登录页面';
	@override String get logout => '登出';
	@override String get map => '地图';
	@override String get members => '成员';
	@override String get messages => '消息';
	@override String get moving => '动人';
	@override String get odometer => '里程表';
	@override late final _TranslationsResponseZh response = _TranslationsResponseZh._(_root);
	@override String get privacy_policy => '隐私政策';
	@override String get profile => '轮廓';
	@override String get pulltorefresh => '下拉刷新';
	@override String get reset_offset => '重置偏移';
	@override String get resetting_exposure_point => '重置曝光点';
	@override String get resetting_focus_point => '重置焦点';
	@override late final _TranslationsSearchZh search = _TranslationsSearchZh._(_root);
	@override String get settings => '设置';
	@override String get still => '固定的';
	@override String get terms_and_conditions => '条款和条件';
	@override String get test_page => '测试页';
	@override String get update_account => '更新账户';
	@override String get zoom_in => '放大';
	@override String get zoom_out => '缩小';
	@override Map<String, String> get locales => {
		'en': '英文',
		'zh': '中文',
	};
}

// Path: menu
class _TranslationsMenuZh implements TranslationsMenuEn {
	_TranslationsMenuZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get account => '帐户菜单';
	@override String get product => '产品菜单';
}

// Path: account
class _TranslationsAccountZh implements TranslationsAccountEn {
	_TranslationsAccountZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '帐户';
	@override String get change_password => '更改密码';
	@override String get email_taken => '电子邮件已被占用';
	@override String get firstname_characters_bad => '名字不得包含非字母字符';
	@override String get lastname_characters_bad => '姓氏只能包含字母字符、空格或破折号';
	@override String get avatar_url => '从图库中选择';
	@override String get organisation_name_taken => '组织已被占用';
	@override String get take_a_picture => '拍照';
	@override String get update => '更新用户帐户';
	@override String get update_failure => '更新失败';
	@override String get update_success => '更新成功';
	@override String get username_taken => '用户名已被使用。';
}

// Path: response
class _TranslationsResponseZh implements TranslationsResponseEn {
	_TranslationsResponseZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get ok => '好的';
	@override String get cancel => '取消';
	@override String get reset => '重置';
}

// Path: search
class _TranslationsSearchZh implements TranslationsSearchEn {
	_TranslationsSearchZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get equipment => '按名称或型号搜索...';
	@override String get organization => '按名称或网址搜索...';
	@override String get person => '按姓名或电子邮件搜索...';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsZh {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app_title': return 'Crowtech';
			case 'menu.account': return '帐户菜单';
			case 'menu.product': return '产品菜单';
			case 'about_us': return '关于我们';
			case 'account.title': return '帐户';
			case 'account.change_password': return '更改密码';
			case 'account.email_taken': return '电子邮件已被占用';
			case 'account.firstname_characters_bad': return '名字不得包含非字母字符';
			case 'account.lastname_characters_bad': return '姓氏只能包含字母字符、空格或破折号';
			case 'account.avatar_url': return '从图库中选择';
			case 'account.organisation_name_taken': return '组织已被占用';
			case 'account.take_a_picture': return '拍照';
			case 'account.update': return '更新用户帐户';
			case 'account.update_failure': return '更新失败';
			case 'account.update_success': return '更新成功';
			case 'account.username_taken': return '用户名已被使用。';
			case 'activity': return '活动';
			case 'audio_access_denied': return '您已拒绝音频访问';
			case 'audio_access_denied_without_prompt': return '请前往“设置”应用启用音频访问';
			case 'audio_access_restricted': return '音频访问受到限制';
			case 'authored_by': return ({required Object name}) => '作者 ${name}';
			case 'auto': return '自动的';
			case 'billing': return '计费';
			case 'camera_title': return '相机';
			case 'camera_access_denied_without_prompt': return '请前往“设置”应用启用相机访问权限';
			case 'camera_access_restricted': return '相机访问受到限制';
			case 'camera_denied': return '您已拒绝相机访问';
			case 'camera_not_found': return '未找到相机';
			case 'dashboard': return '仪表板';
			case 'deviceid': return '设备标识符';
			case 'edit': return '编辑';
			case 'email': return '电子邮件';
			case 'exposure_mode': return '曝光模式';
			case 'exposure_offset': return '曝光偏移';
			case 'favourite': return '最喜欢的';
			case 'firstname': return '给定的名称';
			case 'focus_mode': return '专注模式';
			case 'groups': return '群组';
			case 'help': return '帮助';
			case 'home': return '家';
			case 'image_uploaded_success': return '图片上传成功';
			case 'image_uploaded_failure': return '图片上传失败';
			case 'intro_title': return '欢迎使用 Crowtech';
			case 'intro_description': return '出行即服务';
			case 'location_permission_denied': return '位置权限被拒绝';
			case 'location_services_disabled': return '定位服务已禁用。请启用该服务';
			case 'location_permission_permanent_denied': return '位置权限被永久拒绝，我们无法请求权限。';
			case 'locked': return '已锁定';
			case 'movement_status': return '是移動的嗎';
			case 'none': return '没有任何';
			case 'highlight_title': return '生成上下文感知的翻译';
			case 'highlight_description': return '使用 GPT 生成上下文感知的翻译';
			case 'lastname': return '姓';
			case 'login': return '登录';
			case 'login_page': return '登录页面';
			case 'logout': return '登出';
			case 'map': return '地图';
			case 'members': return '成员';
			case 'messages': return '消息';
			case 'moving': return '动人';
			case 'odometer': return '里程表';
			case 'response.ok': return '好的';
			case 'response.cancel': return '取消';
			case 'response.reset': return '重置';
			case 'privacy_policy': return '隐私政策';
			case 'profile': return '轮廓';
			case 'pulltorefresh': return '下拉刷新';
			case 'reset_offset': return '重置偏移';
			case 'resetting_exposure_point': return '重置曝光点';
			case 'resetting_focus_point': return '重置焦点';
			case 'search.equipment': return '按名称或型号搜索...';
			case 'search.organization': return '按名称或网址搜索...';
			case 'search.person': return '按姓名或电子邮件搜索...';
			case 'settings': return '设置';
			case 'still': return '固定的';
			case 'terms_and_conditions': return '条款和条件';
			case 'test_page': return '测试页';
			case 'update_account': return '更新账户';
			case 'zoom_in': return '放大';
			case 'zoom_out': return '缩小';
			case 'locales.en': return '英文';
			case 'locales.zh': return '中文';
			default: return null;
		}
	}
}

