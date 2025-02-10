import 'package:dio/dio.dart';

import '../constants/constants.dart';
import 'token_interceptor.dart';

class HttpService {
  Dio client({bool requireAuth = false}) => Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 40),
      receiveTimeout: const Duration(seconds: 40),
      sendTimeout: const Duration(seconds: 40),
      headers: {
        'Accept': 'application/json',
        'Content-type': 'application/json'
      },
    ),
  )
    ..interceptors.add(TokenInterceptor(requireAuth: requireAuth))
    ..interceptors
        .add(LogInterceptor(responseBody: true, requestBody: true));
}
