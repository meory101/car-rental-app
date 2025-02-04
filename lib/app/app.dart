import 'package:car_rental_app/feature/main/main_bottom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarRentalApp extends StatefulWidget {
  const CarRentalApp({super.key});

  @override
  State<CarRentalApp> createState() => _CarRentalAppState();
}

class _CarRentalAppState extends State<CarRentalApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: MainBottomAppBar(),
    );
  }
}
