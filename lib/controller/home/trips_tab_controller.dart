import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shuttleservice/controller/home/buses_tab_controller.dart';
import 'package:shuttleservice/controller/home/sites_tab_controller.dart';
import 'package:shuttleservice/module/model/home/site_manager/start_trip_list_model.dart';
import 'package:shuttleservice/module/model/success_model.dart';
import 'package:shuttleservice/module/provider/home/site_manager/create_trip_provider.dart';
import 'package:shuttleservice/module/provider/home/trips_provider.dart';
import 'package:shuttleservice/services/internet_service.dart';
import 'package:shuttleservice/view/screen/auth/login_screen.dart';
import 'package:shuttleservice/view/utils/loader.dart';
import 'package:shuttleservice/view/utils/shared_preference.dart';
import 'package:shuttleservice/view/widget/toasts.dart';

class TripsTabController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  SitesTabController sitesTabController = Get.put(SitesTabController());
  BusesTabController busesTabController = Get.put(BusesTabController());

  TextEditingController searchC = TextEditingController();
  TextEditingController searchC1 = TextEditingController();
  TextEditingController searchC2 = TextEditingController();
  TextEditingController searchC3 = TextEditingController();

  TextEditingController noOFPassC = TextEditingController();
  RefreshController tripController = RefreshController(initialRefresh: false);

  TextEditingController dateC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController phoneNoC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  bool showPassword = true;
  bool submitted = false;
  bool submitted2 = false;
  DateTime selectedDate = DateTime.now();

  TextEditingController busNumC = TextEditingController();
  TextEditingController startSiteC = TextEditingController();
  TextEditingController endSiteC = TextEditingController();
  TextEditingController dNameC = TextEditingController();
  TextEditingController dPhoneNoC = TextEditingController();
  TextEditingController noOfPassC = TextEditingController();
  bool search = false;
  bool search1 = false;
  List filteredBuses = [];
  bool search2 = false;
  List filteredStartSite = [];
  List filteredSite = [];
  String? fromId;
  int? busId;
  int? endId;

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

  showPassClick() {
    showPassword = !showPassword;
    update();
  }

  List<DateTime?> dialogCalendarPickerValue = [DateTime.now(), DateTime.now()];

  String? startDate;
  String? endDate;
  int busses = 0;
  StartTripListModel? TripListModel;
  SuccessModel? successModel;
  List<StartTripData> TripListData = [];
  List<StartTripData> filterListData = [];

  @override
  Future<void> onInit() async {
    busesTabController.selectedBuses = null;
    sitesTabController.selectedSSite = null;
    sitesTabController.selectedESite = null;
    dateC.text = DateFormat('dd MMM yyyy').format(selectedDate);
    update();
    startDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    await adminTripList(startDate: startDate, loader: 1);
    await busesTabController.getBusesList(loader: 0);
    await sitesTabController.getSiteList(loader: 0);

    update();
    // TODO: implement onInit
    super.onInit();
  }

  adminTripList({String? endDate, String? startDate, int? busid, int? startId, int? endId, int? loader}) async {
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

      TripListModel = await TripProvider().tripList(data);
      if (TripListModel != null) {
        if (TripListModel?.status == true) {
          TripListData.clear();
          TripListData.addAll(TripListModel!.data!);
          print("List = ${TripListData.length}");
          busses = TripListData.length;

          update();
        } else {
          if (hasInternet == true) {
            if (TripListModel!.message == "Sign in failed.") {
              print("logInModel == ${TripListModel?.message.toString()}");
              MyToasts().errorToast(toast: TripListModel?.message.toString());
              Storage.clearData();
              update();
              Get.offAll(() => LoginScreen());
            } else {
              MyToasts().errorToast(toast: TripListModel?.message.toString());
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

  editUsers({String? endId, int? busId, int? id, String? fromId}) async {
    final hasInternet = await checkInternets();
    try {
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
          // String starDate = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(startDate.toString()))}";
          print("editUsers = ${startDate.toString()}");
          print("editUsers = ${endDate.toString()}");

          if (startDate != null && endDate != null) {
            String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(startDate.toString()))}";
            String endDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(endDate.toString()))}";
            adminTripList(loader: 1, startDate: startDate1, endDate: endDate1);
          } else {
            String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(startDate.toString()))}";
            adminTripList(loader: 1, startDate: startDate1);
          }
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

  endTrip({String? id, String? noOFPassC}) async {
    final hasInternet = await checkInternets();
    try {
      Loader.sw();
      DateTime now = DateTime.now();
      Map<String, dynamic> data = Map<String, dynamic>();

      data["id"] = "${id}";
      data["to_count"] = "${noOFPassC}";
      data["to_time"] = DateFormat("hh:mm:ss a").format(now);
      data["to_date"] = DateFormat("yyyy-MM-dd").format(now);

      successModel = await CreateTripProvider().endTrip(data);
      if (successModel != null) {
        if (successModel?.status == true) {
          print("message == ${successModel?.message.toString()}");

          print("editUsers = ${startDate.toString()}");
          print("editUsers = ${endDate.toString()}");

          if (startDate != null && endDate != null) {
            String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(startDate.toString()))}";
            String endDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(endDate.toString()))}";
            adminTripList(loader: 1, startDate: startDate1, endDate: endDate1);
          } else {
            String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(startDate.toString()))}";
            adminTripList(loader: 1, startDate: startDate1);
          }
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
}
