import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/language/language_keys.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/routes/routes.dart';
import 'package:meter_app/routes/routes_name.dart';
import 'package:meter_app/utils/pref_util.dart';
 import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  PrefUtil.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, screenType) {
        return GetMaterialApp(
          // locale: const Locale('ar', 'AR'),
          locale: Get.locale,
          fallbackLocale: const Locale('en', 'US'),
          translations: LanguageKey(),
          debugShowCheckedModeBanner: false,
          title: 'Mater App',
          theme: ThemeData(
            primaryColor: AppColor.primaryColor,
            useMaterial3: false,
          ),
          initialRoute: RoutesName.splashScreen,
          getPages: Routes.routes,
          // home: const SplashScreen(),
          // home: const BottomNavMain(),
        );
      }
    );
  }
}
