enum LanguageEnum {
  en(name: 'English', code: 'en'),
  zh(name: '简体中文', code: 'zh'),

  ;

  const LanguageEnum({required this.name, required this.code});

  final String name;
  final String code;
}