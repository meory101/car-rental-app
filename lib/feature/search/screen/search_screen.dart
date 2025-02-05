
import 'package:car_rental_app/core/resource/size_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/resource/icon_manager.dart';
import '../../../core/widget/form_field/app_form_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(AppWidthManager.w3Point8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextFormField(
                borderRadius: AppRadiusManager.r10,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: AppWidthManager.w4,
                  ),
                  child: SvgPicture.asset(
                    AppIconManager.search,
                  ),
                ),
                hintText: "search",
              )
            ],
          ),
        ),
      ),
    );
  }
}
