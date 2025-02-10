import 'package:kiosk/src/core/constants/constants.dart';
import 'package:kiosk/src/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../../core/utils/utils.dart';
import 'package:kiosk/src/models/models.dart';
import '../state/languages_state.dart';

class LanguagesNotifier extends StateNotifier<LanguagesState> {
  final SettingsFacade _settingsRepository;

  LanguagesNotifier(this._settingsRepository) : super(const LanguagesState());

  Future<void> checkLanguage() async {
    if (LocalStorage.getLanguage()?.locale != null) {
      state = state.copyWith(isSelectLanguage: false, isLoading: false);
    } else {
      final response = await _settingsRepository.getLanguages();
      response.when(
        success: (data) {
          final List<LanguageData> languages = data.data ?? [];
          for (final language in languages) {
            if (language.isDefault ?? false) {
              LocalStorage.setSystemLanguage(language);
            }
          }
          state = state.copyWith(
            languages: languages,
            isSelectLanguage: true,
            isLoading: false,
          );
        },
        failure: (failure,status)  {
          state = state.copyWith(isSelectLanguage: false, isLoading: false);
        },
      );
    }
  }

  Future<void> getLanguages(BuildContext context) async {
    final connect = await AppConnectivity.connectivity();
    if (connect) {
      state = state.copyWith(isLoading: true, isSelectLanguage: false);
      final response = await _settingsRepository.getLanguages();
      response.when(
        success: (data) {
          final List<LanguageData> languages = data.data ?? [];
          final lang = LocalStorage.getLanguage();

          int index = 0;
          for (int i = 0; i < languages.length; i++) {
            if (languages[i].id == lang?.id) {
              index = i;
              break;
            }
          }
          state = state.copyWith(
            isLoading: false,
            languages: data.data?.reversed.toList() ?? [],
            index: index,
          );
        },
        failure: (failure,status)  {
          state = state.copyWith(isLoading: false);
          AppHelpers.showSnackBar(
            context,
             failure.toString(),
          );
        },
      );
    } else {
      if (!context.mounted) return;
      AppHelpers.showSnackBar(context, AppHelpers.getTranslation(TrKeys.successfullyEdited));
    }
  }

  Future<void> change(int index, {VoidCallback? afterUpdate}) async {
    state = state.copyWith(index: index);
    await LocalStorage.setLanguageData(state.languages[index]);
    await LocalStorage.setLangLtr(state.languages[index].backward);
    final map = await LocalStorage.getOtherTranslations(
        key: state.languages[index].id.toString());
    await LocalStorage.setTranslations(map);
    afterUpdate?.call();
  }
}
