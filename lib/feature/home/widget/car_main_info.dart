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
import '../models/cars_response_entity.dart';



class CarMainInfo extends StatefulWidget {
  final CarsResponseEntity car ;
  const CarMainInfo({super.key,required this.car});

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
          height: AppHeightManager.h1point8,
        ),
        AppTextWidget(
          text:
          widget.car.description ??"",
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
              price: "daily ${widget.car.dailyRentPrice}",
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
