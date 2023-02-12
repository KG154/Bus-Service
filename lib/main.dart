import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shuttleservice/module/routes/app_pages.dart';
import 'package:shuttleservice/module/routes/app_routes.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/screen/auth/splash_screen.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/miui10_anim.dart';
import 'package:shuttleservice/view/utils/theme.dart';

SharedPreferences? loginPreferences;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FlutterDownloader.initialize(debug: true, ignoreSsl: true);

  Utils.deviceToken = await FirebaseMessaging.instance.getToken();
  Utils.deviceType = await Platform.isIOS ? "ios" : "android";
  loginPreferences = await SharedPreferences.getInstance();
  log(Utils.deviceType.toString(), name: "DeviceType");
  log(Utils.deviceToken.toString(), name: "DeviceToken");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return GlobalLoaderOverlay(
            overlayColor: Colors.black,
            child: GetMaterialApp(
              title: "shuttle Service",
              routes: {
                Routes.SPLASH: (context) => SplashScreen(),
              },
              theme: theme(),
              navigatorKey: navigatorKey,
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
              defaultTransition: Transition.native,
            ),
          );
        },
      ),
      animationBuilder: const Miui10AnimBuilder(),
      animationDuration: const Duration(milliseconds: 200),
      duration: const Duration(seconds: 3),
    );
  }
}
