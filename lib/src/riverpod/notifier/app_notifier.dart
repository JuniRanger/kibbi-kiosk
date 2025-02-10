import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/utils.dart';
import 'package:kiosk/src/models/models.dart';
import '../state/app_state.dart';

class AppNotifier extends StateNotifier<AppState> {
  AppNotifier() : super(const AppState()) {
    fetchLocale();
  }

  Future<void> fetchLocale() async {
    final lang = LocalStorage.getLanguage()?.locale ?? 'en';
    state = state.copyWith(lang: lang.isEmpty ? 'en' : lang);
  }

  Future<void> changeLocale(LanguageData? language) async {
    await LocalStorage.setActiveLocale(language?.locale);
    state = state.copyWith(lang: language?.locale ?? 'en');
  }
}
