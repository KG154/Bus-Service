import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shuttleservice/controller/home/buses_tab_controller.dart';
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

class BusesTabScreen extends StatelessWidget {
  const BusesTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusesTabController>(
      init: BusesTabController(),
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
                  "BUSES",
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
                      controller.busC.clear();
                      controller.selectedBusStatus = null;
                      controller.selectedBusType = null;
                      busesAddEditBottomSheet(context, controller: controller, addBuses: Str.addBus);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 4.w),
                      child: SvgPicture.asset(AstSVG.add_ic, width: 10.w, height: 10.w),
                    ),
                  ),
                ],
              ),
              body: SmartRefresher(
                controller: controller.busCController,
                onRefresh: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  controller.searchC.clear();
                  controller.getBusesList(loader: 0);
                  Future.delayed(Duration(milliseconds: 200), () {
                    controller.busCController.refreshCompleted();
                  });
                },
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 0.5.h),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 14.w,
                        child: MyTextField(
                          prefixIcon: Container(
                            padding: EdgeInsets.all(2.5.w),
                            child: SvgPicture.asset(AstSVG.search_ic, color: Clr.textFieldHintClr),
                          ),
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
                                          controller.busses = controller.busesList.length;
                                          controller.active = null;
                                        }
                                        controller.filterbusesList.clear();
                                        if (controller.isSelected == true)
                                          for (int i = 0; i < controller.busesList.length; i++) {
                                            if (controller.busesList[i].status?.toLowerCase() == "active") {
                                              controller.busses = controller.busses + 1;
                                              controller.filterbusesList.add(controller.busesList[i]);
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
                                          controller.busses = controller.busesList.length;
                                          controller.active = null;
                                        }
                                        controller.filterbusesList.clear();
                                        if (controller.isSelected1 == true)
                                          for (int i = 0; i < controller.busesList.length; i++) {
                                            if (controller.busesList[i].status?.toLowerCase() == "inactive") {
                                              controller.busses = controller.busses + 1;
                                              controller.filterbusesList.add(controller.busesList[i]);
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
                      controller.busesListModel?.data?.length != 0
                          ? controller.active != null
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: controller.filterbusesList.length,
                                  itemBuilder: (context, index) {
                                    if (controller.filterbusesList[index].busNumber.toString().toLowerCase().contains(controller.searchC.text.toLowerCase())) {
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
                                                    controller.filterbusesList[index].busNumber ?? "",
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
                                                        color: controller.filterbusesList[index].status == "inactive" ? Clr.inactiveBgClr : Clr.activeBgClr,
                                                        borderRadius: BorderRadius.circular(2.54.w),
                                                      ),
                                                      child: Text(
                                                        controller.filterbusesList[index].status == "inactive" ? Str.inactive : Str.active,
                                                        style: TextStyle(
                                                          fontSize: 10.5.sp,
                                                          color: controller.filterbusesList[index].status == "inactive" ? Clr.inactiveClr : Clr.activeClr,
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
                                                                        controller.busC.clear();
                                                                        // controller.selectedBusType = null;
                                                                        controller.busC.text = controller.filterbusesList[index].busNumber.toString();
                                                                        // controller.selectedBusType = controller.filterbusesList[index].sidetype;
                                                                        /*if (controller.selectedBusType == "is_nagar") {
                                                                          controller.selectedBusType = Str.nagar;
                                                                        } else {
                                                                          controller.selectedBusType = Str.scheme;
                                                                        }*/
                                                                        String id = controller.filterbusesList[index].id.toString();
                                                                        busesAddEditBottomSheet(context, controller: controller, addBuses: Str.editBus, id: id);
                                                                      },
                                                                      dense: true,
                                                                      minVerticalPadding: 0,
                                                                      contentPadding: EdgeInsets.zero,
                                                                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                                                      title: Text(
                                                                        "Edit",
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
                                                                          textTitle: "Are you sure you want to delete this buses?",
                                                                          onPressed: () async {
                                                                            String id = controller.filterbusesList[index].id.toString();
                                                                            await controller.deleteBuses(id: id);
                                                                            controller.update();
                                                                            /*.then((value) {
                                                                              if (value == true) {
                                                                                controller.filterbusesList.remove(controller.filterbusesList[index]);
                                                                                controller.busesList.remove(controller.busesList[index]);
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
                                                                        await controller.editBuses(controller.filterbusesList[index].id.toString(), busesStatus: controller.filterbusesList[index].status == "active" ? "inactive" : "active");
                                                                        controller.update();
                                                                      },
                                                                      dense: true,
                                                                      minVerticalPadding: 0,
                                                                      contentPadding: EdgeInsets.zero,
                                                                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                                                      title: Text(
                                                                        controller.filterbusesList[index].status == "active" ? Str.inactive : Str.active,
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
                                              )
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
                                  itemCount: controller.busesList.length,
                                  itemBuilder: (context, index) {
                                    if (controller.busesList[index].busNumber.toString().toLowerCase().contains(controller.searchC.text.toLowerCase())) {
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
                                                    controller.busesList[index].busNumber ?? "",
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
                                                      decoration: BoxDecoration(color: controller.busesList[index].status == "inactive" ? Clr.inactiveBgClr : Clr.activeBgClr, borderRadius: BorderRadius.circular(2.54.w)),
                                                      child: Text(
                                                        controller.busesList[index].status == "inactive" ? Str.inactive : Str.active,
                                                        style: TextStyle(fontSize: 10.5.sp, color: controller.busesList[index].status == "inactive" ? Clr.inactiveClr : Clr.activeClr, fontWeight: FontWeight.w500),
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
                                                                        controller.busC.clear();
                                                                        // controller.selectedBusType = null;
                                                                        controller.busC.text = controller.busesList[index].busNumber.toString();
                                                                        // controller.selectedBusType = controller.busesList[index].sidetype;
                                                                        // if (controller.selectedBusType == "is_nagar") {
                                                                        //   controller.selectedBusType = Str.nagar;
                                                                        // } else {
                                                                        //   controller.selectedBusType = Str.scheme;
                                                                        // }

                                                                        // controller.selectedBusStatus = controller.busesList[index].status.toString();
                                                                        String id = controller.busesList[index].id.toString();
                                                                        busesAddEditBottomSheet(context, controller: controller, addBuses: Str.editBus, id: id);
                                                                      },
                                                                      dense: true,
                                                                      minVerticalPadding: 0,
                                                                      contentPadding: EdgeInsets.zero,
                                                                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                                                      title: Text(
                                                                        "Edit",
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
                                                                          textTitle: "Are you sure you want to delete this buses?",
                                                                          onPressed: () async {
                                                                            String id = controller.busesList[index].id.toString();
                                                                            await controller.deleteBuses(id: id);
                                                                            controller.update();
                                                                            /*.then((value) {
                                                                              if (value == true) {
                                                                                controller.busesList.remove(controller.busesList[index]);
                                                                                controller.filterbusesList.remove(controller.filterbusesList[index]);
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
                                                                        await controller.editBuses(controller.busesList[index].id.toString(), busesStatus: controller.busesList[index].status == "active" ? "inactive" : "active");
                                                                        controller.update();
                                                                      },
                                                                      dense: true,
                                                                      minVerticalPadding: 0,
                                                                      contentPadding: EdgeInsets.zero,
                                                                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                                                      title: Text(
                                                                        controller.busesList[index].status == "active" ? Str.inactive : Str.active,
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
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return SizedBox();
                                    }
                                  },
                                )
                          : Container(
                              constraints: BoxConstraints(maxWidth: 80.w),
                              child: Center(
                                child: Text(
                                  "No Data",
                                  style: TextStyle(color: Clr.textFieldHintClr2, fontWeight: FontWeight.w400, height: 1.2, fontSize: 15.sp),
                                ),
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

  busesAddEditBottomSheet(BuildContext context, {required BusesTabController controller, required String addBuses, String? id}) {
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
                                child: Text(
                                  addBuses == Str.addBus ? Str.addBus : Str.editBus,
                                  style: TextStyle(fontSize: 13.sp, color: Clr.textFieldTextClr, fontWeight: FontWeight.w600),
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
                      userSText(text: Str.busNumber),
                      MyTextField(
                        padding: EdgeInsets.zero,
                        fillColor: Clr.textFieldBgClr,
                        controller: controller.busC,
                        keyboardType: TextInputType.text,
                        inputFormat: Validate.nameFormat,
                        validate: Validate.nameVal,
                        onChanged: (_) {
                          controller.update();
                        },
                        hintText: Str.eBusNumber,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return Validate.busNoEmpty;
                          }
                          return null;
                        },
                        border: borderInput,
                        focusBorder: focusBorderInput,
                        errorBorder: errorBoarderInput,
                        inputTextStyle: inputTextStyle,
                        hintTextStyle: hintTextStyle,
                      ),
                      addBuses == Str.addBus ? userSText(text: Str.busStatus) : SizedBox(),
                      addBuses == Str.addBus
                          ? MyDropDown(
                              contentPadding: EdgeInsets.only(bottom: 3.5.w, left: 0.w),
                              hintText: Str.select,
                              itemList: controller.busStatus,
                              selectedValue: controller.selectedBusStatus,
                              validatorText: "    ${Validate.bStatusEmptyValidator}",
                              onChange: (value) {
                                controller.selectedBusStatus = value.toString();
                                controller.update();
                              },
                            )
                          : SizedBox(),
                      addBuses == Str.addBus ? userSText(text: "Type") : SizedBox(),
                      addBuses == Str.addBus
                          ? MyDropDown(
                              hintText: Str.select,
                              contentPadding: EdgeInsets.only(bottom: 3.5.w, left: 0.w),
                              itemList: controller.busType,
                              selectedValue: controller.selectedBusType,
                              validatorText: "    ${Validate.bTypeEmptyValidator}",
                              onChange: (value) {
                                controller.selectedBusType = value.toString();
                                controller.update();
                              },
                            )
                          : SizedBox(),
                      SizedBox(height: 3.w),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: MyButton(
                            width: 62.w,
                            title: addBuses == Str.addBus ? Str.addBus : "Submit",
                            onClick: () async {
                              controller.submitted = true;
                              if (controller.formKey.currentState!.validate()) {
                                addBuses == Str.addBus ? print("Add Bus / ${controller.selectedBusStatus.toString()}") : print("Edit Bus");
                                addBuses == Str.addBus ? await controller.addBuses() : await controller.editBuses(id, busesStatus: "");
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
