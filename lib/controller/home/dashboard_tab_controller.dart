import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shuttleservice/module/model/auth/login_model.dart';
import 'package:shuttleservice/module/model/home/dashboard_screen_model.dart';
import 'package:shuttleservice/module/model/success_model.dart';
import 'package:shuttleservice/module/provider/home/deshboard_provider.dart';
import 'package:shuttleservice/services/internet_service.dart';
import 'package:shuttleservice/view/screen/auth/login_screen.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/loader.dart';
import 'package:shuttleservice/view/utils/shared_preference.dart';
import 'package:shuttleservice/view/widget/toasts.dart';

class DashboardTabController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController searchC = TextEditingController();
  RefreshController deshboardController = RefreshController(initialRefresh: false);
  DateTime selectedDate = DateTime.now();

  TextEditingController dateC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController phoneNoC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  bool showPassword = true;
  bool submitted = false;

  String? startTime;
  String loginDate = "";

  // Models
  SuccessModel? successModel;
  TripExportModel? tripExportModel;
  LoginUserData? userModel;
  DashboardModel? dashboardModel;

  DateTime now = DateTime.now();

  String? startDate;
  String? endDate;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    userModel = await Storage.getUser();

    print(userModel!.userName.toString());
    loginDate = DateFormat("dd MMM yyyy").format(DateTime.parse(userModel!.createdAt.toString()));
    update();
    dateC.text = DateFormat('dd MMM yyyy').format(selectedDate);
    startDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    await dashboardCounter(startDate: startDate);
    super.onInit();
  }

  showPassClick() {
    showPassword = !showPassword;
    update();
  }

  List<DateTime?> dialogCalendarPickerValue = [
    DateTime.now(),
    DateTime.now(),
  ];

  userLogOut() async {
    final hasInternet = await checkInternets();
    try {
      Loader.sw();

      LoginUserData? userModel = await Storage.getUser();

      successModel = await DashboardProvider().logOutUser(userModel?.userId.toString(), userModel?.token.toString());
      if (successModel != null) {
        if (successModel?.status == true) {
          Storage.clearData();
          update();
          MyToasts().successToast(toast: successModel?.message.toString());
          Get.offAll(() => LoginScreen());
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

  dashboardCounter({String? startDate, String? endDate}) async {
    final hasInternet = await checkInternets();
    try {
      Loader.sw();

      Map<String, dynamic> data = Map<String, dynamic>();
      if (startDate != null && endDate != null) {
        data["start_date"] = "${startDate}";
        data["end_date"] = "${endDate}";
        print(startDate.toString());
        print(endDate.toString());
      } else if (startDate != null) {
        data["start_date"] = "${startDate}";
        print(startDate.toString());
      }

      dashboardModel = await DashboardProvider().dashboardCounter(data);
      if (dashboardModel != null) {
        if (dashboardModel?.status == true) {
          print(dashboardModel?.data?.passenger.toString());
          print(dashboardModel?.data?.busCounter.toString());
          print(dashboardModel?.data?.tripCounter.toString());
          update();
        } else {
          if (hasInternet == true) {
            if (dashboardModel!.message == "Sign in failed.") {
              print("logInModel == ${dashboardModel?.message.toString()}");
              MyToasts().errorToast(toast: dashboardModel?.message.toString());
              Storage.clearData();
              update();
              Get.offAll(() => LoginScreen());
            } else {
              MyToasts().errorToast(toast: dashboardModel?.message.toString());
            }
          }
        }
      }
      Loader.hd();
      update();
    } finally {
      Loader.hd();
    }
  }

  sessionStart({required int busesType}) async {
    final hasInternet = await checkInternets();
    try {
      now = DateTime.now();
      Loader.sw();
      String session_date = DateFormat("yyyy-MM-dd").format(now);
      String start_at = DateFormat("kk:mm:ss").format(now);
      print(session_date);
      print(start_at);
      Map<String, dynamic> data = Map<String, dynamic>();

      data["session_date"] = "${session_date}";
      data["start_at"] = "${start_at}";
      data["bus_location"] = "${busesType}";

      successModel = await DashboardProvider().sessionStart(data);
      if (successModel != null) {
        if (successModel?.status == true) {
          print(successModel?.message.toString());
          startTime = start_at;
          update();
          await dashboardCounter();
          Get.back();
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

  sessionEnd({required int busesType}) async {
    final hasInternet = await checkInternets();
    try {
      now = DateTime.now();
      Loader.sw();
      // String updated_by = DateFormat("yyyy-MM-dd").format(now);
      String end_at = DateFormat("kk:mm:ss").format(now);
      print(end_at);
      Map<String, dynamic> data = Map<String, dynamic>();

      data["id"] = "${dashboardModel?.data?.sessionId ?? ""}";
      data["end_at"] = "${end_at}";
      data["bus_location"] = "${busesType}";

      successModel = await DashboardProvider().sessionEnd(data);
      if (successModel != null) {
        if (successModel?.status == true) {
          print(successModel?.message.toString());
          await dashboardCounter();
          Get.back();
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

  Future tripExport() async {
    final hasInternet = await checkInternets();
    try {
      Loader.sw();

      tripExportModel = await DashboardProvider().tripExport();
      if (tripExportModel != null) {
        if (tripExportModel?.status == true) {
          update();
          return tripExportModel!.data;
        } else {
          if (hasInternet == true) {
            MyToasts().errorToast(toast: tripExportModel?.message.toString());
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
