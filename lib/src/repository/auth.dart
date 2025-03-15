import '../core/handlers/handlers.dart';
import '../models/models.dart';

abstract class AuthFacade {
  Future<ApiResult<LoginResponse>> login({
    required String serial,
    required String password,
  });

  

  // Future<ApiResult<void>> updateJwtToken(String? token);
}
