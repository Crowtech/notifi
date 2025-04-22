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
	TranslationsZh({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
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

	@override 
	TranslationsZh $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsZh(meta: meta ?? this.$meta);

	// Translations
	@override String get app_title => 'Crowtech';
	@override String get notfound_404 => '404-页面未找到！';
	@override late final _TranslationsMenuZh menu = _TranslationsMenuZh._(_root);
	@override String get about_us => '关于我们';
	@override String get accept_terms_switch => '我接受条款和条件';
	@override late final _TranslationsAccountZh account = _TranslationsAccountZh._(_root);
	@override String get activity => '活动';
	@override String get audio_access_denied => '您已拒绝音频访问';
	@override String get audio_access_denied_without_prompt => '请前往“设置”应用启用音频访问';
	@override String get audio_access_restricted => '音频访问受到限制';
	@override String authored_by({required Object name}) => '作者 ${name}';
	@override String get auto => '自动的';
	@override String get billing => '计费';
	@override String get camera_1 => '相机 1';
	@override String get camera_2 => '相机 2';
	@override String get camera_title => '相机';
	@override String get camera_access_denied_without_prompt => '请前往“设置”应用启用相机访问权限';
	@override String get camera_access_restricted => '相机访问受到限制';
	@override String get camera_denied => '您已拒绝相机访问';
	@override String get camera_not_found => '未找到相机';
	@override String copied_to_clipboard({required Object item}) => '${item} 已复制到剪贴板';
	@override String get created => '创建时间';
	@override String get dark => '黑暗的';
	@override String get dashboard => '仪表板';
	@override String get deviceid => '设备标识符';
	@override String get devpage => '开发者页面';
	@override String get edit => '编辑';
	@override String get email => '电子邮件';
	@override String get exposure_mode => '曝光模式';
	@override String get exposure_offset => '曝光偏移';
	@override String get favourite => '最喜欢的';
	@override String get firstname => '给定的名称';
	@override String get focus_mode => '专注模式';
	@override late final _TranslationsFormZh form = _TranslationsFormZh._(_root);
	@override String get groups => '群组';
	@override String get group_types_title => '群组类型';
	@override late final _TranslationsGroupTypesZh group_types = _TranslationsGroupTypesZh._(_root);
	@override String get help => '帮助';
	@override String get highlight_title => '生成上下文感知的翻译';
	@override String get highlight_description => '使用 GPT 生成上下文感知的翻译';
	@override String get home => '家';
	@override String get image_uploaded_success => '图片上传成功';
	@override String get image_uploaded_failure => '图片上传失败';
	@override String get intro_title => '欢迎使用 Crowtech';
	@override String get intro_description => '出行即服务';
	@override String get location_permission_denied => '位置权限被拒绝';
	@override String get location_services_disabled => '定位服务已禁用。请启用该服务';
	@override String get location_permission_permanent_denied => '位置权限被永久拒绝，我们无法请求权限。';
	@override String get locked => '已锁定';
	@override String get language => '语言';
	@override String get lastname => '姓';
	@override String get light => '光';
	@override String get login => '登录';
	@override String get login_page => '登录页面';
	@override String get logout => '登出';
	@override String get map => '地图';
	@override String get members => '成员';
	@override String get messages => '消息';
	@override String get moving => '动人';
	@override String get movement_status => '是移動的嗎';
	@override String get name => '姓名';
	@override String get next => '下一个';
	@override String get none => '没有任何';
	@override String get odometer => '里程表';
	@override String get openstreetmap => 'OpenStreetMap 贡献者';
	@override String get optional => '选修的';
	@override String get organization => '组织';
	@override String get organization_capitalized => '组织';
	@override String get person => '人';
	@override String get person_capitalized => '人';
	@override String get privacy_policy => '隐私政策';
	@override String get profile => '轮廓';
	@override String get pulltorefresh => '下拉刷新';
	@override String get reset_offset => '重置偏移';
	@override String get resetting_exposure_point => '重置曝光点';
	@override String get resetting_focus_point => '重置焦点';
	@override late final _TranslationsResourceZh resource = _TranslationsResourceZh._(_root);
	@override late final _TranslationsResourcesZh resources = _TranslationsResourcesZh._(_root);
	@override late final _TranslationsResponseZh response = _TranslationsResponseZh._(_root);
	@override String get saving => '正在保存';
	@override late final _TranslationsSelectZh select = _TranslationsSelectZh._(_root);
	@override late final _TranslationsSearchZh search = _TranslationsSearchZh._(_root);
	@override String get settings => '设置';
	@override String get skip => '跳过';
	@override String get splash_text => '启动画面';
	@override String get still => '固定的';
	@override String get terms_and_conditions => '条款和条件';
	@override String get test_page => '测试页';
	@override String get text => '文本';
	@override late final _TranslationsUnknownZh unknown = _TranslationsUnknownZh._(_root);
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

// Path: form
class _TranslationsFormZh implements TranslationsFormEn {
	_TranslationsFormZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String validating({required Object item}) => '请等待${item}验证完成';
	@override String already_exists({required Object field, required Object item}) => '具有此${field}的${item}已存在';
	@override String create({required Object item}) => '创建${item}';
	@override String edit({required Object item}) => '编辑${item}';
	@override String get error_saving => '保存错误';
	@override String join({required Object item}) => '加入${item}';
	@override String get name => '姓名';
	@override String name_validation({required Object item}) => '请输入${item}名称';
	@override String get name_hint => '输入姓名';
	@override String get given_name => '给定的名称';
	@override String given_name_validation({required Object item}) => '请输入${item}的名字';
	@override String get given_name_hint => '输入名字';
	@override String get family_name => '姓';
	@override String family_name_validation({required Object item}) => '请输入${item}姓氏';
	@override String get family_name_hint => '输入姓氏';
	@override String description({required Object item}) => '${item} 的描述';
	@override String description_validation({required Object item}) => '请输入${item}描述';
	@override String get description_hint => '输入描述';
	@override String get email => '电子邮件';
	@override String email_validation({required Object item}) => '请输入有效的${item}邮箱地址';
	@override String get email_hint => '输入邮箱';
	@override String get url => '网址';
	@override String url_validation({required Object item}) => '请输入有效的${item}网址，例如https://www.google.com';
	@override String get url_hint => '输入网站地址';
	@override String org_type({required Object item}) => '${item} 类型';
	@override String get saved => '已保存';
	@override String deleted({required Object item}) => '已删除${item}';
}

// Path: group_types
class _TranslationsGroupTypesZh implements TranslationsGroupTypesEn {
	_TranslationsGroupTypesZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get kDefault => '默认';
	@override String get commercial => '商业的';
	@override String get government => '政府';
	@override String get unknown => '未知';
	@override String get private => '私人的';
	@override String get person => '人';
	@override String get org => '组织';
	@override String get group => '团体';
	@override String get family => '家庭';
	@override String get friends => '朋友们';
	@override String get education => '教育';
	@override String get team => '团队';
	@override String get department => '部门';
	@override String get company => '公司';
}

// Path: resource
class _TranslationsResourceZh implements TranslationsResourceEn {
	_TranslationsResourceZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get artifact => '人工制品';
	@override String get equipment => '设备';
	@override String get location => '地点';
	@override String get organization => '组织';
	@override String get person => '人';
	@override String get unknown => '未知';
	@override String get vehicle => '车辆';
}

// Path: resources
class _TranslationsResourcesZh implements TranslationsResourcesEn {
	_TranslationsResourcesZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get artifact => '工件';
	@override String get equipment => '设备';
	@override String get location => '位置';
	@override String get organization => '组织';
	@override String get person => '人们';
	@override String get unknown => '未知';
	@override String get vehicle => '车辆';
}

// Path: response
class _TranslationsResponseZh implements TranslationsResponseEn {
	_TranslationsResponseZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get ok => '好的';
	@override String get cancel => '取消';
	@override String get reset => '重置';
	@override String get delete => '删除';
	@override String get delete_sure => '您确实要删除此项吗';
	@override String get save => 'S节省';
	@override String get submit => '提交';
	@override String get edit => '编辑';
	@override String get update => '更新';
	@override String get create => '创造';
	@override String get join => '加入';
}

// Path: select
class _TranslationsSelectZh implements TranslationsSelectEn {
	_TranslationsSelectZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get departments => '选择部门 ..';
	@override String get drivers => '选择驱动程序 ..';
	@override String get groups => '选择组 ..';
	@override String get items => '选择项目 ..';
	@override String get organizations => '选择组织 ..';
	@override String get equipment => '选择设备 ..';
	@override String get locations => '选择位置 ..';
	@override String get member_groups => '会员团体 ..';
	@override String get members => '选择成员 ..';
	@override String get people => '选择人员 ..';
	@override String get resources => '选择资源 ..';
	@override String get teams => '选择团队s ..';
	@override String get vehicles => '选择车辆 ..';
}

// Path: search
class _TranslationsSearchZh implements TranslationsSearchEn {
	_TranslationsSearchZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get artifact => '按名称搜索...';
	@override String get equipment => '按名称或型号搜索...';
	@override String get location => '按地点名称搜索...';
	@override String get organization => '按名称或网址搜索...';
	@override String get person => '按姓名或电子邮件搜索...';
	@override String get unknown => '按名称搜索...';
	@override String get vehicle => '按车辆名称或代码搜索...';
}

// Path: unknown
class _TranslationsUnknownZh implements TranslationsUnknownEn {
	_TranslationsUnknownZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get person => '匿名用户';
	@override String get organization => '匿名组织';
	@override String get group => '未命名的组';
	@override String get equipment => '未命名的设备';
	@override String get artifact => '未命名文物';
	@override String get location => '未命名的地点';
	@override String get resource => '未命名资源';
	@override String get unknown => '未知';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsZh {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app_title': return 'Crowtech';
			case 'notfound_404': return '404-页面未找到！';
			case 'menu.account': return '帐户菜单';
			case 'menu.product': return '产品菜单';
			case 'about_us': return '关于我们';
			case 'accept_terms_switch': return '我接受条款和条件';
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
			case 'camera_1': return '相机 1';
			case 'camera_2': return '相机 2';
			case 'camera_title': return '相机';
			case 'camera_access_denied_without_prompt': return '请前往“设置”应用启用相机访问权限';
			case 'camera_access_restricted': return '相机访问受到限制';
			case 'camera_denied': return '您已拒绝相机访问';
			case 'camera_not_found': return '未找到相机';
			case 'copied_to_clipboard': return ({required Object item}) => '${item} 已复制到剪贴板';
			case 'created': return '创建时间';
			case 'dark': return '黑暗的';
			case 'dashboard': return '仪表板';
			case 'deviceid': return '设备标识符';
			case 'devpage': return '开发者页面';
			case 'edit': return '编辑';
			case 'email': return '电子邮件';
			case 'exposure_mode': return '曝光模式';
			case 'exposure_offset': return '曝光偏移';
			case 'favourite': return '最喜欢的';
			case 'firstname': return '给定的名称';
			case 'focus_mode': return '专注模式';
			case 'form.validating': return ({required Object item}) => '请等待${item}验证完成';
			case 'form.already_exists': return ({required Object field, required Object item}) => '具有此${field}的${item}已存在';
			case 'form.create': return ({required Object item}) => '创建${item}';
			case 'form.edit': return ({required Object item}) => '编辑${item}';
			case 'form.error_saving': return '保存错误';
			case 'form.join': return ({required Object item}) => '加入${item}';
			case 'form.name': return '姓名';
			case 'form.name_validation': return ({required Object item}) => '请输入${item}名称';
			case 'form.name_hint': return '输入姓名';
			case 'form.given_name': return '给定的名称';
			case 'form.given_name_validation': return ({required Object item}) => '请输入${item}的名字';
			case 'form.given_name_hint': return '输入名字';
			case 'form.family_name': return '姓';
			case 'form.family_name_validation': return ({required Object item}) => '请输入${item}姓氏';
			case 'form.family_name_hint': return '输入姓氏';
			case 'form.description': return ({required Object item}) => '${item} 的描述';
			case 'form.description_validation': return ({required Object item}) => '请输入${item}描述';
			case 'form.description_hint': return '输入描述';
			case 'form.email': return '电子邮件';
			case 'form.email_validation': return ({required Object item}) => '请输入有效的${item}邮箱地址';
			case 'form.email_hint': return '输入邮箱';
			case 'form.url': return '网址';
			case 'form.url_validation': return ({required Object item}) => '请输入有效的${item}网址，例如https://www.google.com';
			case 'form.url_hint': return '输入网站地址';
			case 'form.org_type': return ({required Object item}) => '${item} 类型';
			case 'form.saved': return '已保存';
			case 'form.deleted': return ({required Object item}) => '已删除${item}';
			case 'groups': return '群组';
			case 'group_types_title': return '群组类型';
			case 'group_types.kDefault': return '默认';
			case 'group_types.commercial': return '商业的';
			case 'group_types.government': return '政府';
			case 'group_types.unknown': return '未知';
			case 'group_types.private': return '私人的';
			case 'group_types.person': return '人';
			case 'group_types.org': return '组织';
			case 'group_types.group': return '团体';
			case 'group_types.family': return '家庭';
			case 'group_types.friends': return '朋友们';
			case 'group_types.education': return '教育';
			case 'group_types.team': return '团队';
			case 'group_types.department': return '部门';
			case 'group_types.company': return '公司';
			case 'help': return '帮助';
			case 'highlight_title': return '生成上下文感知的翻译';
			case 'highlight_description': return '使用 GPT 生成上下文感知的翻译';
			case 'home': return '家';
			case 'image_uploaded_success': return '图片上传成功';
			case 'image_uploaded_failure': return '图片上传失败';
			case 'intro_title': return '欢迎使用 Crowtech';
			case 'intro_description': return '出行即服务';
			case 'location_permission_denied': return '位置权限被拒绝';
			case 'location_services_disabled': return '定位服务已禁用。请启用该服务';
			case 'location_permission_permanent_denied': return '位置权限被永久拒绝，我们无法请求权限。';
			case 'locked': return '已锁定';
			case 'language': return '语言';
			case 'lastname': return '姓';
			case 'light': return '光';
			case 'login': return '登录';
			case 'login_page': return '登录页面';
			case 'logout': return '登出';
			case 'map': return '地图';
			case 'members': return '成员';
			case 'messages': return '消息';
			case 'moving': return '动人';
			case 'movement_status': return '是移動的嗎';
			case 'name': return '姓名';
			case 'next': return '下一个';
			case 'none': return '没有任何';
			case 'odometer': return '里程表';
			case 'openstreetmap': return 'OpenStreetMap 贡献者';
			case 'optional': return '选修的';
			case 'organization': return '组织';
			case 'organization_capitalized': return '组织';
			case 'person': return '人';
			case 'person_capitalized': return '人';
			case 'privacy_policy': return '隐私政策';
			case 'profile': return '轮廓';
			case 'pulltorefresh': return '下拉刷新';
			case 'reset_offset': return '重置偏移';
			case 'resetting_exposure_point': return '重置曝光点';
			case 'resetting_focus_point': return '重置焦点';
			case 'resource.artifact': return '人工制品';
			case 'resource.equipment': return '设备';
			case 'resource.location': return '地点';
			case 'resource.organization': return '组织';
			case 'resource.person': return '人';
			case 'resource.unknown': return '未知';
			case 'resource.vehicle': return '车辆';
			case 'resources.artifact': return '工件';
			case 'resources.equipment': return '设备';
			case 'resources.location': return '位置';
			case 'resources.organization': return '组织';
			case 'resources.person': return '人们';
			case 'resources.unknown': return '未知';
			case 'resources.vehicle': return '车辆';
			case 'response.ok': return '好的';
			case 'response.cancel': return '取消';
			case 'response.reset': return '重置';
			case 'response.delete': return '删除';
			case 'response.delete_sure': return '您确实要删除此项吗';
			case 'response.save': return 'S节省';
			case 'response.submit': return '提交';
			case 'response.edit': return '编辑';
			case 'response.update': return '更新';
			case 'response.create': return '创造';
			case 'response.join': return '加入';
			case 'saving': return '正在保存';
			case 'select.departments': return '选择部门 ..';
			case 'select.drivers': return '选择驱动程序 ..';
			case 'select.groups': return '选择组 ..';
			case 'select.items': return '选择项目 ..';
			case 'select.organizations': return '选择组织 ..';
			case 'select.equipment': return '选择设备 ..';
			case 'select.locations': return '选择位置 ..';
			case 'select.member_groups': return '会员团体 ..';
			case 'select.members': return '选择成员 ..';
			case 'select.people': return '选择人员 ..';
			case 'select.resources': return '选择资源 ..';
			case 'select.teams': return '选择团队s ..';
			case 'select.vehicles': return '选择车辆 ..';
			case 'search.artifact': return '按名称搜索...';
			case 'search.equipment': return '按名称或型号搜索...';
			case 'search.location': return '按地点名称搜索...';
			case 'search.organization': return '按名称或网址搜索...';
			case 'search.person': return '按姓名或电子邮件搜索...';
			case 'search.unknown': return '按名称搜索...';
			case 'search.vehicle': return '按车辆名称或代码搜索...';
			case 'settings': return '设置';
			case 'skip': return '跳过';
			case 'splash_text': return '启动画面';
			case 'still': return '固定的';
			case 'terms_and_conditions': return '条款和条件';
			case 'test_page': return '测试页';
			case 'text': return '文本';
			case 'unknown.person': return '匿名用户';
			case 'unknown.organization': return '匿名组织';
			case 'unknown.group': return '未命名的组';
			case 'unknown.equipment': return '未命名的设备';
			case 'unknown.artifact': return '未命名文物';
			case 'unknown.location': return '未命名的地点';
			case 'unknown.resource': return '未命名资源';
			case 'unknown.unknown': return '未知';
			case 'update_account': return '更新账户';
			case 'zoom_in': return '放大';
			case 'zoom_out': return '缩小';
			case 'locales.en': return '英文';
			case 'locales.zh': return '中文';
			default: return null;
		}
	}
}

