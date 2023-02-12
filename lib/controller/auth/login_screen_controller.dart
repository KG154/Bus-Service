import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shuttleservice/module/model/auth/login_model.dart';
import 'package:shuttleservice/module/provider/auth/login_provider.dart';
import 'package:shuttleservice/services/internet_service.dart';
import 'package:shuttleservice/view/screen/home/site_managers_screen/site_manager_home_screen.dart';
import 'package:shuttleservice/view/screen/main_screen.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/loader.dart';
import 'package:shuttleservice/view/widget/toasts.dart';

import '../../view/utils/shared_preference.dart';

class LoginScreenController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailC = TextEditingController();
  TextEditingController phoneNoC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  bool showPassword = true;
  bool submitted = false;

  showPassClick() {
    showPassword = !showPassword;
    update();
  }

  // Models
  LogInEditUserModel? logInModel;

  userLogin() async {
    final hasInternet = await checkInternets();
    try {
      Loader.sw();
      Map<String, dynamic> data = Map<String, dynamic>();

      // data["email_id"] = emailC.text;
      data["user_phone"] = phoneNoC.text;
      data["user_password"] = passwordC.text;
      data["device_type"] = Utils.deviceType ?? "";
      data["device_token"] = Utils.deviceToken ?? "";

      logInModel = await LoginProvider().loginUser(data);
      if (logInModel != null) {
        if (logInModel?.status == true) {
          if (logInModel?.data != null) {
            Storage.saveUser(logInModel?.data);
            MyToasts().successToast(toast: logInModel?.message.toString());
            if (logInModel?.data?.userType == "admin") {
              Get.off(() => MainScreen());
            } else if (logInModel?.data?.userType == "sub_admin") {
              Get.off(() => MainScreen());
            } else if (logInModel?.data?.userType == "site_manager") {
              Get.off(() => SiteManagerHomeScreen());
            }
          }
        } else {
          if (hasInternet == true) {
            MyToasts().errorToast(toast: logInModel?.message.toString());
          }
        }
      }

      Loader.hd();
      update();
    } finally {
      Loader.hd();
    }
  }
}
