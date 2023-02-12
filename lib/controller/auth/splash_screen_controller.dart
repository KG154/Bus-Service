import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shuttleservice/module/model/auth/check_app_version_model.dart';
import 'package:shuttleservice/module/model/auth/login_model.dart';
import 'package:shuttleservice/module/provider/auth/app_version_provider.dart';
import 'package:shuttleservice/module/provider/auth/login_provider.dart';
import 'package:shuttleservice/services/internet_service.dart';
import 'package:shuttleservice/view/screen/auth/login_screen.dart';
import 'package:shuttleservice/view/screen/home/site_managers_screen/site_manager_home_screen.dart';
import 'package:shuttleservice/view/screen/main_screen.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/loader.dart';
import 'package:shuttleservice/view/utils/shared_preference.dart';
import 'package:shuttleservice/view/widget/toasts.dart';

class SplashScreenController extends GetxController {
  CheckAppVersionModel? checkAppVersionModel;

  @override
  Future<void> onInit() async {
    await checkAppVersion();
    LoginUserData? userModel = await Storage.getUser();
    update();
    Future.delayed(Duration(milliseconds: 100), () async {
      if (userModel != null) {
        await loginUserDetails(userModel);
        update();
        /*if (userModel.userType == "admin") {
              Get.off(() => MainScreen());
            } else if (userModel.userType == "sub_admin") {
              Get.off(() => MainScreen());
            } else if (userModel.userType == "site_manager") {
              Get.off(() => SiteManagerHomeScreen());
            }*/
      } else {
        Get.off(() => LoginScreen());
      }
    });
    super.onInit();
  }

  checkAppVersion() async {
    final hasInternet = await checkInternets();
    try {
      final prefs = await SharedPreferences.getInstance();
      log(Utils.deviceType.toString(), name: "deviceType");

      Map<String, dynamic> data = Map<String, dynamic>();
      data["application_version"] = "version_1_0_2";
      data["device_type"] = Utils.deviceType;
      if (Utils.userID != null) {
        data["user_id"] = Utils.userID;
      }

      checkAppVersionModel = await CheckAppVersionProvider().checkAppVersion(data);

      if (checkAppVersionModel != null) {
        Utils.applicationUpdate = checkAppVersionModel!.isApplicationUpdate.toString();
        Utils.baseUrl = checkAppVersionModel!.baseUrl.toString();
        Utils.fileUrl = checkAppVersionModel!.fileUrl.toString();
        print("fileUrl == ${Utils.fileUrl}");
        print("baseUrl == ${Utils.baseUrl}");
        update();
        // await prefs.setString(Preference.updateType, checkAppVersionModel!.isApplicationUpdate!);
        print(checkAppVersionModel?.isApplicationUpdate.toString());
      } else {
        if (hasInternet == true) {
          MyToasts().errorToast(toast: "Data not found.");
        }
      }
      update();
      Loader.hd();
    } finally {
      Loader.hd();
    }
  }

  // Models
  LogInEditUserModel? logInModel;

  loginUserDetails(LoginUserData userModel) async {
    final hasInternet = await checkInternets();
    try {
      // Loader.sw();
      // Map<String, dynamic> data = Map<String, dynamic>();
      //
      // data["email_id"] = emailC.text;
      // data["user_password"] = passwordC.text;
      // data["device_type"] = Utils.deviceType ?? "";
      // data["device_token"] = Utils.deviceToken ?? "";

      logInModel = await LoginProvider().loginUserDetails(userModel.token, userModel.userId);
      if (logInModel != null) {
        if (logInModel?.status == true) {
          if (logInModel?.data != null) {
            await Storage.saveUser(logInModel?.data);
            print(logInModel?.message.toString());
            // MyToasts().successToast(toast: logInModel?.message.toString());
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
            if (logInModel!.message == "Sign in failed.") {
              print("logInModel == ${logInModel?.message.toString()}");
              MyToasts().errorToast(toast: logInModel?.message.toString());
              Storage.clearData();
              update();
              Get.offAll(() => LoginScreen());
            } else {
              print("logInModel?.message == ${logInModel?.message.toString()}");
              MyToasts().errorToast(toast: logInModel?.message.toString());
            }
          }
        }
      }
      // Loader.hd();
      update();
    } finally {
      Loader.hd();
    }
  }
}
