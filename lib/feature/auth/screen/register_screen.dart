import 'package:car_rental_app/core/resource/icon_manager.dart';
import 'package:car_rental_app/core/resource/validation_helper.dart';
import 'package:car_rental_app/core/widget/container/decorated_container.dart';
import 'package:car_rental_app/core/widget/image/main_image_widget.dart';
import 'package:car_rental_app/feature/auth/screen/login_screen.dart';
import 'package:car_rental_app/feature/main/main_bottom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/size_manager.dart';
import '../../../core/widget/button/main_app_button.dart';
import '../../../core/widget/form_field/title_app_form_filed.dart';
import '../../../core/widget/text/app_text_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> fkey = GlobalKey();

  void onSignInClicked() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) {
        return LoginScreen();
      },
    ));
  }

  void onSignUpClicked() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) {
        return MainBottomAppBar();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.background,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
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
                        name.text = value ?? "";
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
                        name.text = value ?? "";
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
                        email.text = value ?? "";
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
                      hint: "Password",
                      title: "Password",
                      onChanged: (value) {
                        password.text = value ?? "";
                        return null;
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Empty Field";
                        }
                        if ((value?.length ?? 0) < 6) {
                          return "Invalid Password";
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
