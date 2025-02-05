import 'dart:io';

import 'package:car_rental_app/core/helper/app_image_helper.dart';
import 'package:car_rental_app/core/resource/color_manager.dart';
import 'package:car_rental_app/core/resource/icon_manager.dart';
import 'package:car_rental_app/core/resource/size_manager.dart';
import 'package:car_rental_app/feature/main/main_bottom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/resource/font_manager.dart';
import '../../../core/widget/button/main_app_button.dart';
import '../../../core/widget/form_field/title_app_form_filed.dart';
import '../../../core/widget/image/main_image_widget.dart';
import '../../../core/widget/text/app_text_widget.dart';

class AdditionalInfoScreen extends StatefulWidget {
  const AdditionalInfoScreen({super.key});

  @override
  State<AdditionalInfoScreen> createState() => _AdditionalInfoScreenState();
}

class _AdditionalInfoScreenState extends State<AdditionalInfoScreen> {
  File? frontNationalId;
  File? backNationalId;
  File? driveLicense;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.background,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppWidthManager.w3Point8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppHeightManager.h4,
              ),
              AppTextWidget(
                text: "Additional Info.",
                color: AppColorManager.black,
                fontSize: FontSizeManager.fs18,
                fontWeight: FontWeight.w800,
                overflow: TextOverflow.visible,
              ),
              AppTextWidget(
                text:
                    "PLease Fill The Following Fields To Continue To Your Account..!",
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
                hint: "National Id Number",
                title: "National Id Number",
                onChanged: (value) {
                  return null;
                },
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Empty Field";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: AppHeightManager.h4,
              ),
              AppTextWidget(
                text: "National Id Image 1/2",
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
                      source: ImageSource.gallery);
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
                  text: "National Id (Front)",
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
                text: "National Id Image 2/2",
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
                      source: ImageSource.gallery);
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
                  text: "National Id (Back)",
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
                text: "Driver License",
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
                      source: ImageSource.gallery);
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
                  text: "Driver License",
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
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) {
                        return MainBottomAppBar();
                      },
                    ),
                    (route) => false,
                  );
                },
                alignment: Alignment.center,
                width: AppWidthManager.w90,
                height: AppHeightManager.h6,
                borderRadius: BorderRadius.circular(AppRadiusManager.r10),
                color: AppColorManager.black,
                child: AppTextWidget(
                  text: "Done",
                  color: AppColorManager.white,
                  fontSize: FontSizeManager.fs15,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
