import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shuttleservice/module/model/success_model.dart';
import 'package:shuttleservice/module/provider/home/edit_profile_provider.dart';
import 'package:shuttleservice/services/internet_service.dart';
import 'package:shuttleservice/view/screen/home/site_managers_screen/site_manager_home_screen.dart';
import 'package:shuttleservice/view/screen/main_screen.dart';
import 'package:shuttleservice/view/utils/loader.dart';
import 'package:shuttleservice/view/widget/toasts.dart';

class ChangePassController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController cuPasswordC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController cPasswordC = TextEditingController();
  bool showCuPassword = true;
  bool showPassword = true;
  bool showCPassword = true;
  bool submitted = false;

  showCuPassClick() {
    showCuPassword = !showCuPassword;
    update();
  }

  showPassClick() {
    showPassword = !showPassword;
    update();
  }

  showCPassClick() {
    showCPassword = !showCPassword;
    update();
  }

  // Models
  SuccessModel? successModel;

  changePassword({String? type}) async {
    final hasInternet = await checkInternets();
    try {
      Loader.sw();
      Map<String, dynamic> data = Map<String, dynamic>();

      data["old_password"] = "${cuPasswordC.text}";
      data["user_new_password"] = "${passwordC.text}";

      successModel = await EditProfileProvider().changePassword(data);
      if (successModel != null) {
        if (successModel?.status == true) {
          MyToasts().successToast(toast: successModel?.message.toString());
          update();
          if (type == "") {
            Get.offAll(() => MainScreen());
          } else {
            Get.offAll(() => SiteManagerHomeScreen());
          }

          update();
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
