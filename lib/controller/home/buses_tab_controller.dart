import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shuttleservice/module/model/home/buses_list_model.dart';
import 'package:shuttleservice/module/model/success_model.dart';
import 'package:shuttleservice/module/provider/home/buses_tab_provider.dart';
import 'package:shuttleservice/services/internet_service.dart';
import 'package:shuttleservice/view/screen/auth/login_screen.dart';
import 'package:shuttleservice/view/utils/loader.dart';
import 'package:shuttleservice/view/utils/shared_preference.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/toasts.dart';

class BusesTabController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController searchC = TextEditingController();
  RefreshController busCController = RefreshController(initialRefresh: false);

  TextEditingController busC = TextEditingController();
  List busStatus = [Str.active, Str.inactive];
  List busType = [Str.scheme, Str.nagar];
  String? selectedBusType;

  String selectedStatus = "";

  String? selectedBusStatus;
  bool submitted = false;
  int busses = 0;
  bool? isSelected = false;
  bool? isSelected1 = false;
  bool? active = false;

  // Models
  SuccessModel? successModel;
  BusesListModel? busesListModel;
  BusesListData? selectedBuses;
  BusesListData? selectedBuses2;
  List<BusesListData> busesList = [];
  List<BusesListData> busesListForAdd = [];
  List<BusesListData> filterbusesList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    getBusesList(loader: 1);
    if (isSelected1 == false && isSelected == false) {
      active = null;
    }
    super.onInit();
  }

  getBusesList({int? loader, String? status}) async {
    final hasInternet = await checkInternets();
    try {
      busesList.clear();
      if (loader == 1) {
        Loader.sw();
      }
      Map<String, dynamic> data = Map<String, dynamic>();
      if (status != null) {
        data["status"] = "${status}";
      }
      busesListModel = await BusesProvider().getBusesList(data);
      if (busesListModel != null) {
        if (busesListModel?.status == true) {
          isSelected1 = false;
          isSelected = false;
          filterbusesList.clear();
          busesList.clear();
          busesList.addAll(busesListModel!.data!);
          filterbusesList.addAll(busesListModel!.data!);
          print(busesList.length);
          busses = busesList.length;
          update();
        } else {
          if (hasInternet == true) {
            if (busesListModel!.message == "Sign in failed.") {
              print("logInModel == ${busesListModel?.message.toString()}");
              MyToasts().errorToast(toast: busesListModel?.message.toString());
              Storage.clearData();
              update();
              Get.offAll(() => LoginScreen());
            } else {
              MyToasts().errorToast(toast: busesListModel?.message.toString());
            }
          }
        }
      }
      if (loader == 1) {
        Loader.hd();
      }
      update();
    } finally {
      Loader.hd();
    }
  }

  addBuses() async {
    final hasInternet = await checkInternets();
    try {
      Loader.sw();

      Map<String, dynamic> data = Map<String, dynamic>();

      data["bus_number"] = "${busC.text}";
      data["status"] = "${selectedBusStatus}";
      if (selectedBusType == Str.scheme) {
        data["bus_location"] = "is_scheme";
      } else {
        data["bus_location"] = "is_nagar";
      }

      successModel = await BusesProvider().addBuses(data);
      if (successModel != null) {
        if (successModel?.status == true) {
          await getBusesList(loader: 1);
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

  editBuses(String? id, {String? busesStatus}) async {
    final hasInternet = await checkInternets();
    try {
      Loader.sw();

      Map<String, dynamic> data = Map<String, dynamic>();

      data["id"] = "${id ?? ""}";
      if (busesStatus == "") {
        data["bus_number"] = "${busC.text}";
        /*if (selectedBusType == Str.scheme) {
          data["bus_location"] = "is_scheme";
        } else {
          data["bus_location"] = "is_nagar";
        }*/
      } else {
        data["status"] = "${busesStatus ?? ""}";
      }

      successModel = await BusesProvider().editBuses(data);
      if (successModel != null) {
        if (successModel?.status == true) {
          await getBusesList(loader: 0);
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

  getActiveBusesList({int? loader, String? status}) async {
    final hasInternet = await checkInternets();
    try {
      busesList.clear();
      if (loader == 1) {
        Loader.sw();
      }

      Map<String, dynamic> data = Map<String, dynamic>();

      data["status"] = "${status}";

      busesListModel = await BusesProvider().getBusesList(data);
      if (busesListModel != null) {
        if (busesListModel?.status == true) {
          busesListForAdd.clear();
          busesListForAdd.addAll(busesListModel!.data!);
          print(busesListForAdd.length);
          update();
        } else {
          if (hasInternet == true) {
            MyToasts().errorToast(toast: busesListModel?.message.toString());
          }
        }
      }
      if (loader == 1) {
        Loader.hd();
      }
      update();
    } finally {
      Loader.hd();
    }
  }

  Future deleteBuses({String? id}) async {
    final hasInternet = await checkInternets();
    try {
      Loader.sw();

      Map<String, dynamic> data = Map<String, dynamic>();
      data["id"] = "${id ?? ""}";

      successModel = await BusesProvider().deleteBuses(data);
      if (successModel != null) {
        if (successModel?.status == true) {
          await getBusesList(loader: 0);
          Get.back();
          update();
          return true;
        } else {
          if (hasInternet == true) {
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
