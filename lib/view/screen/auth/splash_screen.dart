import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shuttleservice/controller/auth/splash_screen_controller.dart';
import 'package:shuttleservice/module/model/auth/login_model.dart';
import 'package:shuttleservice/view/screen/auth/login_screen.dart';
import 'package:shuttleservice/view/screen/home/site_managers_screen/site_manager_home_screen.dart';
import 'package:shuttleservice/view/screen/main_screen.dart';
import 'package:shuttleservice/view/utils/assets.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/shared_preference.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height - padding.top - kToolbarHeight;
    print("width ==${width}");
    print("height ==${height}");
    return GetBuilder<SplashScreenController>(
      init: SplashScreenController(),
      initState: (splashController) async {
        // await splashController.controller?.checkAppVersion();
        // await splashController.controller?.checkAppVersion();

        ///check if user login so move userList page either login page
      },
      builder: (splashController) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              height: double.infinity,
              width: width,
              child: Image.asset(
                Ast.splash_screen,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
