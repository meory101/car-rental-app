import 'dart:async';
import 'dart:convert';
import 'package:car_rental_app/core/widget/button/main_app_button.dart';
import 'package:car_rental_app/feature/main/main_bottom_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../core/api/api_links.dart';
import '../../../core/api/api_methods.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/icon_manager.dart';
import '../../../core/resource/size_manager.dart';
import '../../../core/widget/container/decorated_container.dart';
import '../../../core/widget/image/main_image_widget.dart';
import '../../../core/widget/text/app_text_widget.dart';
import '../../home/models/car_list_response_entity.dart';
import '../models/reservations_response_entity.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({super.key});

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  int status = -1;
  List<ReservationsResponseEntity> reservations = [];
  Timer? _timer;
  List<CarsResponseEntity> cars = [];

  @override
  void initState() {
    super.initState();
    getCars();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        reservations = reservations.map((res) {
          if (res.remainingTime != null) {
            num totalSeconds = (res.remainingTime!.mint ?? 0) * 60 +
                (res.remainingTime!.second ?? 0);
            if (totalSeconds > 0) {
              totalSeconds--;
            }
            int newMinutes = totalSeconds ~/ 60;
            num newSeconds = totalSeconds % 60;
            res.remainingTime!.mint = newMinutes;
            res.remainingTime!.second = newSeconds;
          }
          return res;
        }).toList();
      });
    });
  }

  void getCars() async {
    http.Response response =
        await HttpMethods().getMethod(ApiGetUrl.cars, null);
    if (response.statusCode == 200 || response.statusCode == 201) {
      cars =
          carListResponseEntityFromJson(utf8.decode(response.bodyBytes)).cars ??
              [];
    }
    getReservations();
  }

  void deleteReservation(String id) async {
    http.Response response =
        await HttpMethods().putMethod(ApiPostUrl.cancel, id);
    if (response.statusCode == 200 || response.statusCode == 201) {
      selectedIndex = 2;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MainBottomAppBar()),
        (route) => false,
      );
    }
    getReservations();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void getReservations({bool updateUI = true}) async {
    http.Response response =
        await HttpMethods().getMethod(ApiGetUrl.myReservations, null);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 404) {
      List<ReservationsResponseEntity> newReservations =
          response.statusCode == 404
              ? []
              : reservationsResponseEntityListFromJson(
                  utf8.decode(response.bodyBytes));

      if (!listEquals(newReservations, reservations)) {
        if (mounted) {
          setState(() {
            reservations = newReservations;
            status = 1;
          });
        }
      }
    } else {
      if (updateUI && mounted) {
        setState(() {
          status = 2;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: RefreshIndicator(
            color: AppColorManager.mainColor,
            onRefresh: () async {},
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppTextWidget(
                    text: " حجوزاتي وسياراتي",
                    fontSize: FontSizeManager.fs18,
                    fontWeight: FontWeight.w600,
                    color: AppColorManager.black,
                  ),
                  const SizedBox(height: 10),
                  reservations.isEmpty
                      ? Column(
                          children: [
                            SizedBox(height: AppHeightManager.h25),
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
                              text: "لا يوجد حجوزات",
                              fontSize: FontSizeManager.fs18,
                              fontWeight: FontWeight.w600,
                              color: AppColorManager.black,
                            ),
                          ],
                        )
                      : ListView.builder(
                          itemCount: reservations.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final car = cars.firstWhere(
                              (car) => car.idCar == reservations[index].car,
                              orElse: () => CarsResponseEntity(image1: null),
                            );
                            final rem = reservations[index].remainingTime;
                            final formattedTime = rem == null
                                ? '--:--'
                                : "${(rem.mint ?? 0).toString().padLeft(2, '0')}:${(rem.second ?? 0).toString().padLeft(2, '0')}";

                            return DecoratedContainer(
                              margin:
                                  EdgeInsets.only(bottom: AppHeightManager.h2),
                              borderRadius:
                                  BorderRadius.circular(AppRadiusManager.r15),
                              padding: EdgeInsets.all(AppWidthManager.w3Point8),
                              child: Column(
                                children: [
                                  SizedBox(height: AppHeightManager.h2),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      MainImageWidget(
                                        height: AppHeightManager.h10,
                                        width: AppHeightManager.h10,
                                        imageUrl: car.image1 ??
                                            car.image2 ??
                                            car.image3 ??
                                            "",
                                      ),
                                      SizedBox(width: AppWidthManager.w1Point2),
                                      Expanded(
                                        child: AppTextWidget(
                                          text: car.description ?? "",
                                          fontSize: FontSizeManager.fs16,
                                          fontWeight: FontWeight.w600,
                                          color: AppColorManager.black,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: AppHeightManager.h2),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      MainAppButton(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: AppWidthManager.w8,
                                          vertical: AppWidthManager.w1,
                                        ),
                                        height: AppHeightManager.h6,
                                        color: AppColorManager.mainColor,
                                        child: AppTextWidget(

                                          text:
                                              "${reservations[index].typeReservation}",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: AppHeightManager.h2),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text:
                                            "تاريج البدء ${reservations[index].startDate?.split("T").first}",
                                        fontSize: FontSizeManager.fs15,
                                        fontWeight: FontWeight.w600,
                                        color: AppColorManager.black,
                                      ),
                                      AppTextWidget(
                                        text:
                                            "لتاريخ ${reservations[index].endDate?.split("T").first}",
                                        fontSize: FontSizeManager.fs15,
                                        fontWeight: FontWeight.w600,
                                        color: AppColorManager.black,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: AppHeightManager.h2),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.end,
                                    children: [
                                      AppTextWidget(
                                        text: "الوقت المتبقي  ",
                                        fontSize: FontSizeManager.fs16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColorManager.black,
                                      ),
                                      AppTextWidget(
                                        text: formattedTime,
                                        fontSize: FontSizeManager.fs15,
                                        fontWeight: FontWeight.w600,
                                        color: AppColorManager.mainColor,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: AppHeightManager.h2),
                                  MainAppButton(
                                    onTap: () {
                                      deleteReservation(reservations[index]
                                          .idReservation
                                          .toString());
                                    },
                                    alignment: Alignment.center,
                                    width: AppWidthManager.w90,
                                    height: AppHeightManager.h5,
                                    color:  reservations[index].typeReservation ==
                                        "شراء" ?  AppColorManager.lightBlue: AppColorManager.red,
                                    child: AppTextWidget(
                                      text:
                                          reservations[index].typeReservation ==
                                                  "شراء"
                                              ? "الغاء الطلب"
                                              : "الغاء الحجز",
                                      fontSize: FontSizeManager.fs16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColorManager.white,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
