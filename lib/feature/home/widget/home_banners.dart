import 'package:car_rental_app/core/resource/icon_manager.dart';
import 'package:car_rental_app/core/widget/image/main_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resource/color_manager.dart';
import '../../../../../core/resource/size_manager.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

class HomeBanners extends StatefulWidget {
  const HomeBanners({
    super.key,
  });

  @override
  State<HomeBanners> createState() => _HomeBannersState();
}

class _HomeBannersState extends State<HomeBanners> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                selectedIndex = index;
              });
            },
            aspectRatio: AppWidthManager.w92 / AppHeightManager.h40,
            enableInfiniteScroll: true,
            autoPlay: false,
            viewportFraction: 1,
          ),
          items: List.generate(
            2,
            (index) {
              return InkWell(
                onTap: () {},
                child: Container(
                    width: AppWidthManager.w92,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(AppRadiusManager.r10)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: MainImageWidget(
                      fit: BoxFit.fitWidth,
                      imagePath: index == 0
                          ? AppImageManager.car1
                          : AppImageManager.car2,
                    )),
              );
            },
          ),
        ),
        SizedBox(
          height: AppHeightManager.h1point8,
        ),
        DotsIndicator(
          dotsCount: 2,
          position: selectedIndex,
          decorator: DotsDecorator(
            spacing: EdgeInsets.only(
                left: AppWidthManager.w1Point8,
                right: AppWidthManager.w1Point8),
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
