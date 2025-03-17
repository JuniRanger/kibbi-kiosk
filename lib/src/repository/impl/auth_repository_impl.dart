import 'package:kibbi_kiosk/src/core/di/dependency_manager.dart';
import 'package:kibbi_kiosk/src/core/utils/app_helpers.dart';
import 'package:flutter/material.dart';
import 'package:kibbi_kiosk/src/models/models.dart';

import 'package:kibbi_kiosk/src/core/handlers/handlers.dart';
import '../repository.dart';
import '../../core/utils/local_storage.dart';

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

      return ApiResult.success(data: loginResponse);
    } catch (e) {
      debugPrint('==> login failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }
}




