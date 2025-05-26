import 'dart:convert';

import 'package:car_rental_app/core/api/api_links.dart';
import 'package:car_rental_app/core/widget/bottom_sheet/wheel_date_picker.dart';
import 'package:car_rental_app/core/widget/container/shimmer_container.dart';
import 'package:car_rental_app/core/widget/image/main_image_widget.dart';
import 'package:car_rental_app/core/widget/snack_bar/note_message.dart';
import 'package:car_rental_app/feature/home/models/reserve_car_request_entity.dart';
import 'package:car_rental_app/feature/main/main_bottom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/resource/size_manager.dart';
import '../../../core/api/api_methods.dart';
import '../../../core/helper/lanucher_helper.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/widget/button/main_app_button.dart';
import '../../../core/widget/text/app_text_widget.dart';
import '../../../core/widget/text/price_text_widget.dart';
import '../models/car_list_response_entity.dart';
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
  var offices = [];
  var customers = [];
  var office;

  var customer;

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
            text: utf8.decode(response.bodyBytes),
            color: AppColorManager.white,
            fontSize: FontSizeManager.fs14,
            fontWeight: FontWeight.w700,
            overflow: TextOverflow.visible,
          ),
        ),
      );
    }
  }

  void getOffices() async {
    http.Response response =
        await HttpMethods().getMethod(ApiGetUrl.listOffices, {});

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Properly decode body for Arabic characters
      final decodedBody = utf8.decode(response.bodyBytes);
      offices = jsonDecode(decodedBody);

      if (offices is List) {
        offices.forEach((element) {
          print(element['name'].toString()); // Arabic name
          print(widget.car.ownerOffice.toString()); // Your car's office name
          print(
              element['name'].toString() == widget.car.ownerOffice.toString());
          print('ddddddddddddddddd');
          if (element['name'].toString() == widget.car.ownerOffice.toString()) {
            setState(() {
              office = element;
            });
            print(office.toString() +
                " dddddddddddddddddddddddddddddddddddddd000");
          }
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppTextWidget(
            text: utf8.decode(response.bodyBytes),
            // Decode error messages too
            color: AppColorManager.white,
            fontSize: FontSizeManager.fs14,
            fontWeight: FontWeight.w700,
            overflow: TextOverflow.visible,
          ),
        ),
      );
    }
  }

  void getCustomers() async {
    http.Response response =
        await HttpMethods().getMethod(ApiGetUrl.customers, {});
    if (response.statusCode == 200 || response.statusCode == 201) {
      customers = jsonDecode(response.body);

      if (customers is List) {
        customers.forEach(
          (element) {
            print('pppppppppppppppp');
            print((element['first_name']+"-"+element['last_name']));
            print(widget.car.ownerCustomer);
            print('pppppppppppppppp');
            if ((element['first_name']+"-"+element['last_name']).toString() == widget.car.ownerCustomer.toString()) {
              customer = element;
              print(customer);
              print('00000000000000000000000000000000000000');
              setState(() {

              });
            }
          },
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppTextWidget(
            text: utf8.decode(response.bodyBytes),
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
  void initState() {
    getCustomers();
    getOffices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.car.idCar);
    print('car iddddddddddddddddddddd');
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
                    text: entity.startDate ?? "اختر تاريخ",
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
                                      if (widget.car.isAvailableDaily ==
                                          false) {
                                        return;
                                      }

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
                                        text: "يوم (1 day)",
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
                                          false) {
                                        return;
                                      }
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
                                        text: "شهر (30 Days)",
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
                                      print(widget.car.isAvailableYearly);
                                      print('yeaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
                                      if (widget.car.isAvailableYearly ==
                                          false) {
                                        return;
                                      }

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
                                        text: "سنة (365 Days)",
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
                                      text: "المتابعة",
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
                        text: "الاجار",
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
                            text: "اختر نوع الاجار والتاريخ",
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
                    text: "حجز",
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
          SizedBox(
            height: AppHeightManager.h2,
          ),
          Visibility(
            visible: status == 0,
            child: ShimmerContainer(
              height: AppHeightManager.h7,
              width: AppWidthManager.w60,
            ),
            replacement: MainAppButton(
              onTap: () {
                entity.typeReservation = 4.toString();
                entity.startDate = entity.startDate.toString() == "null"
                    ? DateTime.now().toString()
                    : entity.startDate;
                reserveCar();
              },
              padding:
                  EdgeInsets.symmetric(horizontal: AppWidthManager.w3Point8),
              alignment: Alignment.center,
              color: AppColorManager.black,
              outLinedBorde: true,
              borderRadius: BorderRadius.circular(AppRadiusManager.r15),
              borderColor: AppColorManager.mainColor,
              height: AppHeightManager.h7,
              width: AppWidthManager.w90,
              child: AppTextWidget(
                text: "شراء",
                fontSize: FontSizeManager.fs15,
                color: AppColorManager.mainColor,
                fontWeight: FontWeight.w700,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
          ),
          SizedBox(
            height: AppHeightManager.h2,
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
                                ? "يوم ${widget.car.dailyRentPrice}"
                                : selectedPlan == 1
                                    ? "شهر ${widget.car.monthlyRentPrice}"
                                    : selectedPlan == 2
                                        ? "سنة ${widget.car.yearlyRentPrice}"
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
                  office == null
                      ? Center()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                              text: "معلومات المكتب",
                              fontSize: FontSizeManager.fs16,
                              fontWeight: FontWeight.w800,
                              color: AppColorManager.mainColor,
                            ),
                            SizedBox(
                              height: AppHeightManager.h2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        height: AppHeightManager.h8,
                                        width: AppHeightManager.h8,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle),
                                        child: MainImageWidget(
                                          imageUrl: office['image'],
                                        )),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: AppHeightManager.h2,
                                        ),
                                        AppTextWidget(
                                          text: "اسم المكتب" +
                                              " :  " +
                                              office['name'],
                                          fontSize: FontSizeManager.fs15,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        SizedBox(
                                          height: AppHeightManager.h08,
                                        ),
                                        AppTextWidget(
                                          text: "موقع المكتب" +
                                              " :  " +
                                              office['location'],
                                          fontSize: FontSizeManager.fs15,
                                          fontWeight: FontWeight.w600,
                                          color: AppColorManager.textAppColor,
                                        ),
                                        SizedBox(
                                          height: AppHeightManager.h2,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        UrlLauncherHelper.makeCall(
                                            phoneNumber:
                                                office['phone_number_1']);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: AppColorManager.red,
                                        child: Icon(
                                          Icons.call,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: AppWidthManager.w1Point8,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        UrlLauncherHelper.makeCall(
                                            phoneNumber:
                                                office['phone_number_2']);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        child: Icon(
                                          Icons.mail,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: AppHeightManager.h2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  children: List.generate(
                                    office['ratings'].toInt(),
                                    (index) {
                                      return Icon(
                                        Icons.star,
                                        color: AppColorManager.orange,
                                        size: 15,
                                      );
                                    },
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                  SizedBox(
                    height: AppHeightManager.h2,
                  ),
                  customer == null
                      ? Center()
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextWidget(
                        text: "معلومات صاحب السيارة",
                        fontSize: FontSizeManager.fs16,
                        fontWeight: FontWeight.w800,
                        color: AppColorManager.mainColor,
                      ),
                      SizedBox(
                        height: AppHeightManager.h2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: AppHeightManager.h2,
                                  ),
                                  AppTextWidget(
                                    text: "اسم الناشر" +
                                        " :  " +
                                        customer['first_name']+" "+ customer['last_name'],
                                    fontSize: FontSizeManager.fs15,
                                    fontWeight: FontWeight.w700,
                                    maxLines: 2,
                                  ),
                                  SizedBox(
                                    height: AppHeightManager.h2,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  UrlLauncherHelper.makeCall(
                                      phoneNumber:
                                      customer['phone']);
                                },
                                child: CircleAvatar(
                                  backgroundColor: AppColorManager.red,
                                  child: Icon(
                                    Icons.call,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: AppWidthManager.w1Point8,
                              ),
                              InkWell(
                                onTap: () {
                                  UrlLauncherHelper.makeCall(
                                      phoneNumber:
                                      customer['phone']);
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: Icon(
                                    Icons.mail,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: AppHeightManager.h2,
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
                    height: AppHeightManager.h30,
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
