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

class SiteManagerTabScreen extends StatelessWidget {
  const SiteManagerTabScreen({Key? key}) : super(key: key);

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
          child: SmartRefresher(
            controller: controller.siteMController,
            onRefresh: () {
              controller.getUsersList(type: "sub_admin", loader: 0);
              controller.getUsersList(type: "site_manager", loader: 0);
              Future.delayed(Duration(milliseconds: 200), () {
                controller.siteMController.refreshCompleted();
              });
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 3.5.w, right: 3.5.w, top: 3.w),
                child: controller.siteManagerList.length != 0
                    ? ListView.builder(
                        itemCount: controller.siteManagerList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (controller.siteManagerList[index].userName.toString().toLowerCase().contains(controller.searchC.text.toLowerCase()) || controller.siteManagerList[index].emailId.toString().toLowerCase().contains(controller.searchC.text.toLowerCase()) || controller.siteManagerList[index].userPhone.toString().toLowerCase().contains(controller.searchC.text.toLowerCase())) {
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
                                                controller.siteManagerList[index].userName ?? "",
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
                                                                  Get.to(() => AddUserScreen(user: controller.siteManagerList[index], screenName: "EditUser"));
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
                                                                  await controller.editDeleteUser(controller.siteManagerList[index].userId.toString(), DeleteStatus: "inactive", type: Str.siteManager1);
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
                                                  controller.siteManagerList[index].userPhone ?? "",
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
                                                  controller.siteManagerList[index].emailId ?? "",
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
                                                    controller.siteManagerList[index].password == true ? "${controller.siteManagerList[index].userPassword ?? ""}" : "*******",
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
                                                      if (controller.siteManagerList[index].password == false || controller.siteManagerList[index].password == null) {
                                                        controller.siteManagerList[index].password = true;
                                                        controller.update();
                                                      } else {
                                                        controller.siteManagerList[index].password = false;
                                                        controller.update();
                                                      }
                                                      controller.update();
                                                    },
                                                    child: controller.siteManagerList[index].password == false ? SvgPicture.asset(AstSVG.eye_slash_ic) : SvgPicture.asset(AstSVG.eye_ic)),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              SvgPicture.asset(AstSVG.trips_ic),
                                              Padding(
                                                padding: EdgeInsets.only(left: 2.w, top: 1.5.w),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Start Site : ${controller.siteManagerList[index].startSiteName ?? " "}",
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(fontSize: 10.sp, color: Clr.bottomTextClr, fontWeight: FontWeight.w500),
                                                    ),
                                                    SizedBox(height: 1.w),
                                                    Text(
                                                      "End Site    : ${controller.siteManagerList[index].endSiteName ?? " "}",
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(fontSize: 10.sp, color: Clr.bottomTextClr, fontWeight: FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 1.w),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 24.w, right: 2.w),
                                          child: InkWell(
                                            onTap: () {
                                              FocusScopeNode currentFocus = FocusScope.of(context);
                                              if (!currentFocus.hasPrimaryFocus) {
                                                currentFocus.unfocus();
                                              }
                                              launchUrlString('tel:+91 ${controller.siteManagerList[index].userPhone}');
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
                        userName: controller.siteManagerList[index].userName ?? "",
                        emailId: controller.siteManagerList[index].emailId ?? "",
                        userPhone: controller.siteManagerList[index].userPhone ?? "",
                        userPassword: controller.siteManagerList[index].userPassword ?? "",
                        onTapEdit: () {
                          print("Edit");
                          Get.back();
                          Get.to(() => AddUserScreen(screenName: "EditUser", user: controller.siteManagerList[index]));
                        },
                        onTapDelete: () async {
                          print("Delete");
                          await controller.editDeleteUser(controller.siteManagerList[index].userId.toString(), DeleteStatus: "inactive", type: Str.siteManager);
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
        );
      },
    );
  }
}
