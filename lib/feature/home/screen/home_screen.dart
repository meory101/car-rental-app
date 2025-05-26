import 'dart:convert';

import 'package:car_rental_app/core/api/api_links.dart';
import 'package:car_rental_app/core/resource/color_manager.dart';
import 'package:car_rental_app/core/resource/size_manager.dart';
import 'package:car_rental_app/core/widget/drop_down/NameAndId.dart';
import 'package:car_rental_app/feature/home/widget/cars_grid_view.dart';
import 'package:car_rental_app/feature/home/widget/home_app_bar.dart';
import 'package:car_rental_app/feature/home/widget/home_banners.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/api/api_methods.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/icon_manager.dart';
import '../../../core/widget/text/app_text_widget.dart';
import 'package:http/http.dart' as http;

import '../models/car_list_response_entity.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getCars();
    super.initState();
  }
  int status = -1;
  List<CarsResponseEntity> cars = [];

  void getCars() async {
    setState(() {
      status = 0;
    });
    http.Response response =
    await HttpMethods().getMethod(ApiGetUrl.cars,null);
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        status = 1;
      });
      cars = carListResponseEntityFromJson(utf8.decode(response.bodyBytes)).cars??[];

    } else {
      setState(() {
        status = 2;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppTextWidget(
            text:  utf8.decode(response.bodyBytes),
            color: AppColorManager.white,
            fontSize: FontSizeManager.fs14,
            fontWeight: FontWeight.w700,
            overflow: TextOverflow.visible,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.background,
      body: RefreshIndicator(
        color: AppColorManager.mainColor,
        onRefresh: ()async {
         return getCars();
        },
        child: SafeArea(
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
                        text: " سيارات الاجار والبيع",
                        fontSize: FontSizeManager.fs17,
                        color: AppColorManager.black,

                        fontWeight: FontWeight.w600,
                      ),

                    ],
                  ),
                  SizedBox(
                    height: AppHeightManager.h1point8,
                  ),
                  Visibility(
                      visible: status == 1 ,
                      replacement: Padding(
                        padding:  EdgeInsets.only(top: AppHeightManager.h10),
                        child: CircularProgressIndicator(
                          color: AppColorManager.mainColor,
                        ),
                      ),
                      child: CarsGridView(
                        cars: cars,
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
