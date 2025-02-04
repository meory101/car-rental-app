import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/resource/color_manager.dart';
import '../../core/resource/icon_manager.dart';
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
      MoreScreen(),
      MoreScreen(),
      MoreScreen(),
      MoreScreen(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColorManager.white,
        bottomNavigationBar: BottomAppBar(
          color: AppColorManager.white,
          height: 100,
          elevation: 0,
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 5,horizontal: 16),
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 16),
            decoration: BoxDecoration(
                color: AppColorManager.black,
                borderRadius: BorderRadius.circular(25)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  overlayColor:
                      const WidgetStatePropertyAll(AppColorManager.transparent),
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppIconManager.home,
                          colorFilter: ColorFilter.mode(
                              selectedIndex == 0
                                  ? AppColorManager.white
                                  : AppColorManager.grey,
                              BlendMode.srcIn)),
                      AppTextWidget(
                        text: "home",
                        color: selectedIndex == 0
                            ? AppColorManager.white
                            : AppColorManager.grey,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  overlayColor:
                      const WidgetStatePropertyAll(AppColorManager.transparent),
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppIconManager.home,
                          colorFilter: ColorFilter.mode(
                              selectedIndex == 1
                                  ? AppColorManager.white
                                  : AppColorManager.grey,
                              BlendMode.srcIn)),
                      AppTextWidget(
                        text: "bidding",
                        color: selectedIndex == 1
                            ? AppColorManager.white
                            : AppColorManager.grey,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  overlayColor:
                      const WidgetStatePropertyAll(AppColorManager.transparent),
                  onTap: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppIconManager.person,
                          colorFilter: ColorFilter.mode(
                              selectedIndex == 2
                                  ? AppColorManager.white
                                  : AppColorManager.grey,
                              BlendMode.srcIn)),
                      AppTextWidget(
                        text: "profile",
                        color: selectedIndex == 2
                            ? AppColorManager.white
                            : AppColorManager.grey,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  overlayColor:
                      const WidgetStatePropertyAll(AppColorManager.transparent),
                  onTap: () {
                    setState(() {
                      selectedIndex = 3;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppIconManager.more,
                          colorFilter: ColorFilter.mode(
                              selectedIndex == 3
                                  ? AppColorManager.white
                                  : AppColorManager.grey,
                              BlendMode.srcIn)),
                      AppTextWidget(
                        text: "more",
                        color: selectedIndex == 3
                            ? AppColorManager.white
                            : AppColorManager.grey,
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
