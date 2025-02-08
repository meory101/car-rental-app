import 'package:car_rental_app/core/api/api_links.dart';
import 'package:car_rental_app/core/storage/shared/shared_pref.dart';
import 'package:car_rental_app/core/widget/container/shimmer_container.dart';
import 'package:car_rental_app/feature/auth/models/auth_response_entity.dart';
import 'package:car_rental_app/feature/auth/models/login_request_entity.dart';
import 'package:car_rental_app/feature/auth/screen/register_screen.dart';
import 'package:car_rental_app/feature/main/main_bottom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/api/api_methods.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/icon_manager.dart';
import '../../../core/resource/size_manager.dart';
import '../../../core/widget/button/main_app_button.dart';
import '../../../core/widget/form_field/title_app_form_filed.dart';
import '../../../core/widget/image/main_image_widget.dart';
import '../../../core/widget/text/app_text_widget.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> fkey = GlobalKey();
  LoginRequestEntity entity = LoginRequestEntity();
  int status = -1;

  void onSignUpClicked() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) {
        return RegisterScreen();
      },
    ));
  }

  void signInClicked() async {
    if (fkey.currentState?.validate() == false) return;
    setState(() {
      status = 0;
    });
    entity.username = username.text;
    entity.password = password.text;
    http.Response response =
        await HttpMethods().postMethod(ApiPostUrl.login, entity.toJson());
    AuthResponseEntity authResponseEntity;
    if (response.statusCode == 200) {
      setState(() {
        status = 1;
      });

      authResponseEntity = authResponseEntityFromJson(response.body);
      AppSharedPreferences.cashToken(token: authResponseEntity.access ?? "");
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
                      text: "Sign In.",
                      color: AppColorManager.black,
                      fontSize: FontSizeManager.fs20,
                      fontWeight: FontWeight.w800,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(
                      height: AppHeightManager.h05,
                    ),
                    AppTextWidget(
                      text: "Sign In To Your Registered Account.",
                      color: AppColorManager.black,
                      fontSize: FontSizeManager.fs16,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(
                      height: AppHeightManager.h1point8,
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
                      hint: "Username",
                      title: "Username",
                      onChanged: (value) {
                        username.text = value ?? "";
                        return null;
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'required';
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
                        password.text = value ?? "";
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: status == 0,
                          child: ShimmerContainer(
                            width: AppWidthManager.w30,
                            height: AppHeightManager.h5,
                          ),
                          replacement: MainAppButton(
                            onTap: signInClicked,
                            alignment: Alignment.center,
                            width: AppWidthManager.w30,
                            height: AppHeightManager.h5,
                            color: AppColorManager.black,
                            child: AppTextWidget(
                              text: "Sign In",
                              color: AppColorManager.white,
                              fontSize: FontSizeManager.fs15,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: AppWidthManager.w5,
                        ),
                        MainAppButton(
                          onTap: onSignUpClicked,
                          outLinedBorde: true,
                          borderColor: AppColorManager.black,
                          alignment: Alignment.center,
                          width: AppWidthManager.w30,
                          height: AppHeightManager.h5,
                          color: AppColorManager.white,
                          child: AppTextWidget(
                            text: "Sign Up",
                            color: AppColorManager.black,
                            fontSize: FontSizeManager.fs15,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
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
