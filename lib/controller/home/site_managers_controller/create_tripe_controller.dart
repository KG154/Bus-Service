import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shuttleservice/controller/home/buses_tab_controller.dart';
import 'package:shuttleservice/controller/home/site_managers_controller/site_manager_home_screen_controller.dart';
import 'package:shuttleservice/controller/home/sites_tab_controller.dart';
import 'package:shuttleservice/module/model/auth/login_model.dart';
import 'package:shuttleservice/module/model/success_model.dart';
import 'package:shuttleservice/module/provider/home/site_manager/create_trip_provider.dart';
import 'package:shuttleservice/services/internet_service.dart';
import 'package:shuttleservice/view/screen/auth/login_screen.dart';
import 'package:shuttleservice/view/utils/loader.dart';
import 'package:shuttleservice/view/utils/shared_preference.dart';
import 'package:shuttleservice/view/widget/toasts.dart';

class CreateTripeController extends GetxController {
  BusesTabController busesTabController = Get.put(BusesTabController());
  SitesTabController sitesTabController = Get.put(SitesTabController());
  SiteMHomeScreenController siteMHomeScreenController = Get.put(SiteMHomeScreenController());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController dNameC = TextEditingController();
  TextEditingController dPhoneNoC = TextEditingController();
  TextEditingController noOfPassC = TextEditingController();
  TextEditingController startSiteC = TextEditingController();
  TextEditingController busNumC = TextEditingController();
  TextEditingController endSiteC = TextEditingController();
  TextEditingController searchC = TextEditingController();
  TextEditingController searchC2 = TextEditingController();
  bool search = false;
  List filteredUser = [];
  bool search2 = false;
  List filteredSite = [];
  String? fromId;

  int? busId;
  int? endId;

  bool showPassword = true;
  bool submitted = false;

  showPassClick() {
    showPassword = !showPassword;
    update();
  }

  LoginUserData? userModel;

  /*String? selectedBus;
  String? selectedSSite;
  String? selectedESite;
  List busType = ["GJ-05 2715", "GJ-05 1235", "GJ-05 4526"];
  List startSiteType = ["Site A", "Site AB"];
  List endSiteType = ["Site c", "Site D"];*/

  /*@override
  Future<void> onInit() async {
    // TODO: implement onInit
    userModel = await Storage.getUser();

    update();
    await busesTabController.getActiveBusesList(loader: 0, status: "active");
    await sitesTabController.getSiteListForAdd(status: "active", loader: 0);
    startSiteC.text = userModel!.startSiteName.toString();
    update();
    for (int i = 0; i < sitesTabController.siteListForAdd.length; i++) {
      if (sitesTabController.siteListForAdd[i].name == userModel?.endSiteName) {
        sitesTabController.selectedESite = sitesTabController.siteListForAdd[i];
      }
    }
    update();
    super.onInit();
  }*/

  // Models
  SuccessModel? successModel;
  DateTime now = DateTime.now();

  addTrip({int? endId, int? busId, String? fromId}) async {
    final hasInternet = await checkInternets();
    try {
      now = DateTime.now();
      Loader.sw();
      Map<String, dynamic> data = Map<String, dynamic>();

      data["busid"] = "${busId}";
      data["from_site_id"] = "${fromId}";
      data["to_site_id"] = "${endId}";
      data["drive_name"] = "${dNameC.text}";
      data["drive_moblie"] = "${dPhoneNoC.text}";
      data["from_count"] = "${noOfPassC.text}";
      data["from_time"] = DateFormat("hh:mm:ss a").format(now);
      data["from_date"] = DateFormat("yyyy-MM-dd").format(now);

      successModel = await CreateTripProvider().addTrip(data);
      if (successModel != null) {
        if (successModel?.status == true) {
          MyToasts().successToast(toast: successModel?.message.toString());
          String startDate = DateFormat('yyyy-MM-dd').format(siteMHomeScreenController.selectedDate);
          if (siteMHomeScreenController.startDate != null && siteMHomeScreenController.endDate != null) {
            // String startDate = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(siteMHomeScreenController.startDate.toString()))}";
            String endDate = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(siteMHomeScreenController.endDate.toString()))}";
            await siteMHomeScreenController.startTripList(status: "", loader: 1, startDate: startDate, endDate: endDate);
            await siteMHomeScreenController.endTripList(loader: 0, startDate: startDate, endDate: endDate);
          } else {
            String startDate = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(siteMHomeScreenController.startDate.toString()))}";
            await siteMHomeScreenController.startTripList(status: "", loader: 1, startDate: startDate);
            await siteMHomeScreenController.endTripList(loader: 0, startDate: startDate);
          }
          // await siteMHomeScreenController.startTripList(status: "end_site", loader: 0, startDate: startDate);
          update();
          Get.back();
          update();
        } else {
          if (hasInternet == true) {
            if (successModel!.message == "Sign in failed.") {
              print("logInModel == ${successModel?.message.toString()}");
              MyToasts().errorToast(toast: successModel?.message.toString());
              Storage.clearData();
              update();
              Get.offAll(() => LoginScreen());
            } else {
              MyToasts().errorToast(toast: successModel?.message.toString());
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

  editTrip({int? endId, int? busId, int? id, String? fromId}) async {
    final hasInternet = await checkInternets();
    try {
      now = DateTime.now();
      Loader.sw();
      Map<String, dynamic> data = Map<String, dynamic>();

      data["id"] = "${id}";
      data["busid"] = "${busId}";
      data["from_sideid"] = "${fromId}";
      data["to_sideid"] = "${endId}";
      data["drive_name"] = "${dNameC.text}";
      data["drive_moble"] = "${dPhoneNoC.text}";
      data["from_count"] = "${noOfPassC.text}";
      // data["from_time"] = DateFormat("hh:mm:ss a").format(now);
      // data["from_date"] = DateFormat("yyyy-MM-dd").format(now);

      successModel = await CreateTripProvider().addTrip(data, type: "Edit");
      if (successModel != null) {
        if (successModel?.status == true) {
          MyToasts().successToast(toast: successModel?.message.toString());
          // String startDate = DateFormat('yyyy-MM-dd').format(siteMHomeScreenController.selectedDate);

          if (siteMHomeScreenController.startDate != null && siteMHomeScreenController.endDate != null) {
            String startDate = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(siteMHomeScreenController.startDate.toString()))}";
            String endDate = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(siteMHomeScreenController.endDate.toString()))}";
            await siteMHomeScreenController.startTripList(status: "", loader: 1, startDate: startDate, endDate: endDate);
            await siteMHomeScreenController.endTripList(loader: 0, startDate: startDate, endDate: endDate);
          } else {
            String startDate = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(siteMHomeScreenController.startDate.toString()))}";
            await siteMHomeScreenController.startTripList(status: "", loader: 1, startDate: startDate);
            await siteMHomeScreenController.endTripList(loader: 0, startDate: startDate);
          }

          // await siteMHomeScreenController.startTripList(status: "end_site", loader: 0, startDate: startDate);
          update();
          Get.back();
          update();
        } else {
          if (hasInternet == true) {
            if (successModel!.message == "Sign in failed.") {
              print("logInModel == ${successModel?.message.toString()}");
              MyToasts().errorToast(toast: successModel?.message.toString());
              Storage.clearData();
              update();
              Get.offAll(() => LoginScreen());
            } else {
              MyToasts().errorToast(toast: successModel?.message.toString());
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
}
