import 'package:car_rental_app/core/widget/container/decorated_container.dart';
import 'package:car_rental_app/core/widget/drop_down/NameAndId.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/resource/size_manager.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/icon_manager.dart';
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
  int selectedPlan = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainAppButton(
            padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w3Point8),
            alignment: Alignment.center,
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadiusManager.r15),
            borderColor: AppColorManager.lightGreyOpacity6,
            outLinedBorde: true,
            height: AppHeightManager.h7,
            width: AppWidthManager.w30,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(context: context,
                  backgroundColor: AppColorManager.background,

                  builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return Container(
                        height: AppHeightManager.h40,
                        margin: EdgeInsets.all(AppWidthManager.w3Point8),
                        width: AppWidthManager.w90,
                        decoration: BoxDecoration(
                          color: AppColorManager.background
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedPlan=0;
                                  });
                                },
                                child: MainAppButton(
                                  outLinedBorde: selectedPlan==0 ?true:false,

                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(AppWidthManager.w3Point8),
                                  color: AppColorManager.background,
                                  width: AppWidthManager.w90,
                                  height: AppHeightManager.h6,
                                  child: AppTextWidget(
                                    text: "day (1 day)",
                                    fontSize: FontSizeManager.fs15,
                                    color: AppColorManager.textAppColor,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedPlan=1;
                                  });
                                },
                                child: MainAppButton(
                                  outLinedBorde: selectedPlan==1 ?true:false,

                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(AppWidthManager.w3Point8),
                                  color: AppColorManager.background,
                                  width: AppWidthManager.w90,
                                  height: AppHeightManager.h6,
                                  child: AppTextWidget(
                                    text: "month (30 Days)",
                                    fontSize: FontSizeManager.fs15,
                                    color: AppColorManager.textAppColor,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ),

                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedPlan=2;
                                  });
                                },
                                child: MainAppButton(
                                  outLinedBorde: selectedPlan==2 ?true:false,

                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(AppWidthManager.w3Point8),
                                  color: AppColorManager.background,
                                  width: AppWidthManager.w90,
                                  height: AppHeightManager.h6,
                                  child: AppTextWidget(
                                    text: "year (365 Days)",
                                    fontSize: FontSizeManager.fs15,
                                    color: AppColorManager.textAppColor,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                              SizedBox(height: AppHeightManager.h3,),

                              MainAppButton(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w3Point8),
                                alignment: Alignment.center,
                                color: AppColorManager.black,
                                borderRadius: BorderRadius.circular(AppRadiusManager.r15),
                                borderColor: AppColorManager.lightGreyOpacity6,
                                height: AppHeightManager.h7,
                                width: AppWidthManager.w90,
                                child: AppTextWidget(
                                  text: "Done",
                                  fontSize: FontSizeManager.fs15,
                                  color: AppColorManager.white,
                                  fontWeight: FontWeight.w700,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                ),
                              ),


                            ],
                          ),
                        ),
                      );
                    }
                  );
                },);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextWidget(
                    text: "Rent",
                    fontSize: FontSizeManager.fs15,
                    color: AppColorManager.textAppColor,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Icon(Icons.keyboard_arrow_down_sharp)
                ],
              ),
            ),
          ),
          SizedBox(
            width: AppWidthManager.w2,
          ),
          MainAppButton(
            padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w3Point8),
            alignment: Alignment.center,
            color: AppColorManager.black,
            borderRadius: BorderRadius.circular(AppRadiusManager.r15),
            borderColor: AppColorManager.lightGreyOpacity6,
            height: AppHeightManager.h7,
            width: AppWidthManager.w60,
            child: AppTextWidget(
              text: "Book Now",
              fontSize: FontSizeManager.fs15,
              color: AppColorManager.white,
              fontWeight: FontWeight.w700,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
        ],
      ),
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
                    height: AppHeightManager.h2,
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
