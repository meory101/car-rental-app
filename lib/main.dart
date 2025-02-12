import 'package:car_rental_app/app/app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/helper/hive_hepler.dart';
import 'core/resource/key_manger.dart';
import 'core/storage/shared/shared_pref.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();


  SharedPreferences shPref = await SharedPreferences.getInstance();
  AppSharedPreferences.init(shPref);
  await HiveHelper.init();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        //Ar Local
        Locale(
          AppKeyManager.arabicLocalizationCode,
        ),
        //En Local
        Locale(
          AppKeyManager.englishLocalizationCode,
        ),

      ],
      path:  'assets/translations',
      fallbackLocale: const Locale(
        AppKeyManager.arabicLocalizationCode,
      ),
      startLocale: Locale(AppSharedPreferences.getLanguage()),
      child: const CarRentalApp(),
    ),
  );
}



