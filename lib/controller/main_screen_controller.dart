import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shuttleservice/module/model/auth/login_model.dart';
import 'package:shuttleservice/view/screen/home/buses_tab_screen.dart';
import 'package:shuttleservice/view/screen/home/dashboard_tab_screen.dart';
import 'package:shuttleservice/view/screen/home/sites_tab_screen.dart';
import 'package:shuttleservice/view/screen/home/trips_tab_screen.dart';
import 'package:shuttleservice/view/screen/home/users_tab_screen.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/dialog.dart';
import 'package:shuttleservice/view/utils/shared_preference.dart';

class MainScreenController extends GetxController {
  BuildContext context;

  MainScreenController(this.context);

  RxInt currentIndex = 0.obs;

  //Models
  LoginUserData? userModel;
  String? name;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    currentIndex = 0.obs;
    userModel = await Storage.getUser();
    name = userModel?.userName;
    update();
    print(userModel!.userName.toString());
    versionDialog(context);
    super.onInit();
  }

  updateIndex(int value) {
    currentIndex = value.obs;
    update();
  }

  List page = [
    DashboardTabScreen(),
    TripsTabScreen(),
    BusesTabScreen(),
    SitesTabScreen(),
    UsersTabScreen(),
  ];

  ///app version
  versionDialog(BuildContext context) {
    if (Utils.applicationUpdate == "is_updated") {
      print("---->is_not_need_update");
    } else if (Utils.applicationUpdate == "is_review") {
      print("---->is_review");
    } else if (Utils.applicationUpdate == "is_partial_update") {
      print("---->is_normal_update");
      showAlertDialog(context);
    } else if (Utils.applicationUpdate == "is_force_update") {
      print("---->is_force_update");
      buildAppUpdateDialog(context, "You need to update your application.", true, "is_force_update");
    }
  }
}
