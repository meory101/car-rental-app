import 'dart:async';
import 'dart:convert';
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
import '../../home/models/cars_response_entity.dart';
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
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      getReservations(updateUI: false);
    });
  }

  void getCars() async {
    http.Response response =
    await HttpMethods().getMethod(ApiGetUrl.cars);
    if (response.statusCode == 200 || response.statusCode == 201) {
      cars = carsResponseEntityListFromJson(response.body);
    } else {}
    getReservations();
  }


  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void getReservations({bool updateUI = true}) async {
    http.Response response =
    await HttpMethods().getMethod(ApiGetUrl.myReservations);

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 404) {
      List<ReservationsResponseEntity> newReservations =
      response.statusCode == 404
          ? []
          : reservationsResponseEntityListFromJson(response.body);

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
            onRefresh: () async {
              // await getReservations();
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppTextWidget(
                    text: "Your Reservations",
                    fontSize: FontSizeManager.fs18,
                    fontWeight: FontWeight.w600,
                    color: AppColorManager.black,
                  ),
                  const SizedBox(height: 10),
                  reservations.isEmpty
                      ? Column(
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
                        text: "No Reservations yet ..!",
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
                        final car = cars.firstWhere((car) =>
                        car.idCar == reservations[index].car,
                            orElse: () => CarsResponseEntity(
                                image1: null));
                        return DecoratedContainer(
                          margin:
                          EdgeInsets.only(bottom: AppHeightManager.h2),
                          borderRadius:
                          BorderRadius.circular(AppRadiusManager.r15),
                          padding: EdgeInsets.all(AppWidthManager.w3Point8),
                          child: Column(children: [
                            SizedBox(
                              height: AppHeightManager.h2,
                            ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                               MainImageWidget(
                                 height: AppHeightManager.h10,
                                 width: AppHeightManager.h10,
                                 imageUrl:car.image1 ??car.image2 ??car.image3,
                               ),
                               Expanded(
                                 child: AppTextWidget(
                                   text:
                                   car.description??""
                                     ,
                                   fontSize: FontSizeManager.fs16,
                                   fontWeight: FontWeight.w600,
                                   color: AppColorManager.black,
                                   maxLines: 2,
                                   
                                 ),
                               ),
                             ],
                           ),
                            SizedBox(
                              height: AppHeightManager.h2,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                AppTextWidget(
                                  text:
                                  "start date ${reservations[index].startDate
                                      ?.split("T")
                                      .first}",
                                  fontSize: FontSizeManager.fs15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColorManager.black,
                                ),
                                AppTextWidget(
                                  text:
                                  "start date ${reservations[index].endDate
                                      ?.split("T")
                                      .first}",
                                  fontSize: FontSizeManager.fs15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColorManager.black,
                                )
                              ],
                            ),
                            SizedBox(
                              height: AppHeightManager.h2,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  AppTextWidget(
                                    text: "remaining time  ",
                                    fontSize: FontSizeManager.fs16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColorManager.black,
                                  ),
                                  AppTextWidget(
                                    text:
                                    "${reservations[index].remainingTime}",
                                    fontSize: FontSizeManager.fs15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColorManager.mainColor,
                                  )
                                ]),
                          ]),
                        );
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
