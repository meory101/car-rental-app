import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import '../../resource/color_manager.dart';
import '../text/app_text_widget.dart';

abstract class NoteMessage {
  static showErrorSnackBar({
    required BuildContext context,
    required String text,
    void Function()? onTap,
    int? duration,
    TextOverflow? overflow,
    int? maxLines,
    bool? refresh,
  }) {
    return context.showFlash(
        duration: Duration(seconds: refresh == null ? 2 : 4),
        builder: (context, controller) => FlashBar(
              shadowColor: AppColorManager.white,
              surfaceTintColor: AppColorManager.white,
              useSafeArea: false,
              controller: controller,
              position: FlashPosition.top,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.only(
                  right: 16,
                  left: 16,
                  top: 100),
              title: AppTextWidget(
                text: "${"hi"} !",
                fontSize:16,
                color: AppColorManager.grey,
                fontWeight: FontWeight.w600,
                overflow: overflow ?? TextOverflow.ellipsis,
                maxLines: maxLines ?? 2,
                softWrap: true,
              ),
              content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AppTextWidget(
                        text: text.isNotEmpty ? text : "Something went wrong",
                        fontSize: 15,
                        color: AppColorManager.black,
                        fontWeight: FontWeight.w600,
                        overflow: overflow ?? TextOverflow.ellipsis,
                        maxLines: maxLines ?? 3,
                        softWrap: true,
                      ),
                    ),

                  ]),
              backgroundColor: AppColorManager.white.withAlpha(230),
            ));
  }

  static showSuccessSnackBar({
    required BuildContext context,
    required String text,
    void Function()? onTap,
    int? duration,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return context.showFlash(
        duration: const Duration(seconds: 2),
        builder: (context, controller) => FlashBar(
              shadowColor: AppColorManager.white,
              surfaceTintColor: AppColorManager.white,
              useSafeArea: false,
              controller: controller,
              position: FlashPosition.top,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.only(
                  right:16,
                  left: 16,
                  top: 100),
              title: AppTextWidget(
                text: "${"hi"} !",
                fontSize: 16,
                color: AppColorManager.grey,
                fontWeight: FontWeight.w600,
                overflow: overflow ?? TextOverflow.ellipsis,
                maxLines: maxLines ?? 2,
                softWrap: true,
              ),
              content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AppTextWidget(
                        text: text,
                        fontSize:15,
                        color: AppColorManager.black,
                        fontWeight: FontWeight.w600,
                        overflow: overflow ?? TextOverflow.ellipsis,
                        maxLines: maxLines ?? 3,
                        softWrap: true,
                      ),
                    ),

                  ]),
              backgroundColor: AppColorManager.white.withAlpha(230),
            ));
  }


}
