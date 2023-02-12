import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shuttleservice/controller/home/sites_tab_controller.dart';
import 'package:shuttleservice/module/model/home/users_list_model.dart';
import 'package:shuttleservice/module/model/success_model.dart';
import 'package:shuttleservice/module/provider/home/user_tab_provider.dart';
import 'package:shuttleservice/services/internet_service.dart';
import 'package:shuttleservice/view/utils/loader.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/toasts.dart';

class UsersTabController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RefreshController siteMController = RefreshController(initialRefresh: false);
  RefreshController subAController = RefreshController(initialRefresh: false);

  SitesTabController sitesTabController = Get.put(SitesTabController());

  TextEditingController searchC = TextEditingController();
  TextEditingController uNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneNoC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  TextEditingController searchC2 = TextEditingController();
  TextEditingController searchC3 = TextEditingController();
  TextEditingController startSiteC = TextEditingController();
  TextEditingController endSiteC = TextEditingController();

  TabController? tabController;
  RxInt initValue = 0.obs;
  bool submitted = false;
  bool showPassword = true;
  String? selectedUserType;

  // String? selectedSSite;
  // String? selectedESite;
  List<String> selected = [];
  List userType = [Str.subAdmin1, Str.siteManager1];
  List<String> userAccess = [Str.trips, Str.buses, Str.sites, Str.users];

  // List startSiteType = ["Site A", "Site AB"];
  // List endSiteType = ["Site c", "Site D"];

  bool search1 = false;
  bool search2 = false;
  List filteredStartSite = [];
  List filteredSite = [];
  String? fromId;
  int? endId;

  showPassClick() {
    showPassword = !showPassword;
    update();
  }

  bool showPassword1 = true;
  bool showPassword2 = true;

  showPassClick1(int index) {
    showPassword1 = !showPassword1;
    update();
  }

  showPassClick2() {
    showPassword2 = !showPassword2;
    update();
  }

  @override
  Future<void> onInit() async {
    await getUsersList(type: "sub_admin", loader: 1);
    await getUsersList(type: "site_manager", loader: 0);
    await sitesTabController.getSiteListForAdd(status: "active", loader: 0);
    // TODO: implement onInit
    super.onInit();
  }

  // Models
  SuccessModel? successModel;
  UsersListModel? usersListModel;
  List<UsersListData> subAdminList = [];
  List<UsersListData> siteManagerList = [];

  getUsersList({String? type, int? loader}) async {
    final hasInternet = await checkInternets();
    try {
      if (loader == 1) {
        Loader.sw();
      }

      Map<String, dynamic> data = Map<String, dynamic>();
      data["user_type"] = "${type ?? ""}";

      usersListModel = await UsersProvider().getUsersList(data);
      if (usersListModel != null) {
        if (usersListModel?.status == true) {
          if (type == "sub_admin") {
            subAdminList.clear();
            subAdminList.addAll(usersListModel!.data!);
            print("subAdminList = ${subAdminList.length}");
            update();
          } else {
            siteManagerList.clear();
            siteManagerList.addAll(usersListModel!.data!);
            print("siteManagerList = ${siteManagerList.length}");
            update();
          }
          update();
        } else {
          if (hasInternet == true) {
            MyToasts().errorToast(toast: usersListModel?.message.toString());
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

  addUsers({String? startId, int? endId}) async {
    final hasInternet = await checkInternets();
    try {
      Loader.sw();
      Map<String, dynamic> data = Map<String, dynamic>();
      if (selectedUserType == Str.subAdmin1) {
        data["user_type"] = Str.sub_Admin;
      } else {
        data["user_type"] = Str.site_Manager;
      }

      if (selectedUserType == Str.siteManager1) {
        data["start_site_id"] = "${startId}";
        data["end_site_id"] = "${endId}";
      } else {
        data["user_access"] = selected.toString().replaceAll("[", "").replaceAll("]", "");
      }

      data["user_name"] = "${uNameC.text}";
      data["user_phone"] = "${phoneNoC.text}";
      data["email_id"] = "${emailC.text}";
      data["user_password"] = "${passwordC.text}";

      successModel = await UsersProvider().addUsers(data);
      if (successModel != null) {
        if (successModel?.status == true) {
          MyToasts().successToast(toast: successModel?.message.toString());
          await getUsersList(type: "sub_admin", loader: 1);
          await getUsersList(type: "site_manager", loader: 1);
          update();
          /*if (selectedUserType == Str.subAdmin) {
            await getUsersList(type: "sub_admin", loader: 1);
            update();
          } else {
            await getUsersList(type: "site_manager", loader: 1);
            update();
          }*/
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

  editDeleteUser(String? id, {String? DeleteStatus, required String type, String? startId, int? endId}) async {
    final hasInternet = await checkInternets();
    try {
      Loader.sw();

      Map<String, dynamic> data = Map<String, dynamic>();

      data["user_id"] = "${id ?? ""}";
      if (DeleteStatus == "") {
        if (selectedUserType == Str.subAdmin1) {
          data["user_type"] = Str.sub_Admin;
        } else {
          data["user_type"] = Str.site_Manager;
        }
        if (selectedUserType == Str.siteManager1) {
          data["start_site_id"] = "${startId}";
          data["end_site_id"] = "${endId}";
        } else {
          data["user_access"] = selected.toString().replaceAll("[", "").replaceAll("]", "");
        }
        data["user_name"] = "${uNameC.text}";
        data["user_phone"] = "${phoneNoC.text}";
        data["email_id"] = "${emailC.text}";
        data["user_password"] = "${passwordC.text}";
      } else {
        data["status"] = "${DeleteStatus ?? ""}";
      }

      successModel = await UsersProvider().editUser(data);
      if (successModel != null) {
        if (successModel?.status == true) {
          await getUsersList(type: "sub_admin", loader: 1);
          await getUsersList(type: "site_manager", loader: 1);
          update();
          /*if (selectedUserType == Str.subAdmin) {
            await getUsersList(type: "sub_admin", loader: 1);
            update();
          } else if (selectedUserType == Str.siteManager) {
            await getUsersList(type: "site_manager", loader: 1);
            update();
          }*/
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
