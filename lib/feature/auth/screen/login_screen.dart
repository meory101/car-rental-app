import 'package:car_rental_app/feature/auth/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/icon_manager.dart';
import '../../../core/resource/size_manager.dart';
import '../../../core/widget/button/main_app_button.dart';
import '../../../core/widget/form_field/title_app_form_filed.dart';
import '../../../core/widget/image/main_image_widget.dart';
import '../../../core/widget/text/app_text_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> fkey = GlobalKey();

  void onSignUpClicked() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) {
        return RegisterScreen();
      },
    ));
  }

  void SignInClicked() async {}

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
                height:AppHeightManager.h20,
                width:AppWidthManager.w100,
                child: MainImageWidget(
                  fit: BoxFit.cover,
                  height:AppHeightManager.h20,
                  width:AppWidthManager.w50,
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
                      hint: "Email Address",
                      title: "Email Address",
                      onChanged: (value) {
                        email.text = value ?? "";
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
                        return null;
                      },
                    ),
                    SizedBox(
                      height: AppHeightManager.h8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MainAppButton(
                          onTap: SignInClicked,
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
                        )
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
