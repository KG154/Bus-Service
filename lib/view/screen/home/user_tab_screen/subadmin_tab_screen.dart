import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shuttleservice/controller/home/users_tab_controller.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/screen/home/add_user_screen.dart';
import 'package:shuttleservice/view/utils/assets.dart';
import 'package:shuttleservice/view/utils/color.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/bottomsheet.dart';
import 'package:shuttleservice/view/widget/widgets.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SubAdminTabScreen extends StatelessWidget {
  const SubAdminTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsersTabController>(
      init: UsersTabController(),
      initState: (state) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            body: SmartRefresher(
              controller: controller.subAController,
              onRefresh: () {
                controller.getUsersList(type: "sub_admin", loader: 0);
                controller.getUsersList(type: "site_manager", loader: 0);
                Future.delayed(Duration(milliseconds: 200), () {
                  controller.subAController.refreshCompleted();
                });
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 3.5.w, right: 3.5.w, top: 3.w),
                  child: controller.subAdminList.length != 0
                      ? ListView.builder(
                          itemCount: controller.subAdminList.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (controller.subAdminList[index].userName.toString().toLowerCase().contains(controller.searchC.text.toLowerCase()) || controller.subAdminList[index].emailId.toString().toLowerCase().contains(controller.searchC.text.toLowerCase()) || controller.subAdminList[index].userPhone.toString().toLowerCase().contains(controller.searchC.text.toLowerCase())) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 1.5.w),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(color: Clr.whiteClr, borderRadius: BorderRadius.circular(3.w), border: Border.all(color: Clr.borderClr, width: 0.4.w)),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 3.w, top: 4.07.w, bottom: 2.w),
                                    child: Stack(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  controller.subAdminList[index].userName ?? "",
                                                  style: TextStyle(fontSize: 13.sp, color: Clr.tabTextClr, fontWeight: FontWeight.w600),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 4.32.w, right: 2.w),
                                                  child: InkWell(
                                                    onTap: () {
                                                      FocusScopeNode currentFocus = FocusScope.of(context);
                                                      if (!currentFocus.hasPrimaryFocus) {
                                                        currentFocus.unfocus();
                                                      }
                                                      showCustomBottomSheet(
                                                        context,
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 4.071.w, vertical: 2.54.w),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(top: 2.w, bottom: 1.w, left: 1.50.w),
                                                                child: ListTile(
                                                                  onTap: () {
                                                                    print("Edit");
                                                                    Get.back();
                                                                    Get.to(() => AddUserScreen(user: controller.subAdminList[index], screenName: "EditUser"));
                                                                  },
                                                                  dense: true,
                                                                  minVerticalPadding: 0,
                                                                  contentPadding: EdgeInsets.zero,
                                                                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                                                  title: Text(
                                                                    Str.edit,
                                                                    style: TextStyle(color: Clr.textFieldTextClr, fontWeight: FontWeight.w600, fontSize: 12.sp),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(width: double.infinity, height: 0.4.w, color: Clr.borderClr),
                                                              Padding(
                                                                padding: EdgeInsets.only(top: 1.w, bottom: 2.w, left: 1.50.w),
                                                                child: ListTile(
                                                                  onTap: () async {
                                                                    print("Delete");
                                                                    await controller.editDeleteUser(controller.subAdminList[index].userId.toString(), DeleteStatus: "inactive", type: Str.subAdmin1);
                                                                    controller.update();
                                                                  },
                                                                  dense: true,
                                                                  minVerticalPadding: 0,
                                                                  contentPadding: EdgeInsets.zero,
                                                                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                                                  title: Text(
                                                                    Str.delete,
                                                                    style: TextStyle(color: Clr.textFieldTextClr, fontWeight: FontWeight.w600, fontSize: 12.sp),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      width: 5.5.w,
                                                      height: 5.5.w,
                                                      child: SvgPicture.asset(AstSVG.more_ic),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 2.54.w),
                                            Row(
                                              children: [
                                                SvgPicture.asset(AstSVG.phone_ic),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 2.w),
                                                  child: Text(
                                                    controller.subAdminList[index].userPhone ?? "",
                                                    style: TextStyle(fontSize: 10.sp, color: Clr.bottomTextClr, fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 1.w),
                                            Row(
                                              children: [
                                                SvgPicture.asset(AstSVG.email_ic_2),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 2.w),
                                                  child: Text(
                                                    controller.subAdminList[index].emailId ?? "",
                                                    style: TextStyle(fontSize: 10.sp, color: Clr.bottomTextClr, fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 1.w),
                                            Container(
                                              width: 70.w,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(AstSVG.lock_ic),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: 1.w, left: 2.w),
                                                    child: Text(
                                                      controller.subAdminList[index].password == true ? "${controller.subAdminList[index].userPassword ?? ""}" : "*******",
                                                      style: TextStyle(fontSize: 10.sp, color: Clr.bottomTextClr, fontWeight: FontWeight.w500),
                                                    ),
                                                  ),
                                                  SizedBox(width: 2.w),
                                                  InkWell(
                                                      onTap: () {
                                                        FocusScopeNode currentFocus = FocusScope.of(context);
                                                        if (!currentFocus.hasPrimaryFocus) {
                                                          currentFocus.unfocus();
                                                        }
                                                        if (controller.subAdminList[index].password == false || controller.subAdminList[index].password == null) {
                                                          controller.subAdminList[index].password = true;
                                                          controller.update();
                                                        } else {
                                                          controller.subAdminList[index].password = false;
                                                          controller.update();
                                                        }
                                                        controller.update();
                                                      },
                                                      child: controller.subAdminList[index].password == false ? SvgPicture.asset(AstSVG.eye_slash_ic) : SvgPicture.asset(AstSVG.eye_ic)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 14.w, right: 2.w),
                                            child: InkWell(
                                              onTap: () {
                                                FocusScopeNode currentFocus = FocusScope.of(context);
                                                if (!currentFocus.hasPrimaryFocus) {
                                                  currentFocus.unfocus();
                                                }
                                                launchUrlString('tel:+91 ${controller.subAdminList[index].userPhone}');
                                              },
                                              child: Container(
                                                height: 10.w,
                                                width: 10.w,
                                                child: SvgPicture.asset(AstSVG.call_ic),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return SizedBox();
                            }
                            /*UserCard(
                        context: context,
                        userName: controller.subAdminList[index].userName ?? "",
                        emailId: controller.subAdminList[index].emailId ?? "",
                        userPhone: controller.subAdminList[index].userPhone ?? "",
                        userPassword: controller.subAdminList[index].userPassword ?? "",
                        onTapEdit: () {
                          print("Edit");
                          Get.back();
                          Get.to(() => AddUserScreen(user: controller.subAdminList[index], screenName: "EditUser"));
                        },
                        onTapDelete: () async {
                          print("Delete");
                          await controller.editDeleteUser(controller.subAdminList[index].userId.toString(), DeleteStatus: "inactive", type: Str.subAdmin);
                          controller.update();
                        },
                      );*/
                          },
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: Center(
                            child: noDataWidget(title: "No Data"),
                          ),
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
