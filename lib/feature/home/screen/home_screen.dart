import 'package:car_rental_app/core/resource/color_manager.dart';
import 'package:car_rental_app/core/resource/size_manager.dart';
import 'package:car_rental_app/feature/home/widget/cars_grid_view.dart';
import 'package:car_rental_app/feature/home/widget/home_app_bar.dart';
import 'package:car_rental_app/feature/home/widget/home_banners.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/resource/font_manager.dart';
import '../../../core/resource/icon_manager.dart';
import '../../../core/widget/text/app_text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppWidthManager.w3Point8),
            child: Column(
              children: [
                HomeAppBar(),
                SizedBox(
                  height: AppHeightManager.h2point5,
                ),
                HomeBanners(),
                SizedBox(
                  height: AppHeightManager.h2point5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTextWidget(
                      text: "Renting Cars",
                      fontSize: FontSizeManager.fs17,
                      color: AppColorManager.black,

                      fontWeight: FontWeight.w600,
                    ),

                  ],
                ),
                SizedBox(
                  height: AppHeightManager.h1point8,
                ),
                CarsGridView()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
