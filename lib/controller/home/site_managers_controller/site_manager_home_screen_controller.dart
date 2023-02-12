import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shuttleservice/controller/home/buses_tab_controller.dart';
import 'package:shuttleservice/controller/home/dashboard_tab_controller.dart';
import 'package:shuttleservice/controller/home/sites_tab_controller.dart';
import 'package:shuttleservice/module/model/auth/login_model.dart';
import 'package:shuttleservice/module/model/home/site_manager/end_trip_list_model.dart';
import 'package:shuttleservice/module/model/home/site_manager/start_trip_list_model.dart';
import 'package:shuttleservice/module/model/success_model.dart';
import 'package:shuttleservice/module/provider/home/site_manager/create_trip_provider.dart';
import 'package:shuttleservice/services/internet_service.dart';
import 'package:shuttleservice/view/screen/auth/login_screen.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/dialog.dart';
import 'package:shuttleservice/view/utils/loader.dart';
import 'package:shuttleservice/view/utils/shared_preference.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/toasts.dart';

class SiteMHomeScreenController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DashboardTabController dashboardTabController = Get.put(DashboardTabController());
  SitesTabController sitesTabController = Get.put(SitesTabController());
  BusesTabController busesTabController = Get.put(BusesTabController());

  RefreshController tripCController = RefreshController(initialRefresh: false);
  RefreshController tripECController = RefreshController(initialRefresh: false);

  TextEditingController searchC = TextEditingController();
  TextEditingController searchC1 = TextEditingController();
  TextEditingController searchC2 = TextEditingController();
  TextEditingController searchC3 = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController phoneNoC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController noOFPassC = TextEditingController();
  TextEditingController dateC = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String? selectedBus;
  String? selectedSSite;
  String? selectedESite;

  bool showPassword = true;
  bool submitted = false;

  //for filter
  TextEditingController busNumFilterC = TextEditingController();
  TextEditingController startSiteFilterC = TextEditingController();
  TextEditingController endSiteFilterC = TextEditingController();
  bool searchFromFilter = false;
  bool searchBusFilter = false;
  bool searchEndFilter = false;
  int? fromFilterId;
  int? busFilterId;
  int? endFilterId;
  bool search = false;
  bool search1 = false;
  List filteredBuses = [];
  bool search2 = false;
  List filteredStartSite = [];
  List filteredSite = [];

  showPassClick() {
    showPassword = !showPassword;
    update();
  }

  // Models
  SuccessModel? successModel;
  LoginUserData? userModel;
  StartTripListModel? startTripListModel;
  EndTripListModel? endTripListModel;
  String loginDate = "";

  DateTime now = DateTime.now();
  String? startDate;
  String? endDate;

  /* @override
  Future<void> onInit() async {
    // TODO: implement onInit
    // versionDialog(context);
    userModel = await Storage.getUser();
    loginDate = DateFormat("dd MMM yyyy").format(DateTime.parse(userModel!.createdAt.toString()));
    update();
    dateC.text = DateFormat('dd MMM yyyy').format(selectedDate);
    startDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    update();
    await startTripList(status: "", loader: 1, startDate: startDate);
    await endTripList(loader: 1, startDate: startDate);

    // await startTripList(status: "end_site", loader: 0, startDate: startDate);
    update();
    super.onInit();
  }*/

  // List busType = ["GJ-05 2715", "GJ-05 1235", "GJ-05 4526"];
  // List startSiteType = ["Site A", "Site AB"];
  // List endSiteType = ["Site c", "Site D"];

  List<DateTime?> dialogCalendarPickerValue = [DateTime.now(), DateTime.now()];

  List<EndTripData> startTripListData = [];
  List<EndTripData> startFilterListData = [];
  List<EndTripData> endFilterListData = [];
  List<EndTripData> endTripListData = [];

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

  startTripList({String? status, String? endDate, String? startDate, int? busid, int? startId, int? endId, int? loader}) async {
    final hasInternet = await checkInternets();
    try {
      if (loader == 1) {
        Loader.sw();
      }

      Map<String, dynamic> data = Map<String, dynamic>();
      if (startDate != null && endDate != null) {
        data["start_date"] = "${startDate}";
        data["end_date"] = "${endDate}";
        print(startDate.toString());
        print(endDate.toString());
      }
      if (startDate != null) {
        data["start_date"] = "${startDate}";
        print(startDate.toString());
      }
      if (busid != null) {
        data["busid"] = "${busid}";
        print(busid.toString());
      }
      if (startId != null) {
        data["from_sideid"] = "${startId}";
        print(startId.toString());
      }
      if (endId != null) {
        data["to_sideid"] = "${endId}";
        print(endId.toString());
      }
      // if (status != "") {
      //   data["site_status"] = "${status}";
      // }

      endTripListModel = await CreateTripProvider().startTripList(data);
      if (endTripListModel != null) {
        if (endTripListModel?.status == true) {
          // if (startTripListModel?.data != null) {
          // if (status == "") {
          startTripListData.clear();
          startTripListData.addAll(endTripListModel!.data!);
          print("Start List = ${startTripListData.length}");
          update();
          // } else {
          //   endTripListData.clear();
          //   endTripListData.addAll(startTripListModel!.data!);
          //   print("End List = ${endTripListData.length}");
          //   update();
          // }
          // }
          update();
        } else {
          if (hasInternet == true) {
            if (endTripListModel!.message == "Sign in failed.") {
              print("logInModel == ${endTripListModel?.message.toString()}");
              MyToasts().errorToast(toast: endTripListModel?.message.toString());
              Storage.clearData();
              update();
              Get.offAll(() => LoginScreen());
            } else {
              MyToasts().errorToast(toast: endTripListModel?.message.toString());
            }
          }
        }
      }
      update();
      if (loader == 1) {
        Loader.hd();
      }
    } finally {
      Loader.hd();
    }
  }

  endTripList({String? status, String? endDate, String? startDate, int? busid, int? startId, int? endId, int? loader}) async {
    final hasInternet = await checkInternets();
    try {
      if (loader == 1) {
        Loader.sw();
      }

      Map<String, dynamic> data = Map<String, dynamic>();
      if (startDate != null && endDate != null) {
        data["start_date"] = "${startDate}";
        data["end_date"] = "${endDate}";
        print(startDate.toString());
        print(endDate.toString());
      }
      if (startDate != null) {
        data["start_date"] = "${startDate}";
        print(startDate.toString());
      }
      if (busid != null) {
        data["busid"] = "${busid}";
        print(busid.toString());
      }
      if (startId != null) {
        data["from_sideid"] = "${startId}";
        print(startId.toString());
      }
      if (endId != null) {
        data["to_sideid"] = "${endId}";
        print(endId.toString());
      }

      endTripListModel = await CreateTripProvider().endTripList(data);
      if (endTripListModel != null) {
        if (endTripListModel?.status == true) {
          endTripListData.clear();
          endTripListData.addAll(endTripListModel!.data!);
          print("End List = ${endTripListData.length}");
          update();

          update();
        } else {
          if (hasInternet == true) {
            if (endTripListModel!.message == "Sign in failed.") {
              print("logInModel == ${endTripListModel?.message.toString()}");
              MyToasts().errorToast(toast: endTripListModel?.message.toString());
              Storage.clearData();
              update();
              Get.offAll(() => LoginScreen());
            } else {
              MyToasts().errorToast(toast: endTripListModel?.message.toString());
            }
          }
        }
      }
      update();
      if (loader == 1) {
        Loader.hd();
      }
    } finally {
      Loader.hd();
    }
  }

  endTrip({String? id, String? noOFPassC}) async {
    final hasInternet = await checkInternets();
    try {
      Loader.sw();
      now = DateTime.now();
      Map<String, dynamic> data = Map<String, dynamic>();

      data["id"] = "${id}";
      data["to_count"] = "${noOFPassC}";
      data["to_time"] = DateFormat("hh:mm:ss a").format(now);
      data["to_date"] = DateFormat("yyyy-MM-dd").format(now);

      successModel = await CreateTripProvider().endTrip(data);
      if (successModel != null) {
        if (successModel?.status == true) {
          print("message == ${successModel?.message.toString()}");
          // await startTripList(status: "", loader: 0, startDate: startDate);
          await endTripList(loader: 0, startDate: startDate);
          // await startTripList(status: "end_site", loader: 0, startDate: startDate);

          update();
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

  Future deleteTrip({int? id}) async {
    final hasInternet = await checkInternets();
    try {
      Loader.sw();
      now = DateTime.now();
      Map<String, dynamic> data = Map<String, dynamic>();

      data["id"] = "${id}";

      successModel = await CreateTripProvider().deleteTrip(data);
      if (successModel != null) {
        if (successModel?.status == true) {
          print("message == ${successModel?.message.toString()}");
          update();
          return true;
        } else {
          if (hasInternet == true) {
            print("Message == ${successModel?.message.toString()}");
            MyToasts().errorToast(toast: successModel?.message.toString());
          }
          return false;
        }
      }
      Loader.hd();
      update();
    } finally {
      Loader.hd();
    }
  }
}
