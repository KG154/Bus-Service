import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shuttleservice/module/model/auth/login_model.dart';
import 'package:shuttleservice/module/model/home/site_list_model.dart';
import 'package:shuttleservice/module/model/success_model.dart';
import 'package:shuttleservice/module/provider/home/site_tab_provider.dart';
import 'package:shuttleservice/services/internet_service.dart';
import 'package:shuttleservice/view/screen/auth/login_screen.dart';
import 'package:shuttleservice/view/utils/loader.dart';
import 'package:shuttleservice/view/utils/shared_preference.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/toasts.dart';

class SitesTabController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController searchC = TextEditingController();
  RefreshController siteController = RefreshController(initialRefresh: false);
  TextEditingController nameC = TextEditingController();
  bool submitted = false;
  int busses = 0;
  bool? isSelected = false;
  bool? isSelected1 = false;
  bool? active = false;

  String? selectedSiteType;
  List siteType = [Str.scheme, Str.nagar];

  // Models
  SuccessModel? successModel;
  SiteListModel? siteListModel;
  SiteListData? selectedSSite;
  SiteListData? selectedESite;

  List<SiteListData> siteList = [];
  List<SiteListData> siteListForAdd = [];
  List<SiteListData> filterSiteList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    getSiteList(loader: 1);
    if (isSelected1 == false && isSelected == false) {
      active = null;
    }
    super.onInit();
  }

  getSiteList({String? status, int? loader}) async {
    final hasInternet = await checkInternets();
    try {
      if (loader == 1) {
        Loader.sw();
      }
      LoginUserData? userModel = await Storage.getUser();

      Map<String, dynamic> data = Map<String, dynamic>();
      if (status != null) {
        data["status"] = "${status}";
      }

      siteListModel = await SiteProvider().getSiteList(
        userModel?.userId.toString(),
        userModel?.token.toString(),
        data,
      );
      if (siteListModel != null) {
        if (siteListModel?.status == true) {
          isSelected1 = false;
          isSelected = false;
          filterSiteList.clear();
          siteList.clear();
          siteList.addAll(siteListModel!.data!);
          filterSiteList.addAll(siteListModel!.data!);
          print(siteList.length);
          busses = siteList.length;
          update();
          // MyToasts().successToast(toast: siteListModel?.message.toString());
        } else {
          if (hasInternet == true) {
            if (siteListModel!.message == "Sign in failed.") {
              print("logInModel == ${siteListModel?.message.toString()}");
              MyToasts().errorToast(toast: siteListModel?.message.toString());
              Storage.clearData();
              update();
              Get.offAll(() => LoginScreen());
            } else {
              MyToasts().errorToast(toast: siteListModel?.message.toString());
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

  addSite() async {
    final hasInternet = await checkInternets();
    try {
      Loader.sw();

      Map<String, dynamic> data = Map<String, dynamic>();
      data["name"] = nameC.text.toString();
      if (selectedSiteType == Str.scheme) {
        data["sidetype"] = "is_scheme";
      } else {
        data["sidetype"] = "is_nagar";
      }

      successModel = await SiteProvider().addSite(data);
      if (successModel != null) {
        if (successModel?.status == true) {
          await getSiteList(loader: 0);
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

  editSite(String? id, {String? siteStatus}) async {
    final hasInternet = await checkInternets();
    try {
      Loader.sw();

      Map<String, dynamic> data = Map<String, dynamic>();

      data["id"] = "${id ?? ""}";
      if (siteStatus == "") {
        data["name"] = nameC.text.toString();
        if (selectedSiteType == Str.scheme) {
          data["sidetype"] = "is_scheme";
        } else {
          data["sidetype"] = "is_nagar";
        }
      } else {
        data["status"] = "${siteStatus ?? ""}";
      }

      successModel = await SiteProvider().editSite(data);
      if (successModel != null) {
        if (successModel?.status == true) {
          await getSiteList(loader: 0);
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

  getSiteListForAdd({String? status, int? loader}) async {
    final hasInternet = await checkInternets();
    try {
      siteListForAdd.clear();
      if (loader == 1) {
        Loader.sw();
      }
      LoginUserData? userModel = await Storage.getUser();

      Map<String, dynamic> data = Map<String, dynamic>();
      if (status != null) {
        data["status"] = "${status}";
      }

      siteListModel = await SiteProvider().getSiteList(
        userModel?.userId.toString(),
        userModel?.token.toString(),
        data,
      );
      if (siteListModel != null) {
        if (siteListModel?.status == true) {
          siteListForAdd.clear();
          siteListForAdd.addAll(siteListModel!.data!);
          print(siteListForAdd.length);
          update();
          // MyToasts().successToast(toast: siteListModel?.message.toString());
        } else {
          if (hasInternet == true) {
            MyToasts().errorToast(toast: siteListModel?.message.toString());
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

  Future deleteSite({String? id}) async {
    final hasInternet = await checkInternets();
    try {
      Loader.sw();

      Map<String, dynamic> data = Map<String, dynamic>();
      data["id"] = "${id ?? ""}";

      successModel = await SiteProvider().deleteSite(data);
      if (successModel != null) {
        if (successModel?.status == true) {
          await getSiteList(loader: 0);
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
