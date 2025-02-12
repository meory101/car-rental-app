import 'dart:convert';

import 'package:car_rental_app/core/api/api_links.dart';
import 'package:car_rental_app/core/widget/bottom_sheet/wheel_date_picker.dart';
import 'package:car_rental_app/core/widget/container/shimmer_container.dart';
import 'package:car_rental_app/core/widget/snack_bar/note_message.dart';
import 'package:car_rental_app/feature/home/models/reserve_car_request_entity.dart';
import 'package:car_rental_app/feature/main/main_bottom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/resource/size_manager.dart';
import '../../../core/api/api_methods.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/widget/button/main_app_button.dart';
import '../../../core/widget/text/app_text_widget.dart';
import '../../../core/widget/text/price_text_widget.dart';
import '../models/cars_response_entity.dart';
import '../widget/car_main_info.dart';
import '../widget/product_details_image_slider.dart';
import '../widget/product_more_details_expansion_card.dart';
import 'package:http/http.dart' as http;

class CarDetailsScreen extends StatefulWidget {
  final CarsResponseEntity car;

  const CarDetailsScreen({super.key, required this.car});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  int selectedPlan = -1;
  int status = -1;
  ReserveCarRequestEntity entity = ReserveCarRequestEntity();

  void reserveCar() async {
    setState(() {
      status = 0;
    });
    entity.car = widget.car.idCar.toString();
    http.Response response =
        await HttpMethods().postMethod(ApiPostUrl.reserve, entity.toJson());
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        status = 1;
      });

      selectedIndex = 2;

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) {
            return MainBottomAppBar();
          },
        ),
        (route) => false,
      );
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
      backgroundColor: AppColorManager.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MainAppButton(
            padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w3Point8),
            alignment: Alignment.center,
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadiusManager.r15),
            borderColor: AppColorManager.lightGreyOpacity6,
            outLinedBorde: true,
            height: AppHeightManager.h7,
            width: AppWidthManager.w90,
            child: InkWell(
              onTap: () {
                setState(() {
                  showWheelDatePicker(
                    context: context,
                    onDateSelected: (date) {
                      entity.startDate = date.toLocal().toString();
                    },
                  );
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextWidget(
                    text: entity.startDate ?? "choose date",
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
            height: AppHeightManager.h2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MainAppButton(
                padding:
                    EdgeInsets.symmetric(horizontal: AppWidthManager.w3Point8),
                alignment: Alignment.center,
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadiusManager.r15),
                borderColor: AppColorManager.lightGreyOpacity6,
                outLinedBorde: true,
                height: AppHeightManager.h7,
                width: AppWidthManager.w30,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: AppColorManager.background,
                      builder: (context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return Container(
                            height: AppHeightManager.h40,
                            margin: EdgeInsets.all(AppWidthManager.w3Point8),
                            width: AppWidthManager.w90,
                            decoration: BoxDecoration(
                                color: AppColorManager.background),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (widget.car.isAvailableDaily == false)
                                        return;
                                      setState(() {
                                        selectedPlan = 0;
                                      });
                                    },
                                    child: MainAppButton(
                                      outLinedBorde:
                                          selectedPlan == 0 ? true : false,
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.all(
                                          AppWidthManager.w3Point8),
                                      color: widget.car.isAvailableDaily ==
                                              false
                                          ? AppColorManager.lightGreyOpacity6
                                          : AppColorManager.background,
                                      width: AppWidthManager.w90,
                                      height: AppHeightManager.h6,
                                      child: AppTextWidget(
                                        text: "day (1 day)",
                                        fontSize: FontSizeManager.fs15,
                                        color:
                                            widget.car.isAvailableDaily == false
                                                ? AppColorManager.grey
                                                : AppColorManager.black,
                                        fontWeight: FontWeight.w600,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (widget.car.isAvailableMonthly ==
                                          false) return;
                                      setState(() {
                                        selectedPlan = 1;
                                      });
                                    },
                                    child: MainAppButton(
                                      outLinedBorde:
                                          selectedPlan == 1 ? true : false,
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.all(
                                          AppWidthManager.w3Point8),
                                      color: widget.car.isAvailableMonthly ==
                                              false
                                          ? AppColorManager.lightGreyOpacity6
                                          : AppColorManager.background,
                                      width: AppWidthManager.w90,
                                      height: AppHeightManager.h6,
                                      child: AppTextWidget(
                                        text: "month (30 Days)",
                                        fontSize: FontSizeManager.fs15,
                                        color: widget.car.isAvailableMonthly ==
                                                false
                                            ? AppColorManager.grey
                                            : AppColorManager.black,
                                        fontWeight: FontWeight.w600,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (widget.car.isAvailableYearly == false)
                                        return;

                                      setState(() {
                                        selectedPlan = 2;
                                      });
                                    },
                                    child: MainAppButton(
                                      outLinedBorde:
                                          selectedPlan == 2 ? true : false,
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.all(
                                          AppWidthManager.w3Point8),
                                      color: widget.car.isAvailableYearly ==
                                              false
                                          ? AppColorManager.lightGreyOpacity6
                                          : AppColorManager.background,
                                      width: AppWidthManager.w90,
                                      height: AppHeightManager.h6,
                                      child: AppTextWidget(
                                        text: "year (365 Days)",
                                        fontSize: FontSizeManager.fs15,
                                        color: widget.car.isAvailableYearly ==
                                                false
                                            ? AppColorManager.grey
                                            : AppColorManager.black,
                                        fontWeight: FontWeight.w600,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: AppHeightManager.h3,
                                  ),
                                  MainAppButton(
                                    onTap: () {
                                      entity.typeReservation =
                                          (selectedPlan + 1).toString();
                                      Navigator.of(context).pop();
                                    },
                                    padding: EdgeInsets.symmetric(
                                        horizontal: AppWidthManager.w3Point8),
                                    alignment: Alignment.center,
                                    color: AppColorManager.black,
                                    borderRadius: BorderRadius.circular(
                                        AppRadiusManager.r15),
                                    borderColor:
                                        AppColorManager.lightGreyOpacity6,
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
                        });
                      },
                    ).then(
                      (value) => setState(() {}),
                    );
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
              Visibility(
                visible: status == 0,
                replacement: MainAppButton(
                  onTap: () {
                    if (entity.startDate == null ||
                        entity.typeReservation == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: AppTextWidget(
                            text: "select date and reservation type",
                            color: AppColorManager.white,
                            fontSize: FontSizeManager.fs14,
                            fontWeight: FontWeight.w700,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      );
                      return;
                    }
                    reserveCar();
                  },
                  padding: EdgeInsets.symmetric(
                      horizontal: AppWidthManager.w3Point8),
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
                child: ShimmerContainer(
                  height: AppHeightManager.h7,
                  width: AppWidthManager.w60,
                ),
              ),
            ],
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
            ProductDetailsImageSlider(
              car: widget.car,
            ),
            SizedBox(
              height: AppHeightManager.h1point8,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppWidthManager.w3Point8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: AppHeightManager.h1point8,
                      ),
                      AppTextWidget(
                        text: widget.car.description ?? "",
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
                            price: selectedPlan == 0 || selectedPlan == -1
                                ? "day ${widget.car.dailyRentPrice}"
                                : selectedPlan == 1
                                    ? "month ${widget.car.monthlyRentPrice}"
                                    : selectedPlan == 2
                                        ? "year ${widget.car.yearlyRentPrice}"
                                        : "",
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
                  ),
                  SizedBox(
                    height: AppHeightManager.h2,
                  ),
                  ProductMoreDetailsExpansionCard(
                    car: widget.car,
                  ),
                  SizedBox(
                    height: AppHeightManager.h19,
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
