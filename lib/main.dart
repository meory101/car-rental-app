import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app.dart';
import 'core/resource/color_manager.dart';
import 'core/storage/shared/shared_pref.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences shPref = await SharedPreferences.getInstance();
  AppSharedPreferences.init(shPref);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColorManager.white));
  runApp(

    CarRentalApp(),

  );
}
