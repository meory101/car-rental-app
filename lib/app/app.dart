import 'package:car_rental_app/core/storage/shared/shared_pref.dart';
import 'package:car_rental_app/feature/auth/screen/login_screen.dart';
import 'package:car_rental_app/feature/main/main_bottom_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final GlobalKey<NavigatorState> myAppKey = GlobalKey<NavigatorState>();

class CarRentalApp extends StatefulWidget {
  const CarRentalApp({super.key});

  @override
  State<CarRentalApp> createState() => _CarRentalAppState();
}

class _CarRentalAppState extends State<CarRentalApp> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        // theme: lightTheme(),
        navigatorKey: myAppKey,
        locale: context.locale,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        debugShowCheckedModeBanner: false,
        home: AppSharedPreferences.getToken().isEmpty
            ? LoginScreen()
            : MainBottomAppBar(),
        // onGenerateRoute: AppRouter.onGenerateRoute,
        // initialRoute: RouteNamedScreens.init,
      );
    });
  }
}
