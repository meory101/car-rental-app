import 'package:car_rental_app/core/widget/image/main_image_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/resource/color_manager.dart';
import '../../../../core/resource/size_manager.dart';
import '../../../core/resource/icon_manager.dart';


class ProductDetailsImageSlider extends StatefulWidget {
  const ProductDetailsImageSlider({super.key});

  @override
  State<ProductDetailsImageSlider> createState() => _ProductDetailsImageSliderState();
}

class _ProductDetailsImageSliderState extends State<ProductDetailsImageSlider> {
  int selectedProductImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                selectedProductImageIndex = index;
              });
            },
            aspectRatio: AppWidthManager.w80 / AppHeightManager.h30,
            enableInfiniteScroll: true,
            autoPlay: false,

            viewportFraction: 0.8,

          ),
          items: List.generate(
            10,
                (index) {
              return InkWell(
                onTap: () {},
                child: Container(
                    margin: EdgeInsets.only(
                      left: 4,
                        right: 4,
                        top: selectedProductImageIndex==index ? 0:AppHeightManager.h5,
                        bottom: selectedProductImageIndex==index ? 0:AppHeightManager.h5,
                    ),
                    width: AppWidthManager.w80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppRadiusManager.r10)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: MainImageWidget(
                      fit: BoxFit.cover,
                        imagePath: AppImageManager.car3

                    )),
              );
            },
          ),
        ),
        SizedBox(
          height: AppHeightManager.h1point8,
        ),
        DotsIndicator(
          dotsCount: 10,
          position: selectedProductImageIndex,
          decorator: DotsDecorator(
            spacing: EdgeInsets.only(
                left:  AppWidthManager.w1,

                right:  AppWidthManager.w1
                   ),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppRadiusManager.r10,
              ),
            ),
            activeSize: Size(
              AppWidthManager.w6,
              AppHeightManager.h08,
            ),
            size: Size(
              AppWidthManager.w1Point5,
              AppWidthManager.w1Point5,
            ),
            activeColor: AppColorManager.mainColor,
            color: AppColorManager.lightGreyOpacity6,
          ),
        ),
      ],
    );
  }
}
