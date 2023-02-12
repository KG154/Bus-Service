import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shuttleservice/module/model/auth/reset_password_model.dart';
import 'package:shuttleservice/module/provider/auth/reset_password_provider.dart';
import 'package:shuttleservice/services/internet_service.dart';
import 'package:shuttleservice/view/screen/auth/login_screen.dart';
import 'package:shuttleservice/view/utils/loader.dart';
import 'package:shuttleservice/view/widget/toasts.dart';

class ResetPassScreenController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController passwordC = TextEditingController();
  TextEditingController cPasswordC = TextEditingController();
  bool showPassword = true;
  bool showCPassword = true;
  bool submitted = false;

  showPassClick() {
    showPassword = !showPassword;
    update();
  }

  showCPassClick() {
    showCPassword = !showCPassword;
    update();
  }

  // Models
  ResetPasswordModel? resetPasswordModel;

  resetPassword(String? email) async {
    final hasInternet = await checkInternets();
    try {
      Loader.sw();
      Map<String, dynamic> data = Map<String, dynamic>();

      data["email_id"] = "${email}";
      data["user_password"] = passwordC.text;

      resetPasswordModel = await ResetPasswordProvider().resetPassword(data);
      if (resetPasswordModel != null) {
        if (resetPasswordModel?.status == true) {
          MyToasts().successToast(toast: resetPasswordModel?.message.toString());
          passwordC.clear();
          cPasswordC.clear();
          Get.offAll(() => LoginScreen());
          update();
        } else {
          if (hasInternet == true) {
            MyToasts().errorToast(toast: resetPasswordModel?.message.toString());
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
