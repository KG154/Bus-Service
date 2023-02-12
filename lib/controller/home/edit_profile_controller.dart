import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shuttleservice/controller/home/dashboard_tab_controller.dart';
import 'package:shuttleservice/module/model/auth/login_model.dart';
import 'package:shuttleservice/module/provider/home/edit_profile_provider.dart';
import 'package:shuttleservice/services/internet_service.dart';
import 'package:shuttleservice/view/utils/loader.dart';
import 'package:shuttleservice/view/utils/shared_preference.dart';
import 'package:shuttleservice/view/widget/toasts.dart';

class EditProfileController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DashboardTabController dashboardTabController = Get.put(DashboardTabController());
  TextEditingController searchC = TextEditingController();

  TextEditingController nameC = TextEditingController();
  TextEditingController phoneNoC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  bool submitted = false;

  LoginUserData? userModel;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    userModel = await Storage.getUser();
    update();
    nameC.text = userModel?.userName.toString() ?? "";
    phoneNoC.text = userModel?.userPhone.toString() ?? "";
    emailC.text = userModel?.emailId.toString() ?? "";
    super.onInit();
  }

  // Models
  LogInEditUserModel? logInEditUserModel;

  Future editProfile() async {
    final hasInternet = await checkInternets();
    try {
      Loader.sw();
      Map<String, dynamic> data = Map<String, dynamic>();

      data["user_name"] = nameC.text.toString();
      data["user_phone"] = phoneNoC.text.toString();
      data["email_id"] = emailC.text.toString();

      logInEditUserModel = await EditProfileProvider().editUserProfile(data);
      if (logInEditUserModel != null) {
        if (logInEditUserModel?.status == true) {
          if (logInEditUserModel?.data != null) {
            Storage.saveUser(logInEditUserModel?.data);
            dashboardTabController.userModel = await Storage.getUser();
            dashboardTabController.update();
            Get.back();
            MyToasts().successToast(toast: logInEditUserModel?.message.toString());
            update();
            return true;
          }
        } else {
          if (hasInternet == true) {
            MyToasts().errorToast(toast: logInEditUserModel?.message.toString());
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
