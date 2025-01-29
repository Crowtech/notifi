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
class TranslationsZh extends Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZh({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.zh,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsZh _root = this; // ignore: unused_field

	// Translations
	@override String get app_title => 'Crowtech';
	@override String get audio_access_denied => '您已拒绝音频访问';
	@override String get audio_access_denied_without_prompt => '请前往“设置”应用启用音频访问';
	@override String get audio_access_restricted => '音频访问受到限制';
	@override String get auto => '自动的';
	@override String get camera_title => '相机';
	@override String get camera_access_denied_without_prompt => '请前往“设置”应用启用相机访问权限';
	@override String get camera_access_restricted => '相机访问受到限制';
	@override String get camera_denied => '您已拒绝相机访问';
	@override String get camera_not_found => '未找到相机';
	@override String get deviceid => '设备标识符';
	@override String get email => '电子邮件';
	@override String get exposure_mode => '曝光模式';
	@override String get exposure_offset => '曝光偏移';
	@override String get firstname => '给定的名称';
	@override String get focus_mode => '专注模式';
	@override String get intro_title => '欢迎使用 Crowtech';
	@override String get intro_description => '出行即服务';
	@override String get locked => '已锁定';
	@override String get movement_status => '是移動的嗎';
	@override String get none => '没有任何';
	@override String get highlight_title => '生成上下文感知的翻译';
	@override String get highlight_description => '使用 GPT 生成上下文感知的翻译';
	@override String get lastname => '姓';
	@override String get login => '登录';
	@override String get logout => '登出';
	@override String get moving => '动人';
	@override String get odometer => '里程表';
	@override String get reset_offset => '重置偏移';
	@override String get resetting_exposure_point => '重置曝光点';
	@override String get resetting_focus_point => '重置焦点';
	@override String get still => '固定的';
	@override String get test_page => '测试页';
	@override String get home => '家';
	@override String get favourite => '最喜欢的';
	@override String get settings => '设置';
	@override Map<String, String> get locales => {
		'en': '英文',
		'zh': '中文',
	};
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsZh {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app_title': return 'Crowtech';
			case 'audio_access_denied': return '您已拒绝音频访问';
			case 'audio_access_denied_without_prompt': return '请前往“设置”应用启用音频访问';
			case 'audio_access_restricted': return '音频访问受到限制';
			case 'auto': return '自动的';
			case 'camera_title': return '相机';
			case 'camera_access_denied_without_prompt': return '请前往“设置”应用启用相机访问权限';
			case 'camera_access_restricted': return '相机访问受到限制';
			case 'camera_denied': return '您已拒绝相机访问';
			case 'camera_not_found': return '未找到相机';
			case 'deviceid': return '设备标识符';
			case 'email': return '电子邮件';
			case 'exposure_mode': return '曝光模式';
			case 'exposure_offset': return '曝光偏移';
			case 'firstname': return '给定的名称';
			case 'focus_mode': return '专注模式';
			case 'intro_title': return '欢迎使用 Crowtech';
			case 'intro_description': return '出行即服务';
			case 'locked': return '已锁定';
			case 'movement_status': return '是移動的嗎';
			case 'none': return '没有任何';
			case 'highlight_title': return '生成上下文感知的翻译';
			case 'highlight_description': return '使用 GPT 生成上下文感知的翻译';
			case 'lastname': return '姓';
			case 'login': return '登录';
			case 'logout': return '登出';
			case 'moving': return '动人';
			case 'odometer': return '里程表';
			case 'reset_offset': return '重置偏移';
			case 'resetting_exposure_point': return '重置曝光点';
			case 'resetting_focus_point': return '重置焦点';
			case 'still': return '固定的';
			case 'test_page': return '测试页';
			case 'home': return '家';
			case 'favourite': return '最喜欢的';
			case 'settings': return '设置';
			case 'locales.en': return '英文';
			case 'locales.zh': return '中文';
			default: return null;
		}
	}
}

