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
    final data = {'serial': serial, 'password': password};
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.post(
        '/api/v1/auth/login',
        queryParameters: data,
      );
      return ApiResult.success(
        data: LoginResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> login failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<void>> updateFirebaseToken(String? token) async {
    final data = {if (token != null) 'firebase_token': token};
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.post(
        '/api/v1/dashboard/user/profile/firebase/token/update',
        data: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> update firebase token failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }
}
