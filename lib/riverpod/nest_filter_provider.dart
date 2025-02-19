import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/models/nestfilter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nest_filter_provider.g.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

@riverpod
class NestFilterProvider extends _$NestFilterProvider {
  @override
  NestFilter build() {
    // final SharedPreferences sharedPreferences = ref.read(sharedPreferencesProvider);
    // final String? json = sharedPreferences.getString("userSettings");
    // if (json != null) {
    //   return Settings.fromJson(jsonDecode(json));
    // }
    return defaultNestFilter;
  }

  void updateQuery(String query) {
    state = state.copyWith(query: query);
    print('query name => [${state.query}]');
  }

 void updateQuery2(NestFilter nf) {
  
      state = state.copyWith(query: nf.query);

  }

  // void save() {
  //   final SharedPreferences sharedPreferences = ref.read(sharedPreferencesProvider);
  //   sharedPreferences.setString("userSettings", jsonEncode(state.toJson()));
  // }
}


  final nestFilterProvider = StateProvider<NestFilter>((ref)=>defaultNestFilter);

// final nestFilterProvider = Provider<List<Product>>((ref) {
//   return _products;
// });

// final nestFilterProvider = StateProvider<NestFilter>(
//   // We return the default sort type, here name.
//   (ref) => ProductSortType.name,
// );

// final nestFilterProvider =
//     StateProvider<NestFilter>((ref) => defaultNestFilter);

// final nestFilterProvider =
//      StateNotifierProvider<NestFilterProvider, NestFilter>(
//     (ref) => NestFilterProvider());
