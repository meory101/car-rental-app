import 'package:car_rental_app/feature/main/main_bottom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/resource/color_manager.dart';
import '../../../../core/resource/font_manager.dart';
import '../../../../core/resource/icon_manager.dart';
import '../../../../core/resource/size_manager.dart';
import '../../../../core/widget/button/main_app_button.dart';
import '../../../../core/widget/form_field/app_form_field.dart';
import '../../../../core/widget/text/app_text_widget.dart';
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppTextWidget(
              text: "ماالذي تبحث عنه اليوم؟",
              fontSize: FontSizeManager.fs18,
              fontWeight: FontWeight.w600,
              color: AppColorManager.black,
            ),
            SvgPicture.asset(
              AppIconManager.key,
              colorFilter:
              ColorFilter.mode(AppColorManager.black, BlendMode.srcIn),
            )
          ],
        ),
        AppTextWidget(
          text: "",
          fontSize: FontSizeManager.fs18,
          fontWeight: FontWeight.w600,
          color: AppColorManager.black,
        ),
        SizedBox(
          height: AppHeightManager.h2point5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: AppTextFormField(
                readOnly: true,
                onTap: () {
                  selectedIndex=1;
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                      return MainBottomAppBar();
                    },), (route) => false,);
                },
                borderRadius: AppRadiusManager.r10,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: AppWidthManager.w4,
                  ),
                  child: SvgPicture.asset(
                    AppIconManager.search,
                  ),
                ),
                hintText: "بحث",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
