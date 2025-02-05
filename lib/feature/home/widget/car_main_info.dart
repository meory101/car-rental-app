import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/resource/color_manager.dart';
import '../../../../core/resource/font_manager.dart';
import '../../../../core/resource/size_manager.dart';
import '../../../../core/widget/image/main_image_widget.dart';
import '../../../../core/widget/text/app_text_widget.dart';
import '../../../core/resource/icon_manager.dart';
import '../../../core/widget/button/main_app_button.dart';
import '../../../core/widget/text/price_text_widget.dart';



class CarMainInfo extends StatefulWidget {
  const CarMainInfo({super.key});

  @override
  State<CarMainInfo> createState() => _CarMainInfoState();
}

class _CarMainInfoState extends State<CarMainInfo> {


  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AppHeightManager.h2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: AppWidthManager.w7,
                  height: AppWidthManager.w7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: MainImageWidget(imageUrl: ""),
                  ),
                ),
                SizedBox(
                  width: AppWidthManager.w1Point2,
                ),
                AppTextWidget(
                  text: "Nour Nour",
                  fontSize: FontSizeManager.fs15,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),

          ],
        ),
        SizedBox(
          height: AppHeightManager.h1point8,
        ),
        AppTextWidget(
          text:
          "Car name Car name Product na me Car name Car name",
          fontSize: FontSizeManager.fs15,
          fontWeight: FontWeight.w600,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        SizedBox(
          height: AppHeightManager.h1point8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PriceTextWidget(
              currency: "",
              price: "999",
              priceStyle: TextStyle(
                fontSize: FontSizeManager.fs16,
                color: AppColorManager.textAppColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        SizedBox(
          height: AppHeightManager.h2point5,
        ),
      ],
    );
  }
}
