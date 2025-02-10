import 'package:kiosk/src/models/data/help_data.dart';

import '../core/handlers/handlers.dart';
import '../models/models.dart';

abstract class SettingsFacade {
  Future<ApiResult<GlobalSettingsResponse>> getGlobalSettings();

  Future<ApiResult<TranslationsResponse>> getTranslations();

   Future<ApiResult<LanguagesResponse>> getLanguages();

  Future<ApiResult<MobileTranslationsResponse>> getMobileTranslations({String? lang});

  Future<ApiResult<HelpModel>> getFaq();

  Future<ApiResult<CurrenciesResponse>> getCurrencies();

}
