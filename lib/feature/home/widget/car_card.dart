import 'package:car_rental_app/core/resource/color_manager.dart';
import 'package:car_rental_app/core/resource/icon_manager.dart';
import 'package:car_rental_app/core/widget/container/decorated_container.dart';
import 'package:car_rental_app/feature/home/screen/car_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/image/main_image_widget.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/size_manager.dart';
import '../../../core/widget/text/app_text_widget.dart';
import '../../../core/widget/text/price_text_widget.dart';
import '../models/cars_response_entity.dart';

class CarCard extends StatefulWidget {
  final CarsResponseEntity car;

  const CarCard({super.key, required this.car});

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  int selectedColorIndex = -1;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: WidgetStatePropertyAll(AppColorManager.transparent),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return CarDetailsScreen(car: widget.car,);
          },
        ));
      },
      child: DecoratedContainer(
        padding: EdgeInsets.only(
          bottom: AppHeightManager.h2,
        ),
        margin: EdgeInsets.only(bottom: AppHeightManager.h2),
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadiusManager.r15),
        width: AppWidthManager.w44,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: AppHeightManager.h20,
              width: AppWidthManager.w45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    AppRadiusManager.r15,
                  ),
                  topRight: Radius.circular(
                    AppRadiusManager.r15,
                  ),
                ),
              ),
              child: MainImageWidget(
                  width: AppWidthManager.w44,
                  height: AppHeightManager.h27,
                  fit: BoxFit.cover,
                  imagePath: AppImageManager.car3),
            ),
            SizedBox(
              height: AppHeightManager.h06,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextWidget(
                    text: widget.car.description ?? "",
                    fontSize: FontSizeManager.fs15,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: AppHeightManager.h3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PriceTextWidget(
                          currency: "SYP",
                          price: widget.car.dailyRentPrice.toString()),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppHeightManager.h1point5,
            ),
          ],
        ),
      ),
    );
  }
}
