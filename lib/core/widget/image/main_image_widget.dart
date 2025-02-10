// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental_app/core/resource/icon_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

import '../../resource/color_manager.dart';

class MainImageWidget extends StatelessWidget {
  const MainImageWidget({
    super.key,
    this.imageUrl = '',
    this.imagePath,
    this.placeholderUrl,
    this.fit,
    this.width,
    this.height,
    this.shape,
    this.borderRadius,
    this.filterQuality = FilterQuality.high,
  });

  final String imageUrl;
  final String? imagePath;
  final String? placeholderUrl;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final FilterQuality filterQuality;
  final BoxShape? shape;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return (imageUrl??"").isNotEmpty
        ? CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      filterQuality: filterQuality,
      errorWidget: (context, url, error) => Image.asset(
        AppImageManager.wheel,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
      ),
      progressIndicatorBuilder: (context, url, progress) {
        return MainProgressImageWidget(
          width: width,
          height: height,
        );
      },
    )
        : imagePath != null
        ? Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius ??
            BorderRadius.all(
              Radius.circular(
               15,
              ),
            ),
        image: DecorationImage(
          image: Image.asset(
            imagePath!,
            width: width,
            height: height,
          ).image,
          fit: fit ?? BoxFit.cover,
        ),
      ),
    )
        : MainProgressImageWidget(
      width: width,
      height: height,
    );
  }
}

class MainProgressImageWidget extends StatelessWidget {
  const MainProgressImageWidget({super.key, this.width, this.height});

  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColorManager.shimmerBaseColor,
      highlightColor: AppColorManager.shimmerHighlightColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColorManager.shimmerBaseColor,
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
        ),
      ),
    );
  }
}