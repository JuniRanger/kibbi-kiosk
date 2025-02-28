import 'package:kiosk/src/core/di/dependency_manager.dart';
import 'package:flutter/material.dart';

import '../../core/constants/tr_keys.dart';
import 'package:kiosk/src/core/handlers/handlers.dart';
import '../../core/utils/utils.dart';
import '../repository.dart';
import '../../core/utils/local_storage.dart';


class UsersRepositoryImpl extends KioskRepository {

  @override
  Future getKioskDetails() async {
    try {

    } catch (e) {
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }
}
