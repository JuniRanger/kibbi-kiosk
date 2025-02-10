import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/utils/app_helpers.dart';
import '../theme/theme.dart';
import 'shimmers/make_shimmer.dart';

class CommonImage extends StatelessWidget {
  final String? url;
  final double width;
  final double height;
  final double radius;
  final bool isResponsive;
  final File? fileImage;
  final BoxFit fit;

  const CommonImage({
    super.key,
    required this.url,
    this.width = double.infinity,
    this.height = 50,
    this.radius = 10,
    this.isResponsive = true,
    this.fileImage,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius.r),
      child: fileImage != null
          ? Image.file(
              fileImage!,
              height: height,
              width: width,
              fit: fit,
            )
          : AppHelpers.checkIsSvg(url)
              ? SvgPicture.network(
                  '$url',
                  width: isResponsive ? width.r : width,
                  height: isResponsive ? height.r : height,
                  fit: BoxFit.cover,
                  placeholderBuilder: (_) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius.r),
                      color: Style.white,
                    ),
                  ),
                )
              : CachedNetworkImage(
                  imageUrl: '$url',
                  width: isResponsive ? width.r : width,
                  height: isResponsive ? height.r : height,
                  fit: fit,
                  progressIndicatorBuilder: (context, url, progress) {
                    return MakeShimmer(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              isResponsive ? radius.r : radius),
                          color: Style.mainBack,
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      width: isResponsive ? width.r : width,
                      height: isResponsive ? height.r : height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            isResponsive ? radius.r : radius),
                        border: Border.all(color: Style.border),
                        color: Style.mainBack,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        FlutterRemix.image_line,
                        color: Style.black.withOpacity(0.5),
                        size: isResponsive ? 20.r : 20,
                      ),
                    );
                  },
                ),
    );
  }
}
