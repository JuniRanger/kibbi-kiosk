import 'package:kiosk/src/core/constants/constants.dart';
import 'package:kiosk/src/core/handlers/api_result.dart';
import 'package:kiosk/src/models/models.dart';

abstract class GalleryRepositoryFacade {
  Future<ApiResult<GalleryUploadResponse>> uploadImage(
      String file,
      UploadType uploadType,
      );

  Future<ApiResult<MultiGalleryUploadResponse>> uploadMultiImage(
      List<String?> filePaths,
      UploadType uploadType,
      );
}
