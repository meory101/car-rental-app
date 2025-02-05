import 'package:car_rental_app/core/storage/shared/shared_pref.dart';
import 'package:car_rental_app/core/widget/button/main_app_button.dart';
import 'package:car_rental_app/feature/auth/screen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/resource/color_manager.dart';
import '../../core/resource/font_manager.dart';
import '../../core/resource/size_manager.dart';
import '../../core/widget/text/app_text_widget.dart';
import '../main/main_bottom_app_bar.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          text: "Logout",
          color: AppColorManager.black,
          fontSize: FontSizeManager.fs15,
          fontWeight: FontWeight.w600,
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }
}
