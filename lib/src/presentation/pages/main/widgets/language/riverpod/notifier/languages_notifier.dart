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
    // Aquí no necesitamos verificar si el idioma está en LocalStorage,
    // ya que solo soportamos inglés, puedes configurar eso de forma predeterminada.
    state = state.copyWith(isSelectLanguage: false, isLoading: false);
    // Establecemos el idioma por defecto a inglés
    final language = LanguageData(
      id: 1, // Asegúrate de usar un id válido para el inglés
      title: 'English',
      locale: 'en',
      backward: false,
      isDefault: true,
      active: true,
      img: 'path_to_english_flag', // O la imagen que prefieras
    );
    LocalStorage.setSystemLanguage(language);
  }

  Future<void> getLanguages(BuildContext context) async {
    // Como no necesitamos verificar la conectividad para obtener idiomas,
    // podemos omitir la lógica relacionada con la conexión y solo hacer la asignación.
    state = state.copyWith(isLoading: true, isSelectLanguage: false);
    
    // Configuramos el idioma por defecto (inglés)
    final language = LanguageData(
      id: 1, // Asegúrate de usar un id válido para el inglés
      title: 'English',
      locale: 'en',
      backward: false,
      isDefault: true,
      active: true,
      img: 'path_to_english_flag', // O la imagen que prefieras
    );

    // Actualizamos el estado con el idioma en inglés y eliminamos la lista de idiomas.
    state = state.copyWith(
      isLoading: false,
      languages: [language], // Solo agregamos inglés a la lista
      index: 0, // Asignamos el índice 0, ya que solo hay un idioma
    );
  }

  Future<void> change(int index, {VoidCallback? afterUpdate}) async {
    // Asumimos que siempre se selecciona el idioma en inglés, por lo que no necesitamos cambiarlo
    state = state.copyWith(index: index);
    await LocalStorage.setLanguageData(state.languages[index]);
    await LocalStorage.setLangLtr(state.languages[index].backward);
    final map = await LocalStorage.getOtherTranslations(
        key: state.languages[index].id.toString());
    await LocalStorage.setTranslations(map);
    afterUpdate?.call();
  }
}
