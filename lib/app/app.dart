import 'package:car_rental_app/feature/auth/screen/register_screen.dart';
import 'package:car_rental_app/feature/main/main_bottom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CarRentalApp extends StatefulWidget {
  const CarRentalApp({super.key});

  @override
  State<CarRentalApp> createState() => _CarRentalAppState();
}

class _CarRentalAppState extends State<CarRentalApp> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
     return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RegisterScreen(),
      );
    });
  }
}
