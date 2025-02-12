import 'dart:convert';

import 'package:car_rental_app/core/resource/size_manager.dart';
import 'package:car_rental_app/core/widget/drop_down/NameAndId.dart';
import 'package:car_rental_app/core/widget/drop_down/title_drop_down_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/api/api_links.dart';
import '../../../core/api/api_methods.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/icon_manager.dart';
import '../../../core/widget/form_field/app_form_field.dart';
import '../../../core/widget/image/main_image_widget.dart';
import '../../../core/widget/text/app_text_widget.dart';
import '../../home/models/cars_response_entity.dart';
import 'package:http/http.dart' as http;

import '../../home/widget/cars_grid_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int status = -1;
  List<CarsResponseEntity> cars = [];
  NameAndId? selectedCategory;
  NameAndId? selectedRent;

  void searchCars() async {
    if (selectedCategory?.id == null && selectedRent?.id == null) {
      return;
    }
    setState(() {
      status = 0;
    });
    http.Response response = await HttpMethods().getMethod(ApiGetUrl.search,
        {"category": selectedCategory?.id, "type_rent": selectedRent?.id});
    if (response.statusCode == 200 || response.statusCode == 201 ||
        response.statusCode == 404) {
      setState(() {
        status = 1;
      });
      cars = response.statusCode == 404 ? [] : carsResponseEntityListFromJson(
          utf8.decode(response.bodyBytes)
      );
    }

    else {
      setState(() {
        status = 2;
      });
      String decodedBody = utf8.decode(response.bodyBytes);
      print(decodedBody);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppTextWidget(
            text: decodedBody,
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppWidthManager.w3Point8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppHeightManager.h1point8,
              ),
              Row(
                children: [
                  Expanded(
                    child: TitleDropDownFormFieldWidget(
                        onChanged: (p0) {
                          selectedCategory = p0;
                          searchCars();
                          setState(() {});
                        },
                        hint: "الفئة",
                        title: "الفئة",
                        options: [
                          NameAndId(name: "فاخرة", id: "1"),
                          NameAndId(name: "اقتصادية", id: "2"),
                          NameAndId(name: "other", id: "3"),
                        ]),
                  ),
                  Expanded(
                    child: TitleDropDownFormFieldWidget(
                        onChanged: (p0) {
                          selectedRent = p0;
                          searchCars();
                          setState(() {});
                        },
                        hint: "الاجار",
                        title: "الاجار",
                        options: [
                          NameAndId(name: "يومي", id: "1"),
                          NameAndId(name: "شهري", id: "2"),
                          NameAndId(name: "سنوي", id: "3"),
                        ]),
                  ),
                ],
              ),
              SizedBox(
                height: AppHeightManager.h1point8,
              ),
              Visibility(
                  visible: status == -1,
                  replacement: Visibility(
                    visible: true,
                    replacement: Padding(
                      padding: EdgeInsets.only(top: AppHeightManager.h10),
                      child: CircularProgressIndicator(
                        color: AppColorManager.mainColor,
                      ),
                    ),
                    child: CarsGridView(
                      cars: cars,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: AppHeightManager.h25,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: MainImageWidget(
                          fit: BoxFit.cover,
                          height: AppHeightManager.h20,
                          width: AppHeightManager.h20,
                          imagePath: AppImageManager.wheel,
                        ),
                      ),
                      AppTextWidget(
                        text: "البدء..!",
                        fontSize: FontSizeManager.fs18,
                        fontWeight: FontWeight.w600,
                        color: AppColorManager.black,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
