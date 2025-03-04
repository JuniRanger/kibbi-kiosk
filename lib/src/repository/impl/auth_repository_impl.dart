import 'package:kiosk/src/core/di/dependency_manager.dart';
import 'package:kiosk/src/core/utils/app_helpers.dart';
import 'package:flutter/material.dart';

import 'package:kiosk/src/core/handlers/handlers.dart';
import 'package:kiosk/src/models/models.dart';
import '../repository.dart';
import '../../core/utils/local_storage.dart';
import '../impl/restaurant_repository_impl.dart';

class AuthRepository extends AuthFacade {
  @override
  Future<ApiResult<LoginResponse>> login({
    required String serial,
    required String password,
  }) async {
    try {
      final client = dioHttp.client(requireAuth: false);

      final response = await client.post(
        '/api/kiosks/login/kiosk',
        data: {
          'serial': serial,
          'password': password,
        },
      );

      final loginResponse = LoginResponse.fromJson(response.data);

      // Cambiar funcion para poder guardar el objeto completo en lugar de solo el token
      if (loginResponse.restaurantId != null) {
        await LocalStorage.saveRestaurantId(loginResponse.restaurantId!);
        debugPrint('==> Restaurant ID guardado: ${loginResponse.restaurantId}');
      }
      return ApiResult.success(data: loginResponse);
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