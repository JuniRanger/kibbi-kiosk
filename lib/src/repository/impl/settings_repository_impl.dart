import 'package:kiosk/src/core/di/dependency_manager.dart';
import 'package:kiosk/src/models/data/help_data.dart';
import 'package:flutter/material.dart';
import 'package:kiosk/src/core/handlers/handlers.dart';
import '../../core/utils/utils.dart';
import 'package:kiosk/src/models/models.dart';
import '../repository.dart';

class SettingsRepository extends SettingsFacade {
  @override
  Future<ApiResult<GlobalSettingsResponse>> getGlobalSettings() async {
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get('/api/v1/rest/settings');
      debugPrint('==> get global settings response: $response');
      await LocalStorage.setSettingsList(GlobalSettingsResponse.fromJson(response.data).data ?? []);
      return ApiResult.success(
        data: GlobalSettingsResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get settings failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<MobileTranslationsResponse>> getMobileTranslations(
      {String? lang}) async {
    // Usamos siempre inglés para las traducciones
    final data = {'lang': 'en'};
    try {
      final dioHttp = HttpService();
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/translations/paginate',
        queryParameters: data,
      );
      await LocalStorage.setTranslations(
          MobileTranslationsResponse.fromJson(response.data).data);
      return ApiResult.success(data: MobileTranslationsResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get translations failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<TranslationsResponse>> getTranslations() async {
    // Usamos siempre inglés para las traducciones
    final data = {'lang': 'en'};
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/translations/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: TranslationsResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get translations failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<LanguagesResponse>> getLanguages() async {
    // Como solo usamos inglés, no necesitamos obtener los idiomas
    final language = LanguageData(
      id: 1, // Usamos el id correspondiente al inglés
      title: 'English',
      locale: 'en',
      backward: false,
      isDefault: true,
      active: true,
      img: 'path_to_english_flag', // Ruta de la imagen de la bandera
    );
    LocalStorage.setLanguageData(language);
    LocalStorage.setLangLtr(language.backward);
    
    // Retornamos un ApiResult con el idioma predeterminado
    return ApiResult.success(
      data: LanguagesResponse(data: [language]),
    );
  }

  @override
  Future<ApiResult<HelpModel>> getFaq() async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get('/api/v1/rest/faqs/paginate', queryParameters: {
        'lang': 'en' // Usamos siempre inglés
      });
      return ApiResult.success(
        data: HelpModel.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get faq failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<CurrenciesResponse>> getCurrencies() async {
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get('/api/v1/rest/currencies');
      int defaultCurrencyIndex = 0;
      final List<CurrencyData> currencies =
          CurrenciesResponse.fromJson(response.data).data ?? [];
      for (int i = 0; i < currencies.length; i++) {
        if (currencies[i].isDefault ?? false) {
          defaultCurrencyIndex = i;
          break;
        }
      }
      LocalStorage.setSelectedCurrency(currencies[defaultCurrencyIndex]);
      return ApiResult.success(
          data: CurrenciesResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get currencies failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }
}
