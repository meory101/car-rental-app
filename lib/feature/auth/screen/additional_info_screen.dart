import 'dart:convert';
import 'dart:io';

import 'package:car_rental_app/core/helper/app_image_helper.dart';
import 'package:car_rental_app/core/resource/color_manager.dart';
import 'package:car_rental_app/core/resource/icon_manager.dart';
import 'package:car_rental_app/core/resource/size_manager.dart';
import 'package:car_rental_app/feature/auth/models/register_request_entity.dart';
import 'package:car_rental_app/feature/main/main_bottom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/api/api_links.dart';
import '../../../core/api/api_methods.dart';
import '../../../core/helper/hive_hepler.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/key_manger.dart';
import '../../../core/storage/shared/shared_pref.dart';
import '../../../core/widget/button/main_app_button.dart';
import '../../../core/widget/form_field/title_app_form_filed.dart';
import '../../../core/widget/image/main_image_widget.dart';
import '../../../core/widget/text/app_text_widget.dart';
import '../models/auth_response_entity.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;
class AdditionalInfoScreen extends StatefulWidget {
  final RegisterRequestEntity registerRequestEntity;
  const AdditionalInfoScreen({super.key,required this.registerRequestEntity});

  @override
  State<AdditionalInfoScreen> createState() => _AdditionalInfoScreenState();
}

class _AdditionalInfoScreenState extends State<AdditionalInfoScreen> {
  File? frontNationalId;
  File? backNationalId;
  File? driveLicense;
  final GlobalKey<FormState> fkey = GlobalKey();
  TextEditingController idNumber = TextEditingController();

  int status = -1;


  void onSignUpClicked() async {
    if (fkey.currentState?.validate() == false) return;
    setState(() {
      status = 0;
    });
    if(frontNationalId ==null || backNationalId ==null || driveLicense==null){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppTextWidget(
            text: "الرجاء إدخال المرفقات المطلوبة",
            color: AppColorManager.white,
            fontSize: FontSizeManager.fs14,
            fontWeight: FontWeight.w700,
            overflow: TextOverflow.visible,
          ),
        ),
      );return;
    }
    RegisterRequestEntity entity = widget.registerRequestEntity;
    entity.idNumber  = idNumber.text;
    http.Response response =
    await HttpMethods().postMethod(ApiPostUrl.register, entity.toJson());
    AuthResponseEntity authResponseEntity;
    print(utf8.decode(response.bodyBytes));
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201 ) {
      setState(() {
        status = 1;
      });

      if((response.body??"").isNotEmpty){
        authResponseEntity = authResponseEntityFromJson(response.body);
        AppSharedPreferences.cashToken(token: authResponseEntity.access ?? "");
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
        HiveHelper.saveUser(
            boxKey: AppKeyManager.userBox,
            saveKey: AppKeyManager.userInfo,
            entity: authResponseEntity);
      }
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
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
      backgroundColor: AppColorManager.background,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppWidthManager.w3Point8),
          child: Form(
            key: fkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppHeightManager.h4,
                ),
                AppTextWidget(
                  text: "معلومات إضافية",
                  color: AppColorManager.black,
                  fontSize: FontSizeManager.fs18,
                  fontWeight: FontWeight.w800,
                  overflow: TextOverflow.visible,
                ),
                AppTextWidget(
                  text: "يرجى ملء الحقول التالية للمتابعة إلى حسابك..!",
                  color: AppColorManager.textGrey,
                  fontSize: FontSizeManager.fs15,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.visible,
                ),
                SizedBox(
                  height: AppHeightManager.h4,
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
                SizedBox(
                  height: AppHeightManager.h2,
                ),
                TitleAppFormFiled(
                  textInputType: TextInputType.number,
                  controller: idNumber,
                  hint: "رقم الهوية الوطنية",
                  title: "رقم الهوية الوطنية",
                  onChanged: (value) {

                    return null;
                  },
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "حقل فارغ";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: AppHeightManager.h4,
                ),
                AppTextWidget(
                  text: "صورة الهوية الوطنية 1/2",
                  color: AppColorManager.textAppColor,
                  fontSize: FontSizeManager.fs16,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.visible,
                ),
                SizedBox(
                  height: AppHeightManager.h1point8,
                ),
                MainAppButton(
                  onTap: () async {
                    if (frontNationalId != null) return;
                    frontNationalId = await AppImageHelper.pickImageFrom(
                        source: ImageSource.camera);
                    setState(() {});
                  },
                  outLinedBorde: frontNationalId == null ? true : false,
                  borderColor: AppColorManager.black,
                  alignment: Alignment.center,
                  width: AppWidthManager.w90,
                  height: AppHeightManager.h6,
                  borderRadius: BorderRadius.circular(AppRadiusManager.r10),
                  color: AppColorManager.lightGreyOpacity6,
                  child: AppTextWidget(
                                  text: "صورة الهوية الوطنية (الوجه الامامي)",

                    color: frontNationalId == null
                        ? AppColorManager.black
                        : AppColorManager.textGrey,
                    fontSize: FontSizeManager.fs15,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.visible,
                  ),
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
                  text: "صورة الهوية الوطنية 2/2",
                  color: AppColorManager.textAppColor,
                  fontSize: FontSizeManager.fs16,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.visible,
                ),
                SizedBox(
                  height: AppHeightManager.h1point8,
                ),
                MainAppButton(
                  onTap: () async {
                    if (backNationalId != null) return;

                    backNationalId = await AppImageHelper.pickImageFrom(
                        source: ImageSource.camera);
                    setState(() {});
                  },
                  outLinedBorde: backNationalId == null ? true : false,
                  borderColor: AppColorManager.black,
                  alignment: Alignment.center,
                  width: AppWidthManager.w90,
                  height: AppHeightManager.h6,
                  borderRadius: BorderRadius.circular(AppRadiusManager.r10),
                  color: AppColorManager.lightGreyOpacity6,
                  child: AppTextWidget(
                    text: "صورة الهوية الوطنية (الوجه الخلفي)",
                    color: backNationalId == null
                        ? AppColorManager.black
                        : AppColorManager.textGrey,
                    fontSize: FontSizeManager.fs15,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.visible,
                  ),
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
                  text: "شهادة القيادة",
                  color: AppColorManager.textAppColor,
                  fontSize: FontSizeManager.fs16,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.visible,
                ),
                SizedBox(
                  height: AppHeightManager.h1point8,
                ),
                MainAppButton(
                  onTap: () async {
                    driveLicense = await AppImageHelper.pickImageFrom(
                        source: ImageSource.camera);
                    setState(() {});
                  },
                  outLinedBorde: driveLicense == null ? true : false,
                  borderColor: AppColorManager.black,
                  alignment: Alignment.center,
                  width: AppWidthManager.w90,
                  height: AppHeightManager.h6,
                  borderRadius: BorderRadius.circular(AppRadiusManager.r10),
                  color:  AppColorManager.lightGreyOpacity6,
                  child: AppTextWidget(
                    text: "شهادة القيادة",
                    color: driveLicense == null
                        ? AppColorManager.black
                        : AppColorManager.textGrey,
                    fontSize: FontSizeManager.fs15,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.visible,
                  ),
                ),
                SizedBox(
                  height: AppHeightManager.h4,
                ),
                MainAppButton(
                  onTap: onSignUpClicked,
                  alignment: Alignment.center,
                  width: AppWidthManager.w90,
                  height: AppHeightManager.h6,
                  borderRadius: BorderRadius.circular(AppRadiusManager.r10),
                  color: AppColorManager.black,
                  child: AppTextWidget(
                    text: "المتابعة",
                    color: AppColorManager.white,
                    fontSize: FontSizeManager.fs15,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
