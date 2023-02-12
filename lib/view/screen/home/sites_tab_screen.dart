import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shuttleservice/controller/home/sites_tab_controller.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/utils/assets.dart';
import 'package:shuttleservice/view/utils/color.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/bottomsheet.dart';
import 'package:shuttleservice/view/widget/button.dart';
import 'package:shuttleservice/view/widget/dropdown.dart';
import 'package:shuttleservice/view/widget/textfields.dart';
import 'package:shuttleservice/view/widget/widgets.dart';

class SitesTabScreen extends StatelessWidget {
  const SitesTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SitesTabController>(
      init: SitesTabController(),
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: KeyboardDismisser(
            gestures: [GestureType.onTap, GestureType.onPanUpdateAnyDirection],
            child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 17.81.w,
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Text(
                  "SITES",
                  style: TextStyle(fontSize: 18.sp),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      print("Tap");
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      controller.submitted = false;
                      controller.nameC.clear();
                      controller.selectedSiteType = null;
                      showAddEditBottomSheet(context, addSite: Str.addSite, controller: controller);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 4.w),
                      child: SvgPicture.asset(
                        AstSVG.add_ic,
                        width: 10.w,
                        height: 10.w,
                      ),
                    ),
                  ),
                ],
              ),
              body: SmartRefresher(
                controller: controller.siteController,
                onRefresh: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  controller.searchC.clear();
                  controller.getSiteList(loader: 0);
                  Future.delayed(Duration(milliseconds: 200), () {
                    controller.siteController.refreshCompleted();
                  });
                },
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 0.5.h),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 14.w,
                        child: MyTextField(
                          prefixIcon: Container(padding: EdgeInsets.all(2.5.w), child: SvgPicture.asset(AstSVG.search_ic, color: Clr.textFieldHintClr)),
                          hintSize: 11.5.sp,
                          fontSize: 11.5.sp,
                          borderRadius: 3.w,
                          cursorHeight: 18,
                          isCollapsed: false,
                          isDense: true,
                          padding: EdgeInsets.only(top: 1.5.w),
                          controller: controller.searchC,
                          fillColor: Clr.whiteClr,
                          textInputAction: TextInputAction.done,
                          hintText: Str.searchStr,
                          validate: Validate.nameVal,
                          keyboardType: TextInputType.name,
                          inputFormat: Validate.nameFormat,
                          onChanged: (val) {
                            controller.update();
                          },
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          border: borderInput,
                          focusBorder: focusBorderInput,
                          inputTextStyle: TextStyle(fontWeight: FontWeight.w600, color: Clr.tabTextClr, height: 1.2, fontSize: 11.sp),
                          hintTextStyle: TextStyle(color: Clr.textFieldHintClr2, fontWeight: FontWeight.w400, height: 1.2, fontSize: 11.sp),
                        ),
                      ),
                      SizedBox(height: 3.5.w),
                      Padding(
                        padding: EdgeInsets.only(left: 1.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        FocusScopeNode currentFocus = FocusScope.of(context);
                                        controller.busses = 0;
                                        controller.update();
                                        if (!currentFocus.hasPrimaryFocus) {
                                          currentFocus.unfocus();
                                        }
                                        controller.isSelected = !controller.isSelected!;
                                        print(controller.isSelected.toString());
                                        if (controller.isSelected == true) {
                                          controller.isSelected1 = false;
                                          controller.active = true;
                                        } else {
                                          controller.active = false;
                                        }
                                        if (controller.isSelected1 == false && controller.isSelected == false) {
                                          controller.busses = 0;
                                          controller.busses = controller.siteList.length;
                                          controller.active = null;
                                        }
                                        controller.filterSiteList.clear();
                                        if (controller.isSelected == true)
                                          for (int i = 0; i < controller.siteList.length; i++) {
                                            if (controller.siteList[i].status?.toLowerCase() == "active") {
                                              controller.busses = controller.busses + 1;
                                              controller.filterSiteList.add(controller.siteList[i]);
                                            }
                                          }
                                        controller.update();
                                      },
                                      child: Container(
                                        width: 5.w,
                                        height: 5.w,
                                        alignment: Alignment.center,
                                        child: controller.isSelected! ? SvgPicture.asset(AstSVG.unCheckbox_ic) : SvgPicture.asset(AstSVG.checkbox_ic),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text(
                                      Str.active,
                                      style: TextStyle(color: Clr.lgTextClr, fontWeight: FontWeight.w500, fontSize: 12.sp),
                                    )
                                  ],
                                ),
                                SizedBox(width: 3.w),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        FocusScopeNode currentFocus = FocusScope.of(context);
                                        controller.busses = 0;
                                        controller.update();
                                        if (!currentFocus.hasPrimaryFocus) {
                                          currentFocus.unfocus();
                                        }
                                        controller.isSelected1 = !controller.isSelected1!;
                                        if (controller.isSelected == true) {
                                          controller.isSelected = false;
                                          controller.active = true;
                                        } else {
                                          controller.active = false;
                                        }
                                        if (controller.isSelected1 == false && controller.isSelected == false) {
                                          controller.busses = 0;
                                          controller.busses = controller.siteList.length;
                                          controller.active = null;
                                        }
                                        controller.filterSiteList.clear();
                                        if (controller.isSelected1 == true)
                                          for (int i = 0; i < controller.siteList.length; i++) {
                                            if (controller.siteList[i].status?.toLowerCase() == "inactive") {
                                              controller.busses = controller.busses + 1;
                                              controller.filterSiteList.add(controller.siteList[i]);
                                            }
                                          }
                                        controller.update();
                                      },
                                      child: Container(
                                        width: 5.w,
                                        height: 5.w,
                                        alignment: Alignment.center,
                                        child: controller.isSelected1! ? SvgPicture.asset(AstSVG.unCheckbox_ic) : SvgPicture.asset(AstSVG.checkbox_ic),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text(
                                      Str.inactive,
                                      style: TextStyle(color: Clr.lgTextClr, fontWeight: FontWeight.w500, fontSize: 12.sp),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Showing Result : ${controller.busses.toString()}",
                                  style: TextStyle(color: Clr.lgTextClr, fontWeight: FontWeight.w500, fontSize: 9.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.w),
                      controller.siteListModel?.data?.length != 0
                          ? controller.active != null
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: controller.filterSiteList.length,
                                  itemBuilder: (context, index) {
                                    if (controller.filterSiteList[index].name.toString().toLowerCase().contains(controller.searchC.text.toLowerCase())) {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 1.8.w),
                                        child: Container(
                                          height: 14.w,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Clr.whiteClr,
                                            border: Border.all(width: 0.25.w, color: Clr.borderClr),
                                            borderRadius: BorderRadius.circular(2.54.w),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 4.w),
                                                  child: Text(
                                                    controller.filterSiteList[index].name ?? "",
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(fontSize: 12.5.sp, color: Clr.tabTextClr, fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: 4.32.w, right: 1.w),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 17.w,
                                                      height: 6.w,
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color: controller.filterSiteList[index].status == "inactive" ? Clr.inactiveBgClr : Clr.activeBgClr,
                                                        borderRadius: BorderRadius.circular(2.54.w),
                                                      ),
                                                      child: Text(
                                                        controller.filterSiteList[index].status == "inactive" ? Str.inactive : Str.active,
                                                        style: TextStyle(
                                                          fontSize: 10.5.sp,
                                                          color: controller.filterSiteList[index].status == "inactive" ? Clr.inactiveClr : Clr.activeClr,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 3.w, right: 1.w),
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
                                                                        controller.submitted = false;
                                                                        controller.nameC.clear();
                                                                        controller.selectedSiteType = null;
                                                                        controller.nameC.text = controller.filterSiteList[index].name.toString();
                                                                        controller.selectedSiteType = controller.filterSiteList[index].sidetype;
                                                                        if (controller.selectedSiteType == "is_nagar") {
                                                                          controller.selectedSiteType = Str.nagar;
                                                                        } else {
                                                                          controller.selectedSiteType = Str.scheme;
                                                                        }
                                                                        String id = controller.filterSiteList[index].id.toString();
                                                                        showAddEditBottomSheet(context, controller: controller, addSite: Str.editSite, id: id);
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
                                                                    padding: EdgeInsets.only(top: 1.w, bottom: 1.w, left: 1.50.w),
                                                                    child: ListTile(
                                                                      onTap: () {
                                                                        print("Delete");
                                                                        Get.back();
                                                                        deleteDialog(
                                                                          context,
                                                                          textTitle: "Are you sure you want to delete this site?",
                                                                          onPressed: () async {
                                                                            String id = controller.filterSiteList[index].id.toString();
                                                                            await controller.deleteSite(id: id);
                                                                            controller.update();
                                                                            /* .then((value) {
                                                                              if (value == true) {
                                                                                controller.siteList.remove(controller.siteList[index]);
                                                                                controller.update();
                                                                              }
                                                                            });*/
                                                                          },
                                                                        );
                                                                      },
                                                                      dense: true,
                                                                      minVerticalPadding: 0,
                                                                      contentPadding: EdgeInsets.zero,
                                                                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                                                      title: Text(
                                                                        "Delete",
                                                                        style: TextStyle(color: Clr.textFieldTextClr, fontWeight: FontWeight.w600, fontSize: 12.sp),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(width: double.infinity, height: 0.4.w, color: Clr.borderClr),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(top: 1.w, bottom: 2.w, left: 1.50.w),
                                                                    child: ListTile(
                                                                      onTap: () async {
                                                                        print("inactive");
                                                                        await controller.editSite(controller.filterSiteList[index].id.toString(), siteStatus: controller.filterSiteList[index].status == "active" ? "inactive" : "active");
                                                                        controller.update();
                                                                      },
                                                                      dense: true,
                                                                      minVerticalPadding: 0,
                                                                      contentPadding: EdgeInsets.zero,
                                                                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                                                      title: Text(
                                                                        controller.filterSiteList[index].status == "active" ? Str.inactive : Str.active,
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
                                                          child: SvgPicture.asset(
                                                            AstSVG.more_ic,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return SizedBox();
                                    }
                                  },
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: controller.siteList.length,
                                  itemBuilder: (context, index) {
                                    if (controller.siteList[index].name.toString().toLowerCase().contains(controller.searchC.text.toLowerCase())) {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 1.8.w),
                                        child: Container(
                                          height: 14.w,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Clr.whiteClr,
                                            border: Border.all(width: 0.25.w, color: Clr.borderClr),
                                            borderRadius: BorderRadius.circular(2.54.w),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 4.w),
                                                  child: Text(
                                                    controller.siteList[index].name.toString(),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(fontSize: 12.5.sp, color: Clr.tabTextClr, fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: 4.32.w, right: 1.w),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 17.w,
                                                      height: 6.w,
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(color: controller.siteList[index].status == "inactive" ? Clr.inactiveBgClr : Clr.activeBgClr, borderRadius: BorderRadius.circular(2.54.w)),
                                                      child: Text(
                                                        controller.siteList[index].status == "inactive" ? Str.inactive : Str.active,
                                                        style: TextStyle(fontSize: 10.5.sp, color: controller.siteList[index].status == "inactive" ? Clr.inactiveClr : Clr.activeClr, fontWeight: FontWeight.w500),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 3.w, right: 1.w),
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
                                                                        controller.submitted = false;
                                                                        controller.nameC.clear();
                                                                        controller.selectedSiteType = null;
                                                                        controller.nameC.text = controller.siteList[index].name.toString();
                                                                        controller.selectedSiteType = controller.siteList[index].sidetype;
                                                                        if (controller.selectedSiteType == "is_nagar") {
                                                                          controller.selectedSiteType = Str.nagar;
                                                                        } else {
                                                                          controller.selectedSiteType = Str.scheme;
                                                                        }
                                                                        String id = controller.siteList[index].id.toString();
                                                                        showAddEditBottomSheet(context, controller: controller, addSite: Str.editSite, id: id);
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
                                                                    padding: EdgeInsets.only(top: 1.w, bottom: 1.w, left: 1.50.w),
                                                                    child: ListTile(
                                                                      onTap: () {
                                                                        print("Delete");
                                                                        Get.back();
                                                                        deleteDialog(
                                                                          context,
                                                                          textTitle: "Are you sure you want to delete this site?",
                                                                          onPressed: () async {
                                                                            String id = controller.siteList[index].id.toString();
                                                                            await controller.deleteSite(id: id);
                                                                            controller.update();
                                                                            /* .then((value) {
                                                                              if (value == true) {
                                                                                controller.siteList.remove(controller.siteList[index]);
                                                                                controller.update();
                                                                              }
                                                                            });*/
                                                                          },
                                                                        );
                                                                      },
                                                                      dense: true,
                                                                      minVerticalPadding: 0,
                                                                      contentPadding: EdgeInsets.zero,
                                                                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                                                      title: Text(
                                                                        "Delete",
                                                                        style: TextStyle(color: Clr.textFieldTextClr, fontWeight: FontWeight.w600, fontSize: 12.sp),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(width: double.infinity, height: 0.4.w, color: Clr.borderClr),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(top: 1.w, bottom: 2.w, left: 1.50.w),
                                                                    child: ListTile(
                                                                      onTap: () async {
                                                                        print("inactive");
                                                                        await controller.editSite(controller.siteList[index].id.toString(), siteStatus: controller.siteList[index].status == "active" ? "inactive" : "active");
                                                                        controller.update();
                                                                      },
                                                                      dense: true,
                                                                      minVerticalPadding: 0,
                                                                      contentPadding: EdgeInsets.zero,
                                                                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                                                      title: Text(
                                                                        controller.siteList[index].status == "active" ? Str.inactive : Str.active,
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
                                                          child: SvgPicture.asset(
                                                            AstSVG.more_ic,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return SizedBox();
                                    }
                                  },
                                )
                          : Center(
                              child: Text(
                                "No Data",
                                style: TextStyle(color: Clr.textFieldHintClr2, fontWeight: FontWeight.w400, height: 1.2, fontSize: 15.sp),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  showAddEditBottomSheet(BuildContext context, {required SitesTabController controller, required String addSite, String? id}) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Clr.bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(7.63.w), topRight: Radius.circular(7.63.w)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setSta) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.071.w, vertical: 2.54.w),
                child: Form(
                  autovalidateMode: controller.submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 0.5.w, bottom: 3.5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5.w),
                                  child: Text(
                                    addSite == Str.addSite ? Str.addSite : Str.editSite,
                                    style: TextStyle(fontSize: 13.sp, color: Clr.textFieldTextClr, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 5.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(3.w),
                                  child: SvgPicture.asset(AstSVG.close_ic, color: Clr.textFieldHintClr),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      userSText(text: "Site"),
                      MyTextField(
                        padding: EdgeInsets.zero,
                        fillColor: Clr.textFieldBgClr,
                        controller: controller.nameC,
                        keyboardType: TextInputType.text,
                        inputFormat: Validate.nameFormat,
                        validate: Validate.nameVal,
                        textInputAction: TextInputAction.done,
                        onChanged: (_) {
                          controller.update();
                        },
                        hintText: Str.eSite,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return Validate.siteEmptyValidator;
                          }
                          return null;
                        },
                        border: borderInput,
                        focusBorder: focusBorderInput,
                        errorBorder: errorBoarderInput,
                        inputTextStyle: inputTextStyle,
                        hintTextStyle: hintTextStyle,
                      ),
                      userSText(text: "Type"),
                      MyDropDown(
                        hintText: Str.select,
                        contentPadding: EdgeInsets.only(bottom: 3.5.w, left: 0.w),
                        itemList: controller.siteType,
                        selectedValue: controller.selectedSiteType,
                        validatorText: "    ${Validate.sTypeEmptyValidator}",
                        onChange: (value) {
                          controller.selectedSiteType = value.toString();
                          controller.update();
                        },
                      ),
                      SizedBox(height: 3.w),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: MyButton(
                            width: 62.w,
                            title: addSite == Str.addSite ? Str.addSite : "Submit",
                            onClick: () async {
                              controller.submitted = true;
                              if (controller.formKey.currentState!.validate()) {
                                addSite == Str.addSite ? print("Add Site") : print("Edit Site");
                                addSite == Str.addSite ? await controller.addSite() : await controller.editSite(id, siteStatus: "");
                                controller.update();
                              }
                              controller.update();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
