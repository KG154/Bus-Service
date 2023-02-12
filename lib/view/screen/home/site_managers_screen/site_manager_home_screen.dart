import 'dart:developer';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shuttleservice/controller/home/site_managers_controller/site_manager_home_screen_controller.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/screen/home/edit_profile_screen.dart';
import 'package:shuttleservice/view/screen/home/site_managers_screen/home_tab_screen/end_trip_tab_screen.dart';
import 'package:shuttleservice/view/screen/home/site_managers_screen/home_tab_screen/endtrip_search_screen.dart';
import 'package:shuttleservice/view/screen/home/site_managers_screen/home_tab_screen/start_trips_tab_screen.dart';
import 'package:shuttleservice/view/screen/home/site_managers_screen/home_tab_screen/starttrip_search_screen.dart';
import 'package:shuttleservice/view/utils/assets.dart';
import 'package:shuttleservice/view/utils/color.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/shared_preference.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/button.dart';
import 'package:shuttleservice/view/widget/textfields.dart';
import 'package:shuttleservice/view/widget/widgets.dart';

class SiteManagerHomeScreen extends StatefulWidget {
  const SiteManagerHomeScreen({Key? key}) : super(key: key);

  @override
  State<SiteManagerHomeScreen> createState() => _SiteManagerHomeScreenState();
}

class _SiteManagerHomeScreenState extends State<SiteManagerHomeScreen> with SingleTickerProviderStateMixin {
  SiteMHomeScreenController siteMHomeScreenController = Get.put(SiteMHomeScreenController());
  TabController? tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  getData() async {
    siteMHomeScreenController.versionDialog(context);
    siteMHomeScreenController.userModel = await Storage.getUser();
    siteMHomeScreenController.loginDate = DateFormat("dd MMM yyyy").format(DateTime.parse(siteMHomeScreenController.userModel!.createdAt.toString()));
    siteMHomeScreenController.update();
    siteMHomeScreenController.dateC.text = DateFormat('dd MMM yyyy').format(siteMHomeScreenController.selectedDate);
    siteMHomeScreenController.startDate = DateFormat('yyyy-MM-dd').format(siteMHomeScreenController.selectedDate);
    siteMHomeScreenController.update();
    await siteMHomeScreenController.startTripList(status: "", loader: 1, startDate: siteMHomeScreenController.startDate);
    await siteMHomeScreenController.endTripList(loader: 1, startDate: siteMHomeScreenController.startDate);
    tabController = await new TabController(length: 2, vsync: this, initialIndex: 0);
    tabController?.addListener(() {
      log(tabController!.index.toString(), name: "Trip index");
      siteMHomeScreenController.update();
    });
    await siteMHomeScreenController.busesTabController.getBusesList(loader: 0);
    await siteMHomeScreenController.sitesTabController.getSiteList(loader: 0);
    // await startTripList(status: "end_site", loader: 0, startDate: startDate);
    siteMHomeScreenController.update();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SiteMHomeScreenController>(
      init: SiteMHomeScreenController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 17.81.w,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Clr.primaryClr.withOpacity(0.3),
                  child: Text(
                    controller.userModel?.userName.toString().split(" ")[0][0] ?? "",
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: Clr.primaryClr),
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            controller.userModel?.userName.toString() ?? "",
                            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Clr.textFieldTextClr),
                          ),
                          SizedBox(width: 3.w),
                          GestureDetector(
                              onTap: () {
                                Get.to(() => EditProfileScreen(type: "site_manager"))?.then((value) async {
                                  controller.userModel = await Storage.getUser();
                                  controller.update();
                                });
                              },
                              child: SvgPicture.asset(AstSVG.edit, height: 5.w)),
                        ],
                      ),
                      Text(
                        controller.loginDate.toString(),
                        style: TextStyle(fontSize: 10.5.sp, fontWeight: FontWeight.w500, color: Clr.lgTextClr),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (tabController?.index == 0) {
                          Get.to(() => StartTripSearchScreen());
                        } else {
                          Get.to(() => EndTripSearchScreen());
                        }
                        // Get.to(() => SearchScreen());
                        controller.update();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 3.w),
                        child: SvgPicture.asset(AstSVG.search, width: 11.5.w, height: 11.5.w),
                      ),
                    ),
                    GestureDetector(
                        onTap: () async {
                          print("Log Out");
                          logOutDialog(context, controller.dashboardTabController);
                          controller.update();
                        },
                        child: SvgPicture.asset(AstSVG.logout_ic)),
                  ],
                )
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 0.5.h),
            child: DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 13.w,
                          child: MyTextField(
                            onTap: () async {
                              final values = await calender(
                                context,
                                config,
                                initialValue: controller.dialogCalendarPickerValue,
                                selectableDayPredicate: (day) => !day.difference(controller.dialogCalendarPickerValue[0]!.subtract(Duration(days: 120))).isNegative,
                              );
                              if (values != null) {
                                controller.dialogCalendarPickerValue = values;
                                controller.startDate = values.first.toString();
                                controller.endDate = values.last.toString();
                                if (values.isNotEmpty) {
                                  if (values.length == 1) {
                                    controller.dateC.text = DateFormat("dd MMM yyyy").format(DateTime.parse(controller.startDate.toString()));
                                    await controller.startTripList(status: "", loader: 1, startDate: controller.startDate.toString());
                                    await controller.endTripList(loader: 0, startDate: controller.startDate.toString());
                                    // await controller.startTripList(status: "end_site", loader: 0, startDate: controller.startDate.toString());
                                    controller.update();
                                  } else {
                                    if (DateTime.parse(controller.endDate.toString()).difference(DateTime.parse(controller.startDate.toString())).inDays == 0) {
                                      controller.dateC.text = DateFormat("dd MMM yyyy").format(DateTime.parse(controller.startDate.toString()));
                                      await controller.startTripList(status: "", loader: 1, startDate: controller.startDate.toString());
                                      await controller.endTripList(loader: 0, startDate: controller.startDate.toString());
                                      // await controller.startTripList(status: "end_site", loader: 0, startDate: controller.startDate.toString());
                                      controller.update();
                                    } else {
                                      controller.dateC.text = "${DateFormat("dd MMM yyyy").format(DateTime.parse(controller.startDate.toString()))} to ${DateFormat("dd MMM yyyy").format(DateTime.parse(controller.endDate.toString()))}";
                                      await controller.startTripList(status: "", loader: 1, startDate: controller.startDate.toString(), endDate: controller.endDate.toString());
                                      await controller.endTripList(loader: 0, startDate: controller.startDate.toString(), endDate: controller.endDate.toString());
                                      // await controller.startTripList(status: "end_site", loader: 0, startDate: controller.startDate.toString(), endDate: controller.endDate.toString());
                                      controller.update();
                                    }
                                  }
                                }
                                controller.update();
                              }
                            },
                            prefixIcon: Container(
                              padding: EdgeInsets.all(2.w),
                              child: Image.asset(Ast.calendar, color: Clr.textFieldHintClr),
                            ),
                            readOnly: true,
                            isCollapsed: false,
                            isDense: true,
                            padding: EdgeInsets.only(top: 1.5.w),
                            controller: controller.dateC,
                            fillColor: Clr.whiteClr,
                            textInputAction: TextInputAction.done,
                            hintText: Str.searchStr,
                            validate: Validate.nameVal,
                            keyboardType: TextInputType.name,
                            inputFormat: Validate.nameFormat,
                            onChanged: (val) {
                              controller.update();
                            },
                            borderColor: Clr.borderClr,
                            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            focusBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.50.w, color: Clr.borderClr), borderRadius: BorderRadius.circular(2.5.w)),
                            border: OutlineInputBorder(borderSide: BorderSide(width: 0.50.w, color: Clr.borderClr), borderRadius: BorderRadius.circular(2.5.w)),
                            inputTextStyle: TextStyle(fontWeight: FontWeight.w600, color: Clr.tabTextClr, height: 1.2, fontSize: 12.sp),
                          ),
                        ),
                      ),
                      SizedBox(width: 1.h),
                      GestureDetector(
                        onTap: () async {
                          final values = await calender(
                            context,
                            config,
                            initialValue: controller.dialogCalendarPickerValue,
                            selectableDayPredicate: (day) => !day.difference(controller.dialogCalendarPickerValue[0]!.subtract(Duration(days: 120))).isNegative,
                          );
                          if (values != null) {
                            controller.dialogCalendarPickerValue = values;
                            controller.startDate = values.first.toString();
                            controller.endDate = values.last.toString();
                            if (values.isNotEmpty) {
                              if (values.length == 1) {
                                controller.dateC.text = DateFormat("dd MMM yyyy").format(DateTime.parse(controller.startDate.toString()));
                                await controller.startTripList(status: "", loader: 1, startDate: controller.startDate.toString());
                                await controller.endTripList(loader: 0, startDate: controller.startDate.toString());
                                // await controller.startTripList(status: "end_site", loader: 0, startDate: controller.startDate.toString());
                                controller.update();
                              } else {
                                if (DateTime.parse(controller.endDate.toString()).difference(DateTime.parse(controller.startDate.toString())).inDays == 0) {
                                  controller.dateC.text = DateFormat("dd MMM yyyy").format(DateTime.parse(controller.startDate.toString()));
                                  await controller.startTripList(status: "", loader: 1, startDate: controller.startDate.toString());
                                  await controller.endTripList(loader: 0, startDate: controller.startDate.toString());
                                  // await controller.startTripList(status: "end_site", loader: 0, startDate: controller.startDate.toString());
                                  controller.update();
                                } else {
                                  controller.dateC.text = "${DateFormat("dd MMM yyyy").format(DateTime.parse(controller.startDate.toString()))} to ${DateFormat("dd MMM yyyy").format(DateTime.parse(controller.endDate.toString()))}";
                                  await controller.startTripList(status: "", loader: 1, startDate: controller.startDate.toString(), endDate: controller.endDate.toString());
                                  await controller.endTripList(loader: 0, startDate: controller.startDate.toString(), endDate: controller.endDate.toString());
                                  // await controller.startTripList(status: "end_site", loader: 0, startDate: controller.startDate.toString(), endDate: controller.endDate.toString());
                                  controller.update();
                                }
                              }
                            }
                            controller.update();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 1.5.w),
                          child: SizedBox(height: 11.11.w, width: 11.11.w, child: SvgPicture.asset(AstSVG.calendar_ic)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.w),
                  Padding(
                    padding: EdgeInsets.only(top: 2.w, bottom: 2.w),
                    child: Text(
                      "Filter by",
                      style: TextStyle(fontWeight: FontWeight.w600, color: Clr.textFieldTextClr, fontSize: 12.sp),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MyTextField(
                          padding: EdgeInsets.zero,
                          readOnly: true,
                          controller: controller.busNumFilterC,
                          keyboardType: TextInputType.text,
                          inputFormat: Validate.nameFormat,
                          validate: Validate.nameVal,
                          suffixIconConstraints: BoxConstraints(maxWidth: 40),
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 2.w),
                            child: SvgPicture.asset(AstSVG.dropDownArrow_ic, color: Clr.textFieldHintClr),
                          ),
                          onChanged: (val) {
                            controller.update();
                          },
                          onTap: () {
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            controller.searchC.clear();
                            showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(7.63.w), topRight: Radius.circular(7.63.w)),
                              ),
                              builder: (BuildContext context) {
                                return SafeArea(
                                  child: StatefulBuilder(builder: (context, setSta) {
                                    return SingleChildScrollView(
                                      padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 3.w),
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                        child: Container(
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
                                                    if (val.isNotEmpty) {
                                                      controller.searchBusFilter = true;
                                                      controller.update();
                                                      setSta(() {});
                                                    } else {
                                                      controller.searchBusFilter = false;
                                                      controller.update();
                                                      setSta(() {});
                                                    }
                                                    controller.filteredBuses.clear();
                                                    for (int index = 0; index < controller.busesTabController.busesList.length; index++) {
                                                      if ("${controller.busesTabController.busesList[index].busNumber}".toLowerCase().contains(controller.searchC.text.toLowerCase())) {
                                                        controller.filteredBuses.add(controller.busesTabController.busesList[index]);
                                                      }
                                                    }
                                                    print(controller.filteredBuses.length);
                                                    setSta(() {});
                                                  },
                                                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                  border: borderInput,
                                                  focusBorder: focusBorderInput,
                                                  inputTextStyle: TextStyle(fontWeight: FontWeight.w600, color: Clr.tabTextClr, height: 1.2, fontSize: 11.sp),
                                                  hintTextStyle: TextStyle(color: Clr.textFieldHintClr2, fontWeight: FontWeight.w400, height: 1.2, fontSize: 11.sp),
                                                ),
                                              ),
                                              controller.busesTabController.busesList.length != 0 && controller.searchC.text.isEmpty
                                                  ? Container(
                                                      height: 50.h,
                                                      child: SingleChildScrollView(
                                                        child: ListView.builder(
                                                            shrinkWrap: true,
                                                            physics: NeverScrollableScrollPhysics(),
                                                            itemCount: controller.busesTabController.busesList.length,
                                                            itemBuilder: (context, i) {
                                                              return settingListTile(
                                                                selected: controller.busNumFilterC.text == controller.busesTabController.busesList[i].busNumber.toString(),
                                                                onTap: () async {
                                                                  controller.busNumFilterC.text = controller.busesTabController.busesList[i].busNumber.toString();
                                                                  controller.busFilterId = controller.busesTabController.busesList[i].id;
                                                                  Get.back();
                                                                  setSta(() {});
                                                                  if (controller.startDate != null && controller.endDate != null) {
                                                                    String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                                                                    String endDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.endDate.toString()))}";
                                                                    await siteMHomeScreenController.startTripList(status: "", loader: 1, startDate: startDate1, endDate: endDate1, busid: controller.busFilterId);
                                                                    await siteMHomeScreenController.endTripList(loader: 0, startDate: startDate1, endDate: endDate1, busid: controller.busFilterId);
                                                                  } else {
                                                                    String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                                                                    await siteMHomeScreenController.startTripList(status: "", loader: 1, startDate: startDate1, busid: controller.busFilterId);
                                                                    await siteMHomeScreenController.endTripList(loader: 0, startDate: startDate1, busid: controller.busFilterId);
                                                                  }
                                                                  controller.update();
                                                                },
                                                                name: controller.busesTabController.busesList[i].busNumber.toString(),
                                                              );
                                                            }),
                                                      ),
                                                    )
                                                  : controller.filteredBuses.length != 0
                                                      ? SizedBox(
                                                          height: 50.h,
                                                          child: SingleChildScrollView(
                                                            child: ListView.builder(
                                                              shrinkWrap: true,
                                                              physics: NeverScrollableScrollPhysics(),
                                                              itemBuilder: (context, index) {
                                                                return settingListTile(
                                                                  selected: controller.busNumFilterC.text == controller.filteredBuses[index].busNumber.toString(),
                                                                  onTap: () async {
                                                                    controller.busNumFilterC.text = controller.filteredBuses[index].busNumber.toString();
                                                                    controller.busFilterId = controller.filteredBuses[index].id;
                                                                    Get.back();
                                                                    setSta(() {});
                                                                    if (controller.startDate != null && controller.endDate != null) {
                                                                      String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                                                                      String endDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.endDate.toString()))}";
                                                                      await siteMHomeScreenController.startTripList(status: "", loader: 1, startDate: startDate1, endDate: endDate1, busid: controller.busFilterId);
                                                                      await siteMHomeScreenController.endTripList(loader: 0, startDate: startDate1, endDate: endDate1, busid: controller.busFilterId);
                                                                    } else {
                                                                      String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                                                                      await siteMHomeScreenController.startTripList(status: "", loader: 1, startDate: startDate1, busid: controller.busFilterId);
                                                                      await siteMHomeScreenController.endTripList(loader: 0, startDate: startDate1, busid: controller.busFilterId);
                                                                    }
                                                                    controller.update();
                                                                  },
                                                                  name: controller.filteredBuses[index].busNumber.toString(),
                                                                );
                                                              },
                                                              itemCount: controller.filteredBuses.length,
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          constraints: BoxConstraints(maxWidth: 80.w, maxHeight: 96.w),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                "No Data",
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(color: Clr.textFieldHintClr2, fontWeight: FontWeight.w400, height: 1.2, fontSize: 20.sp),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              },
                            );
                          },
                          hintText: "Select Buses",
                          border: borderInput,
                          focusBorder: borderInput,
                          errorBorder: errorBoarderInput,
                          enableBorder: borderInput,
                          inputTextStyle: TextStyle(fontWeight: FontWeight.w500, color: Clr.tabTextClr, fontSize: 8.sp),
                          hintTextStyle: TextStyle(fontWeight: FontWeight.w400, color: Clr.textFieldHintClr2, fontSize: 8.sp),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: MyTextField(
                          padding: EdgeInsets.zero,
                          readOnly: true,
                          controller: controller.startSiteFilterC,
                          keyboardType: TextInputType.text,
                          inputFormat: Validate.nameFormat,
                          validate: Validate.nameVal,
                          suffixIconConstraints: BoxConstraints(maxWidth: 40),
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 2.w),
                            child: SvgPicture.asset(AstSVG.dropDownArrow_ic, color: Clr.textFieldHintClr),
                          ),
                          onChanged: (val) {
                            controller.update();
                          },
                          onTap: () {
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            controller.searchC2.clear();
                            showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(7.63.w), topRight: Radius.circular(7.63.w)),
                              ),
                              builder: (BuildContext context) {
                                return SafeArea(
                                  child: StatefulBuilder(builder: (context, setSta) {
                                    return SingleChildScrollView(
                                      padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 3.w),
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                        child: Container(
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
                                                  controller: controller.searchC2,
                                                  fillColor: Clr.whiteClr,
                                                  textInputAction: TextInputAction.done,
                                                  hintText: Str.searchStr,
                                                  validate: Validate.nameVal,
                                                  keyboardType: TextInputType.name,
                                                  inputFormat: Validate.nameFormat,
                                                  onChanged: (val) {
                                                    if (val.isNotEmpty) {
                                                      controller.searchFromFilter = true;
                                                      controller.update();
                                                      setSta(() {});
                                                    } else {
                                                      controller.searchFromFilter = false;
                                                      controller.update();
                                                      setSta(() {});
                                                    }
                                                    controller.filteredStartSite.clear();
                                                    for (int index = 0; index < controller.sitesTabController.siteList.length; index++) {
                                                      if ("${controller.sitesTabController.siteList[index].name}".toLowerCase().contains(controller.searchC2.text.toLowerCase())) {
                                                        controller.filteredStartSite.add(controller.sitesTabController.siteList[index]);
                                                      }
                                                    }
                                                    print(controller.filteredStartSite.length);
                                                    setSta(() {});
                                                  },
                                                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                  border: borderInput,
                                                  focusBorder: focusBorderInput,
                                                  inputTextStyle: TextStyle(fontWeight: FontWeight.w600, color: Clr.tabTextClr, height: 1.2, fontSize: 11.sp),
                                                  hintTextStyle: TextStyle(color: Clr.textFieldHintClr2, fontWeight: FontWeight.w400, height: 1.2, fontSize: 11.sp),
                                                ),
                                              ),
                                              controller.sitesTabController.siteList.length != 0 && controller.searchC2.text.isEmpty
                                                  ? Container(
                                                      height: 50.h,
                                                      child: SingleChildScrollView(
                                                        child: ListView.builder(
                                                            shrinkWrap: true,
                                                            physics: NeverScrollableScrollPhysics(),
                                                            itemCount: controller.sitesTabController.siteList.length,
                                                            itemBuilder: (context, i) {
                                                              return settingListTile(
                                                                selected: controller.startSiteFilterC.text == controller.sitesTabController.siteList[i].name.toString(),
                                                                onTap: () async {
                                                                  controller.startSiteFilterC.text = controller.sitesTabController.siteList[i].name.toString();
                                                                  controller.fromFilterId = controller.sitesTabController.siteList[i].id;
                                                                  Get.back();
                                                                  setSta(() {});
                                                                  if (controller.startDate != null && controller.endDate != null) {
                                                                    String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                                                                    String endDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.endDate.toString()))}";
                                                                    await siteMHomeScreenController.startTripList(status: "", loader: 1, startDate: startDate1, endDate: endDate1, startId: controller.fromFilterId);
                                                                    await siteMHomeScreenController.endTripList(loader: 0, startDate: startDate1, endDate: endDate1, startId: controller.fromFilterId);
                                                                  } else {
                                                                    String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                                                                    await siteMHomeScreenController.startTripList(status: "", loader: 1, startDate: startDate1, startId: controller.fromFilterId);
                                                                    await siteMHomeScreenController.endTripList(loader: 0, startDate: startDate1, startId: controller.fromFilterId);
                                                                  }
                                                                  controller.update();
                                                                },
                                                                name: controller.sitesTabController.siteList[i].name.toString(),
                                                              );
                                                            }),
                                                      ),
                                                    )
                                                  : controller.filteredStartSite.length != 0
                                                      ? SizedBox(
                                                          height: 50.h,
                                                          child: SingleChildScrollView(
                                                            child: ListView.builder(
                                                              shrinkWrap: true,
                                                              physics: NeverScrollableScrollPhysics(),
                                                              itemBuilder: (context, index) {
                                                                return settingListTile(
                                                                  selected: controller.startSiteFilterC.text == controller.filteredStartSite[index].name.toString(),
                                                                  onTap: () async {
                                                                    controller.startSiteFilterC.text = controller.filteredStartSite[index].name.toString();
                                                                    controller.fromFilterId = controller.filteredStartSite[index].id;
                                                                    Get.back();
                                                                    setSta(() {});
                                                                    if (controller.startDate != null && controller.endDate != null) {
                                                                      String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                                                                      String endDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.endDate.toString()))}";
                                                                      await siteMHomeScreenController.startTripList(status: "", loader: 1, startDate: startDate1, endDate: endDate1, startId: controller.fromFilterId);
                                                                      await siteMHomeScreenController.endTripList(loader: 0, startDate: startDate1, endDate: endDate1, startId: controller.fromFilterId);
                                                                    } else {
                                                                      String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                                                                      await siteMHomeScreenController.startTripList(status: "", loader: 1, startDate: startDate1, startId: controller.fromFilterId);
                                                                      await siteMHomeScreenController.endTripList(loader: 0, startDate: startDate1, startId: controller.fromFilterId);
                                                                    }
                                                                    controller.update();
                                                                  },
                                                                  name: controller.filteredStartSite[index].name.toString(),
                                                                );
                                                              },
                                                              itemCount: controller.filteredStartSite.length,
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          constraints: BoxConstraints(maxWidth: 80.w, maxHeight: 96.w),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                "No Data",
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(color: Clr.textFieldHintClr2, fontWeight: FontWeight.w400, height: 1.2, fontSize: 20.sp),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              },
                            );
                          },
                          hintText: "Select Site",
                          border: borderInput,
                          focusBorder: borderInput,
                          errorBorder: errorBoarderInput,
                          enableBorder: borderInput,
                          inputTextStyle: TextStyle(fontWeight: FontWeight.w500, color: Clr.tabTextClr, fontSize: 8.sp),
                          hintTextStyle: TextStyle(fontWeight: FontWeight.w400, color: Clr.textFieldHintClr2, fontSize: 8.sp),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: MyTextField(
                          padding: EdgeInsets.zero,
                          readOnly: true,
                          controller: controller.endSiteFilterC,
                          keyboardType: TextInputType.text,
                          inputFormat: Validate.nameFormat,
                          validate: Validate.nameVal,
                          suffixIconConstraints: BoxConstraints(maxWidth: 40),
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 2.w),
                            child: SvgPicture.asset(AstSVG.dropDownArrow_ic, color: Clr.textFieldHintClr),
                          ),
                          onChanged: (val) {
                            controller.update();
                          },
                          onTap: () {
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            controller.searchC3.clear();
                            showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(7.63.w), topRight: Radius.circular(7.63.w)),
                              ),
                              builder: (BuildContext context) {
                                return SafeArea(
                                  child: StatefulBuilder(builder: (context, setSta) {
                                    return SingleChildScrollView(
                                      padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 3.w),
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                        child: Container(
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
                                                  controller: controller.searchC3,
                                                  fillColor: Clr.whiteClr,
                                                  textInputAction: TextInputAction.done,
                                                  hintText: Str.searchStr,
                                                  validate: Validate.nameVal,
                                                  keyboardType: TextInputType.name,
                                                  inputFormat: Validate.nameFormat,
                                                  onChanged: (val) {
                                                    if (val.isNotEmpty) {
                                                      controller.searchEndFilter = true;
                                                      controller.update();
                                                      setSta(() {});
                                                    } else {
                                                      controller.searchEndFilter = false;
                                                      controller.update();
                                                      setSta(() {});
                                                    }
                                                    controller.filteredSite.clear();
                                                    for (int index = 0; index < controller.sitesTabController.siteList.length; index++) {
                                                      if ("${controller.sitesTabController.siteList[index].name}".toLowerCase().contains(controller.searchC3.text.toLowerCase())) {
                                                        controller.filteredSite.add(controller.sitesTabController.siteList[index]);
                                                      }
                                                    }
                                                    print(controller.filteredSite.length);
                                                    setSta(() {});
                                                  },
                                                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                  border: borderInput,
                                                  focusBorder: focusBorderInput,
                                                  inputTextStyle: TextStyle(fontWeight: FontWeight.w600, color: Clr.tabTextClr, height: 1.2, fontSize: 11.sp),
                                                  hintTextStyle: TextStyle(color: Clr.textFieldHintClr2, fontWeight: FontWeight.w400, height: 1.2, fontSize: 11.sp),
                                                ),
                                              ),
                                              controller.sitesTabController.siteList.length != 0 && controller.searchC3.text.isEmpty
                                                  ? Container(
                                                      height: 50.h,
                                                      child: SingleChildScrollView(
                                                        child: ListView.builder(
                                                            shrinkWrap: true,
                                                            physics: NeverScrollableScrollPhysics(),
                                                            itemCount: controller.sitesTabController.siteList.length,
                                                            itemBuilder: (context, i) {
                                                              return settingListTile(
                                                                selected: controller.endSiteFilterC.text == controller.sitesTabController.siteList[i].name.toString(),
                                                                onTap: () async {
                                                                  controller.endSiteFilterC.text = controller.sitesTabController.siteList[i].name.toString();
                                                                  controller.endFilterId = controller.sitesTabController.siteList[i].id;
                                                                  Get.back();
                                                                  setSta(() {});
                                                                  if (controller.startDate != null && controller.endDate != null) {
                                                                    String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                                                                    String endDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.endDate.toString()))}";
                                                                    await siteMHomeScreenController.startTripList(status: "", loader: 1, startDate: startDate1, endDate: endDate1, endId: controller.endFilterId);
                                                                    await siteMHomeScreenController.endTripList(loader: 0, startDate: startDate1, endDate: endDate1, endId: controller.endFilterId);
                                                                  } else {
                                                                    String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                                                                    await siteMHomeScreenController.startTripList(status: "", loader: 1, startDate: startDate1, endId: controller.endFilterId);
                                                                    await siteMHomeScreenController.endTripList(loader: 0, startDate: startDate1, endId: controller.endFilterId);
                                                                  }
                                                                  controller.update();
                                                                },
                                                                name: controller.sitesTabController.siteList[i].name.toString(),
                                                              );
                                                            }),
                                                      ),
                                                    )
                                                  : controller.filteredSite.length != 0
                                                      ? SizedBox(
                                                          height: 50.h,
                                                          child: SingleChildScrollView(
                                                            child: ListView.builder(
                                                              shrinkWrap: true,
                                                              physics: NeverScrollableScrollPhysics(),
                                                              itemBuilder: (context, index) {
                                                                return settingListTile(
                                                                  selected: controller.endSiteFilterC.text == controller.filteredSite[index].name.toString(),
                                                                  onTap: () async {
                                                                    controller.endSiteFilterC.text = controller.filteredSite[index].name.toString();
                                                                    controller.endFilterId = controller.filteredSite[index].id;
                                                                    Get.back();
                                                                    setSta(() {});
                                                                    if (controller.startDate != null && controller.endDate != null) {
                                                                      String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                                                                      String endDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.endDate.toString()))}";
                                                                      await siteMHomeScreenController.startTripList(status: "", loader: 1, startDate: startDate1, endDate: endDate1, endId: controller.endFilterId);
                                                                      await siteMHomeScreenController.endTripList(loader: 0, startDate: startDate1, endDate: endDate1, endId: controller.endFilterId);
                                                                    } else {
                                                                      String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                                                                      await siteMHomeScreenController.startTripList(status: "", loader: 1, startDate: startDate1, endId: controller.endFilterId);
                                                                      await siteMHomeScreenController.endTripList(loader: 0, startDate: startDate1, endId: controller.endFilterId);
                                                                    }
                                                                    controller.update();
                                                                  },
                                                                  name: controller.filteredSite[index].name.toString(),
                                                                );
                                                              },
                                                              itemCount: controller.filteredSite.length,
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          constraints: BoxConstraints(maxWidth: 80.w, maxHeight: 96.w),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                "No Data",
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(color: Clr.textFieldHintClr2, fontWeight: FontWeight.w400, height: 1.2, fontSize: 20.sp),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              },
                            );
                          },
                          hintText: "Select Site",
                          border: borderInput,
                          focusBorder: borderInput,
                          errorBorder: errorBoarderInput,
                          enableBorder: borderInput,
                          inputTextStyle: TextStyle(fontWeight: FontWeight.w500, color: Clr.tabTextClr, fontSize: 8.sp),
                          hintTextStyle: TextStyle(fontWeight: FontWeight.w400, color: Clr.textFieldHintClr2, fontSize: 8.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.w),
                  Text(
                    "TRIPS",
                    style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600, color: Clr.textFieldTextClr),
                  ),
                  SizedBox(height: 1.5.w),
                  Container(
                    height: 8.w,
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1, color: Clr.borderClr)),
                    ),
                    child: TabBar(
                      controller: tabController,
                      indicatorColor: Clr.primaryClr,
                      isScrollable: false,
                      labelColor: Clr.primaryClr,
                      labelStyle: TextStyle(color: Clr.primaryClr, fontWeight: FontWeight.w600, fontSize: 12.sp),
                      unselectedLabelColor: Clr.textFieldHintClr,
                      unselectedLabelStyle: TextStyle(color: Clr.textFieldHintClr, fontWeight: FontWeight.w400, fontSize: 12.sp),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 0.51.w,
                      tabs: [
                        Tab(text: Str.sTrips),
                        Tab(text: Str.eTrips),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.5.w),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        StartTripTabScreen(),
                        EndTripTabScreen(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
