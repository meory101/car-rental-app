import 'package:car_rental_app/core/resource/icon_manager.dart';
import 'package:car_rental_app/core/resource/validation_helper.dart';
import 'package:car_rental_app/core/widget/container/decorated_container.dart';
import 'package:car_rental_app/core/widget/image/main_image_widget.dart';
import 'package:car_rental_app/feature/auth/models/register_request_entity.dart';
import 'package:car_rental_app/feature/auth/screen/additional_info_screen.dart';
import 'package:car_rental_app/feature/auth/screen/login_screen.dart';
import 'package:flutter/material.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/size_manager.dart';
import '../../../core/widget/button/main_app_button.dart';
import '../../../core/widget/form_field/title_app_form_filed.dart';
import '../../../core/widget/text/app_text_widget.dart';

import '../models/auth_response_entity.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final GlobalKey<FormState> fkey = GlobalKey();
  RegisterRequestEntity registerRequestEntity = RegisterRequestEntity();
  int status = -1;

  void onSignInClicked() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) {
        return LoginScreen();
      },
    ));
  }

  void onNextClicked() async {
    if (fkey.currentState?.validate() == false) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) {
          return AdditionalInfoScreen(
            registerRequestEntity: registerRequestEntity,
          );
        },
      ),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.background,
      bottomSheet: Container(
        height: AppHeightManager.h10,
        color: AppColorManager.background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MainAppButton(
              onTap: onNextClicked,
              alignment: Alignment.center,
              width: AppWidthManager.w30,
              height: AppHeightManager.h5,
              color: AppColorManager.black,
              child: AppTextWidget(
                text: "التالي",
                color: AppColorManager.white,
                fontSize: FontSizeManager.fs15,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.visible,
              ),
            ),
            SizedBox(
              width: AppWidthManager.w5,
            ),
            MainAppButton(
              onTap: onSignInClicked,
              outLinedBorde: true,
              borderColor: AppColorManager.black,
              alignment: Alignment.center,
              width: AppWidthManager.w30,
              height: AppHeightManager.h5,
              color: AppColorManager.white,
              child: AppTextWidget(
                text: "تسجيل الدخول",
                color: AppColorManager.black,
                fontSize: FontSizeManager.fs15,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.visible,
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: fkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: AppHeightManager.h10),
                height: AppHeightManager.h20,
                width: AppWidthManager.w100,
                child: MainImageWidget(
                  fit: BoxFit.cover,
                  height: AppHeightManager.h20,
                  width: AppWidthManager.w50,
                  imagePath: AppImageManager.carKey,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: AppHeightManager.h4,
                    ),
                    AppTextWidget(
                      text: "إنشاء حساب.",
                      color: AppColorManager.black,
                      fontSize: FontSizeManager.fs18,
                      fontWeight: FontWeight.w800,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(
                      height: AppHeightManager.h1,
                    ),
                    Container(
                      width: AppWidthManager.w20,
                      color: AppColorManager.black,
                      height: AppHeightManager.h05,
                    ),
                    SizedBox(
                      height: AppHeightManager.h5,
                    ),
                    TitleAppFormFiled(
                      hint: "الاسم الأول",
                      title: "الاسم الأول",
                      onChanged: (value) {
                        registerRequestEntity.firstName = value??"";
                        return null;
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "الحقل فارغ";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: AppHeightManager.h1point8,
                    ),
                    TitleAppFormFiled(
                      hint: "الاسم الأخير",
                      title: "الاسم الأخير",
                      onChanged: (value) {
                        registerRequestEntity.lastName = value??"";
                        return null;
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "الحقل فارغ";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: AppHeightManager.h1point8,
                    ),
                    TitleAppFormFiled(
                      hint: "اسم المستخدم",
                      title: "اسم المستخدم",
                      onChanged: (value) {
                        registerRequestEntity.username = value??"";
                        return null;
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "الحقل فارغ";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: AppHeightManager.h1point8,
                    ),
                    TitleAppFormFiled(
                      hint: "البريد الإلكتروني",
                      title: "البريد الإلكتروني",
                      onChanged: (value) {
                        registerRequestEntity.email = value??"";
                        return null;
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "الحقل فارغ";
                        }
                        if (!(value?.isEmail() ?? false)) {
                          return "بريد إلكتروني غير صالح";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: AppHeightManager.h1point8,
                    ),
                    TitleAppFormFiled(
                      hint: "رقم الهاتف",
                      title: "رقم الهاتف",
                      onChanged: (value) {
                        registerRequestEntity.phone = value??"";
                        return null;
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "الحقل فارغ";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: AppHeightManager.h1point8,
                    ),
                    TitleAppFormFiled(
                      hint: "كلمة المرور",
                      title: "كلمة المرور",
                      onChanged: (value) {
                        registerRequestEntity.password = value??"";
                        return null;
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'مطلوب';
                        }
                        if ((value?.length ?? 0) < 4) {
                          return "على الأقل 4 أحرف";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: AppHeightManager.h8,
                    ),
                    SizedBox(
                      height: AppHeightManager.h10,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}