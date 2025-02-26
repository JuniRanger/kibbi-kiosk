import 'package:kiosk/src/core/di/dependency_manager.dart';
import 'package:kiosk/src/core/utils/app_helpers.dart';
import 'package:flutter/material.dart';

import 'package:kiosk/src/core/handlers/handlers.dart';
import 'package:kiosk/src/models/models.dart';
import '../repository.dart';

class AuthRepository extends AuthFacade {
  @override
Future<ApiResult<LoginResponse>> login({
  required String serial,
  required String password,
}) async {
  try {
    final client = dioHttp.client(requireAuth: false);

    // Imprimir los datos que vas a enviar
    debugPrint('==> Enviando petición de login:');
    debugPrint('URL: /api/kiosks/login/kiosk');
    debugPrint('Body: { "serial": "$serial", "password": "$password" }');
    debugPrint('Headers: { "Accept": "application/json", "Content-Type": "application/json" }');

    final response = await client.post(
      '/api/kiosks/login/kiosk',
      data: {
        'serial': serial,
        'password': password,
      },
    );

    return ApiResult.success(
      data: LoginResponse.fromJson(response.data),
    );
  } catch (e) {
    debugPrint('==> login failure: $e');
    return ApiResult.failure(error: AppHelpers.errorHandler(e));
  }
}
}




  // @override
  // Future<ApiResult<void>> updateJwtToken(String? token) async {
  //   final data = {if (token != null) 'jwt_token': token};
  //   try {
  //     final client = dioHttp.client(requireAuth: true);
  //     await client.post(
  //       '/api/v1/dashboard/user/profile/firebase/token/update',
  //       data: data,
  //     );
  //     return const ApiResult.success(data: null);
  //   } catch (e) {
  //     debugPrint('==> update firebase token failure: $e');
  //     return ApiResult.failure(
  //       error: AppHelpers.errorHandler(e),
  //     );
  //   }
  // }