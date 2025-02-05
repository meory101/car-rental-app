import 'package:car_rental_app/feature/home/screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/resource/color_manager.dart';
import '../../core/resource/icon_manager.dart';
import '../../core/resource/size_manager.dart';
import '../../core/widget/text/app_text_widget.dart';
import '../more/more_screen.dart';

int selectedIndex = 0;

class MainBottomAppBar extends StatefulWidget {
  const MainBottomAppBar({super.key});

  @override
  State<MainBottomAppBar> createState() => _MainAppBottomAppBarState();
}

class _MainAppBottomAppBarState extends State<MainBottomAppBar> {
  late final List<Widget> bottomBarScreens;

  @override
  void initState() {
    bottomBarScreens = [
      HomeScreen(),
      MoreScreen(),
      MoreScreen(),
      MoreScreen(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColorManager.background,
        bottomNavigationBar: BottomAppBar(
          color: AppColorManager.background,

          height: AppHeightManager.h12,

          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              color: AppColorManager.black,
              borderRadius: BorderRadius.circular(AppRadiusManager.r30),
            ),
            padding: EdgeInsets.only(
              top: AppWidthManager.w3Point8,
              bottom: AppWidthManager.w1,
              left: AppWidthManager.w3,
              right: AppWidthManager.w3,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  overlayColor: const WidgetStatePropertyAll(
                      AppColorManager.transparent),
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(AppIconManager.home,
                          colorFilter: ColorFilter.mode(
                              selectedIndex == 0
                                  ? AppColorManager.mainColor
                                  : AppColorManager.white,
                              BlendMode.srcIn)),
                      AppTextWidget(
                        text: "home",
                        color: selectedIndex == 0
                            ? AppColorManager.mainColor
                            : AppColorManager.white,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  overlayColor: const WidgetStatePropertyAll(
                      AppColorManager.transparent),
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(AppIconManager.search,
                          colorFilter: ColorFilter.mode(
                              selectedIndex == 1
                                  ? AppColorManager.mainColor
                                  : AppColorManager.white,
                              BlendMode.srcIn)),
                      SizedBox(height: AppHeightManager.h05,),
                      AppTextWidget(
                        text: "Search",
                        color: selectedIndex == 1
                            ? AppColorManager.mainColor
                            : AppColorManager.white,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  overlayColor: const WidgetStatePropertyAll(
                      AppColorManager.transparent),
                  onTap: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(AppIconManager.key,
                          colorFilter: ColorFilter.mode(
                              selectedIndex == 2
                                  ? AppColorManager.mainColor
                                  : AppColorManager.white,
                              BlendMode.srcIn)),

                      AppTextWidget(
                        text: "Bookings",
                        color: selectedIndex == 2
                            ? AppColorManager.mainColor
                            : AppColorManager.white,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  overlayColor: const WidgetStatePropertyAll(
                      AppColorManager.transparent),
                  onTap: () {
                    setState(() {
                      selectedIndex = 3;
                    });
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(AppIconManager.person,
                          colorFilter: ColorFilter.mode(
                              selectedIndex == 3
                                  ? AppColorManager.mainColor
                                  : AppColorManager.white,
                              BlendMode.srcIn)),
                      AppTextWidget(
                        text: "profile",
                        color: selectedIndex == 3
                            ? AppColorManager.mainColor
                            : AppColorManager.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: bottomBarScreens[selectedIndex],
        ));

  }
}
