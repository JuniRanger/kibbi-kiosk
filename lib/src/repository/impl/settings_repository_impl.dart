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
    final data = {'lang': lang ?? LocalStorage.getLanguage()?.locale ?? 'en'};
    try {
      final dioHttp = HttpService();
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/translations/paginate',
        queryParameters: data,
      );
      await LocalStorage.setTranslations(
          MobileTranslationsResponse.fromJson(response.data).data);
      return  ApiResult.success(data: MobileTranslationsResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get translations failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<TranslationsResponse>> getTranslations() async {
    final data = {
      'lang': LocalStorage.getLanguage()?.locale ?? 'en'
    };
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
    try {
      final dioHttp = HttpService();
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get('/api/v1/rest/languages/active');
      if (LocalStorage.getLanguage() == null ||
          !(LanguagesResponse.fromJson(response.data)
              .data
              ?.map((e) => e.id)
              .contains(LocalStorage.getLanguage()?.id) ??
              true)) {
        LanguagesResponse.fromJson(response.data).data?.forEach((element) {
          if (element.isDefault ?? false) {
            LocalStorage.setLanguageData(element);
            LocalStorage.setLangLtr(element.backward);
          }
        });
      }
      return ApiResult.success(
        data: LanguagesResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get languages failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<HelpModel>> getFaq() async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get('/api/v1/rest/faqs/paginate',queryParameters: {
        'lang':LocalStorage.getLanguage()?.locale
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
