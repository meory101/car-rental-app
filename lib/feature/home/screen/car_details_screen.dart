import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/resource/size_manager.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/widget/button/main_app_button.dart';
import '../../../core/widget/text/app_text_widget.dart';
import '../widget/car_main_info.dart';
import '../widget/product_details_image_slider.dart';
import '../widget/product_more_details_expansion_card.dart';



class CarDetailsScreen extends StatefulWidget {
  const CarDetailsScreen({super.key});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:               MainAppButton(
        onTap: () async {

        },
        borderColor: AppColorManager.black,
        alignment: Alignment.center,
        width: AppWidthManager.w90,
        height: AppHeightManager.h6,
        borderRadius: BorderRadius.circular(AppRadiusManager.r10),
        color: Colors.green,

        child: AppTextWidget(
          text: "Rent Now",
          color: Colors.white,
          fontSize: FontSizeManager.fs16,
          fontWeight: FontWeight.w600,
          overflow: TextOverflow.visible,
        ),
      )
      ,
      body: SafeArea(

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppHeightManager.h2,
                ),
                ProductDetailsImageSlider(),
                SizedBox(
                  height: AppHeightManager.h1point8,
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: AppWidthManager.w3Point8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                         CarMainInfo(),
                      SizedBox(
                        height: AppHeightManager.h4point4,
                      ),
                      ProductMoreDetailsExpansionCard(),
                      SizedBox(
                        height: AppHeightManager.h10,
                      ),

                    ],
                  ),
                ),


              ],
            ),
          )),
    );
  }
}
