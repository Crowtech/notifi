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
	@override String get deviceid => '设备标识符';
	@override String get email => '电子邮件';
	@override String get firstname => '给定的名称';
	@override String get intro_title => '欢迎使用 Crowtech';
	@override String get intro_description => '出行即服务';
	@override String get movement_status => '是移動的嗎';
	@override String get highlight_title => '生成上下文感知的翻译';
	@override String get highlight_description => '使用 GPT 生成上下文感知的翻译';
	@override String get lastname => '姓';
	@override String get login => '登录';
	@override String get logout => '登出';
	@override String get moving => '动人';
	@override String get odometer => '里程表';
	@override String get still => '固定的';
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
			case 'deviceid': return '设备标识符';
			case 'email': return '电子邮件';
			case 'firstname': return '给定的名称';
			case 'intro_title': return '欢迎使用 Crowtech';
			case 'intro_description': return '出行即服务';
			case 'movement_status': return '是移動的嗎';
			case 'highlight_title': return '生成上下文感知的翻译';
			case 'highlight_description': return '使用 GPT 生成上下文感知的翻译';
			case 'lastname': return '姓';
			case 'login': return '登录';
			case 'logout': return '登出';
			case 'moving': return '动人';
			case 'odometer': return '里程表';
			case 'still': return '固定的';
			case 'home': return '家';
			case 'favourite': return '最喜欢的';
			case 'settings': return '设置';
			case 'locales.en': return '英文';
			case 'locales.zh': return '中文';
			default: return null;
		}
	}
}

