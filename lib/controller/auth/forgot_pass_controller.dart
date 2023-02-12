import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shuttleservice/module/model/auth/forgot_password_model.dart';
import 'package:shuttleservice/module/model/success_model.dart';
import 'package:shuttleservice/module/provider/auth/forgot_password_provider.dart';
import 'package:shuttleservice/services/internet_service.dart';
import 'package:shuttleservice/view/screen/auth/reset_password_screen.dart';
import 'package:shuttleservice/view/screen/auth/verification_screen.dart';
import 'package:shuttleservice/view/utils/loader.dart';
import 'package:shuttleservice/view/widget/toasts.dart';

class ForgotPassScreenController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailC = TextEditingController();

  TextEditingController otpSingUpC = TextEditingController();
  bool submitted = false;
  String? pin;

  // Models
  SuccessModel? successModel;
  ForgotPasswordModel? forgotPasswordModel;

  forgotPassword() async {
    final hasInternet = await checkInternets();
    try {
      Loader.sw();
      print(emailC.text.toString());
      Map<String, dynamic> data = Map<String, dynamic>();
      data["email_id"] = emailC.text;

      forgotPasswordModel = await ForGotPasswordProvider().forgotPassword(data);
      if (forgotPasswordModel != null) {
        if (forgotPasswordModel?.status == true) {
          print(forgotPasswordModel?.data?.verifyCode.toString());
          MyToasts().successToast(toast: forgotPasswordModel?.message.toString());
          Get.to(() => Verification_screen(email : emailC.text));
        } else {
          if (hasInternet == true) {
            MyToasts().errorToast(toast: forgotPasswordModel?.message.toString());
          }
        }
      }

      Loader.hd();
      update();
    } finally {
      Loader.hd();
    }
  }

  verification() async {
    final hasInternet = await checkInternets();
    try {
      Loader.sw();
      print(emailC.text.toString());
      print(otpSingUpC.text.toString());
      Map<String, dynamic> data = Map<String, dynamic>();
      data["email_id"] = emailC.text;
      data["verify_code"] = otpSingUpC.text;

      successModel = await ForGotPasswordProvider().verification(data);
      if (successModel != null) {
        if (successModel?.status == true) {
          MyToasts().successToast(toast: successModel?.message.toString());
          Get.to(() => ResetPasswordScreen(email: emailC.text));
        } else {
          if (hasInternet == true) {
            MyToasts().errorToast(toast: successModel?.message.toString());
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
