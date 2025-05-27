import 'package:car_rental_app/core/storage/shared/shared_pref.dart';
import 'package:car_rental_app/core/widget/button/main_app_button.dart';
import 'package:car_rental_app/feature/auth/models/auth_response_entity.dart';
import 'package:car_rental_app/feature/auth/screen/login_screen.dart';
import 'package:car_rental_app/feature/more/add_car_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/helper/hive_hepler.dart';
import '../../core/resource/color_manager.dart';
import '../../core/resource/font_manager.dart';
import '../../core/resource/icon_manager.dart';
import '../../core/resource/key_manger.dart';
import '../../core/resource/size_manager.dart';
import '../../core/widget/image/main_image_widget.dart';
import '../../core/widget/text/app_text_widget.dart';
import '../main/main_bottom_app_bar.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  AuthResponseEntity? entity;

  @override
  void initState() {
    entity = HiveHelper.getUser(
        boxKey: AppKeyManager.userBox, saveKey: AppKeyManager.userInfo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MainAppButton(
        onTap: () {
          AppSharedPreferences.clear();
          selectedIndex = 0;
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) {
                return LoginScreen();
              },
            ),
            (route) => false,
          );
        },
        outLinedBorde: true,
        borderColor: AppColorManager.black,
        alignment: Alignment.center,
        width: AppWidthManager.w90,
        height: AppHeightManager.h6,
        color: AppColorManager.black,
        child: AppTextWidget(
          text: "تسجبل الخروج",
          color: AppColorManager.black,
          fontSize: FontSizeManager.fs15,
          fontWeight: FontWeight.w600,
          overflow: TextOverflow.visible,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppWidthManager.w3Point8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppHeightManager.h8,
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

                Row(
                  children: [
                    AppTextWidget(
                      text: entity?.firstName ?? "",
                      fontSize: FontSizeManager.fs17,
                      color: AppColorManager.black,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      width: AppWidthManager.w1Point2,
                    ),
                    AppTextWidget(
                      text: entity?.lastName ?? "",
                      fontSize: FontSizeManager.fs17,
                      color: AppColorManager.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                SizedBox(
                  height: AppHeightManager.h1point8,
                ),
                Divider(
                  color: AppColorManager.lightGreyOpacity6,
                ),
                AppTextWidget(
                  text: entity?.email ?? "",
                  fontSize: FontSizeManager.fs16,
                  color: AppColorManager.black,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: AppHeightManager.h1point8,
                ),
                Divider(
                  color: AppColorManager.lightGreyOpacity6,
                ),
                SizedBox(
                  height: AppHeightManager.h1point8,
                ),
                AppTextWidget(
                  text: "رقم الهاتف الخاص بك : ${entity?.phone ?? ""}",
                  fontSize: FontSizeManager.fs16,
                  color: AppColorManager.black,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: AppHeightManager.h1point8,
                ),
                Divider(
                  color: AppColorManager.lightGreyOpacity6,
                ),
                SizedBox(
                  height: AppHeightManager.h1point8,
                ),
                AppTextWidget(
                  text: "الرقم الوطني الخاص بك : ${entity?.idNumber ?? ""}",
                  fontSize: FontSizeManager.fs16,
                  color: AppColorManager.black,
                  fontWeight: FontWeight.w600,
                ),



                SizedBox(
                  height: AppHeightManager.h3,
                ),




            Divider(color:
              AppColorManager.borderGrey,),


                SizedBox(
                  height: AppHeightManager.h3,
                ),


                Row(
                  children: [
                    Expanded(
                      child: MainAppButton(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return AddCarScreen();
                              },
                            ),
                          );
                        },
                        borderColor: AppColorManager.black,
                        alignment: Alignment.center,
                        width: AppWidthManager.w90,
                        height: AppHeightManager.h6,
                        color: AppColorManager.black,
                        child: AppTextWidget(
                          text: "رفع سيارة ",
                          color: AppColorManager.white,
                          fontSize: FontSizeManager.fs15,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                    SizedBox(width: AppWidthManager.w2,),
                    Expanded(
                      child: MainAppButton(
                        onTap: () {
                          AppSharedPreferences.clear();
                          selectedIndex = 0;
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) {
                                return LoginScreen();
                              },
                            ),
                                (route) => false,
                          );
                        },
                        borderColor: AppColorManager.black,
                        alignment: Alignment.center,
                        width: AppWidthManager.w90,
                        height: AppHeightManager.h6,
                        color: AppColorManager.black,
                        child: AppTextWidget(
                          text: "استعراض",
                          color: AppColorManager.white,
                          fontSize: FontSizeManager.fs15,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: AppHeightManager.h3,
                ),
                Divider(color:
                AppColorManager.borderGrey,),

                SizedBox(
                  height: AppHeightManager.h3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
