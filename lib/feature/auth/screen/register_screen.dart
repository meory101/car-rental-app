import 'package:car_rental_app/core/resource/icon_manager.dart';
import 'package:car_rental_app/core/resource/validation_helper.dart';
import 'package:car_rental_app/core/widget/container/decorated_container.dart';
import 'package:car_rental_app/core/widget/image/main_image_widget.dart';
import 'package:car_rental_app/feature/auth/models/register_request_entity.dart';
import 'package:car_rental_app/feature/auth/screen/additional_info_screen.dart';
import 'package:car_rental_app/feature/auth/screen/login_screen.dart';
import 'package:car_rental_app/feature/main/main_bottom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/api/api_links.dart';
import '../../../core/api/api_methods.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/size_manager.dart';
import '../../../core/storage/shared/shared_pref.dart';
import '../../../core/widget/button/main_app_button.dart';
import '../../../core/widget/form_field/title_app_form_filed.dart';
import '../../../core/widget/text/app_text_widget.dart';
import 'package:http/http.dart' as http;

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

  void onSignUpClicked() async {
    if (fkey.currentState?.validate() == false) return;
    setState(() {
      status = 0;
    });
    http.Response response =
    await HttpMethods().postMethod(ApiPostUrl.user, registerRequestEntity.toJson());
    AuthResponseEntity authResponseEntity;
    if (response.statusCode == 200) {
      setState(() {
        status = 1;
      });

      if((response.body??"").isNotEmpty){
        authResponseEntity = authResponseEntityFromJson(response.body);
        AppSharedPreferences.cashToken(token: authResponseEntity.access ?? "");
      }
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) {
            return AdditionalInfoScreen();
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
            text: response.body.toString(),
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
      bottomSheet: Container(
        height: AppHeightManager.h10,
        color: AppColorManager.background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MainAppButton(
              onTap: onSignUpClicked,
              alignment: Alignment.center,
              width: AppWidthManager.w30,
              height: AppHeightManager.h5,
              color: AppColorManager.black,
              child: AppTextWidget(
                text: "Sign Up",
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
                text: "Sign In",
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
                      text: "Create An Account.",
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
                      hint: "First Name",
                      title: "First Name",
                      onChanged: (value) {
                        registerRequestEntity.firstName = value??"";
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
                      height: AppHeightManager.h1point8,
                    ),
                    TitleAppFormFiled(
                      hint: "Last Name",
                      title: "Last Name",
                      onChanged: (value) {
                        registerRequestEntity.lastName = value??"";

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
                      height: AppHeightManager.h1point8,
                    ),
                    TitleAppFormFiled(
                      hint: "Username",
                      title: "Username",
                      onChanged: (value) {
                        registerRequestEntity.username = value??"";

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
                      height: AppHeightManager.h1point8,
                    ),
                    TitleAppFormFiled(
                      hint: "Email Address",
                      title: "Email Address",
                      onChanged: (value) {
                        registerRequestEntity.email = value??"";
                        return null;
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Empty Field";
                        }
                        if (!(value?.isEmail() ?? false)) {
                          return "Invalid Email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: AppHeightManager.h1point8,
                    ),
                    TitleAppFormFiled(
                      hint: "Phone Number",
                      title: "Phone Number",
                      onChanged: (value) {
                        registerRequestEntity.phone = value??"";
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
                      height: AppHeightManager.h1point8,
                    ),
                    TitleAppFormFiled(
                      hint: "Password",
                      title: "Password",
                      onChanged: (value) {
                        registerRequestEntity.password = value??"";
                        return null;
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'required';
                        }
                        if ((value?.length ?? 0) < 4) {
                          return "At Least 4 ";
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
