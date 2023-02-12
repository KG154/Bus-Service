import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shuttleservice/controller/home/trips_tab_controller.dart';
import 'package:shuttleservice/module/model/home/buses_list_model.dart';
import 'package:shuttleservice/module/model/home/site_list_model.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/screen/home/search_screen.dart';
import 'package:shuttleservice/view/utils/assets.dart';
import 'package:shuttleservice/view/utils/color.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/tableview.dart';
import 'package:shuttleservice/view/widget/textfields.dart';
import 'package:shuttleservice/view/widget/widgets.dart';

class TripsTabScreen extends StatelessWidget {
  const TripsTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripsTabController>(
      init: TripsTabController(),
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 17.81.w,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text(
                "TRIPS",
                style: TextStyle(fontSize: 18.sp),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => SearchScreen());
                    controller.update();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 4.w),
                    child: SvgPicture.asset(AstSVG.search, width: 10.w, height: 10.w),
                  ),
                ),
              ],
            ),
            body: SmartRefresher(
              controller: controller.tripController,
              onRefresh: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                controller.searchC.clear();
                controller.busNumFilterC.clear();
                controller.startSiteFilterC.clear();
                controller.endSiteFilterC.clear();
                controller.busesTabController.selectedBuses = null;
                controller.sitesTabController.selectedSSite = null;
                controller.sitesTabController.selectedESite = null;
                // controller.dateC.text = DateFormat('dd MMM yyyy').format(controller.selectedDate);
                controller.update();
                print(controller.startDate.toString());
                print(controller.endDate.toString());

                if (controller.startDate != null && controller.endDate != null) {
                  String startDate = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                  String endDate = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.endDate.toString()))}";
                  controller.adminTripList(loader: 0, startDate: startDate, endDate: endDate);
                } else {
                  String startDate = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                  controller.adminTripList(loader: 0, startDate: startDate);
                }

                Future.delayed(Duration(milliseconds: 200), () {
                  controller.tripController.refreshCompleted();
                });
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 0.5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*SizedBox(
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
                          controller.filterListData.clear();
                          controller.busses = 0;
                          controller.update();
                          for (int i = 0; i < controller.TripListData.length; i++) {
                            if (controller.TripListData[i].fromDate!.toLowerCase().contains(val) || controller.TripListData[i].busNumber!.toLowerCase().contains(val) || controller.TripListData[i].driveName!.toLowerCase().contains(val) || controller.TripListData[i].busStatusData!.first.fromSiteName!.toLowerCase().contains(val) || controller.TripListData[i].busStatusData!.first.fromUserName!.toLowerCase().contains(val) || controller.TripListData[i].busStatusData!.first.toSiteName!.toLowerCase().contains(val) || controller.TripListData[i].busStatusData!.first.toUserName!.toLowerCase().contains(val)) {
                              controller.busses = controller.busses + 1;
                              controller.filterListData.add(controller.TripListData[i]);
                              controller.update();
                            }
                          }
                          controller.update();
                        },
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        border: borderInput,
                        focusBorder: focusBorderInput,
                        inputTextStyle: TextStyle(fontWeight: FontWeight.w600, color: Clr.tabTextClr, height: 1.2, fontSize: 11.sp),
                        hintTextStyle: TextStyle(color: Clr.textFieldHintClr2, fontWeight: FontWeight.w400, height: 1.2, fontSize: 11.sp),
                      ),
                    ),*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 13.w,
                            child: MyTextField(
                              onTap: () async {
                                FocusScopeNode currentFocus = FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
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
                                      await controller.adminTripList(loader: 0, startDate: DateFormat("yyyy-MM-dd").format(DateTime.parse(controller.startDate.toString())));
                                      controller.update();
                                    } else {
                                      if (DateTime.parse(controller.endDate.toString()).difference(DateTime.parse(controller.startDate.toString())).inDays == 0) {
                                        controller.dateC.text = DateFormat("dd MMM yyyy").format(DateTime.parse(controller.startDate.toString()));
                                        await controller.adminTripList(loader: 0, startDate: DateFormat("yyyy-MM-dd").format(DateTime.parse(controller.startDate.toString())));
                                        controller.update();
                                      } else {
                                        controller.dateC.text = "${DateFormat("dd MMM yyyy").format(DateTime.parse(controller.startDate.toString()))} to ${DateFormat("dd MMM yyyy").format(DateTime.parse(controller.endDate.toString()))}";
                                        await controller.adminTripList(loader: 0, startDate: DateFormat("yyyy-MM-dd").format(DateTime.parse(controller.startDate.toString())), endDate: DateFormat("yyyy-MM-dd").format(DateTime.parse(controller.endDate.toString())));
                                        controller.update();
                                      }
                                    }
                                  }
                                  controller.update();
                                }
                              },
                              prefixIcon: Container(padding: EdgeInsets.all(2.w), child: Image.asset(Ast.calendar, color: Clr.textFieldHintClr)),
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
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
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
                                  await controller.adminTripList(loader: 0, startDate: DateFormat("yyyy-MM-dd").format(DateTime.parse(controller.startDate.toString())));
                                  controller.update();
                                } else {
                                  if (DateTime.parse(controller.endDate.toString()).difference(DateTime.parse(controller.startDate.toString())).inDays == 0) {
                                    controller.dateC.text = DateFormat("dd MMM yyyy").format(DateTime.parse(controller.startDate.toString()));
                                    await controller.adminTripList(loader: 0, startDate: DateFormat("yyyy-MM-dd").format(DateTime.parse(controller.startDate.toString())));
                                    controller.update();
                                  } else {
                                    controller.dateC.text = "${DateFormat("dd MMM yyyy").format(DateTime.parse(controller.startDate.toString()))} to ${DateFormat("dd MMM yyyy").format(DateTime.parse(controller.endDate.toString()))}";
                                    await controller.adminTripList(loader: 0, startDate: DateFormat("yyyy-MM-dd").format(DateTime.parse(controller.startDate.toString())), endDate: DateFormat("yyyy-MM-dd").format(DateTime.parse(controller.endDate.toString())));
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
                                                                      // adminTripList(loader: 1, startDate: startDate1, endDate: endDate1);
                                                                      await controller.adminTripList(startDate: startDate1, endDate: endDate1, loader: 1, busid: controller.busFilterId);
                                                                    } else {
                                                                      String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                                                                      await controller.adminTripList(startDate: startDate1, loader: 1, busid: controller.busFilterId);
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
                                                                        // adminTripList(loader: 1, startDate: startDate1, endDate: endDate1);
                                                                        await controller.adminTripList(startDate: startDate1, endDate: endDate1, loader: 1, busid: controller.busFilterId);
                                                                      } else {
                                                                        String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                                                                        await controller.adminTripList(startDate: startDate1, loader: 1, busid: controller.busFilterId);
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
                            focusBorder: focusBorderInput,
                            errorBorder: errorBoarderInput,
                            enableBorder: borderInput,
                            inputTextStyle: TextStyle(fontWeight: FontWeight.w500, color: Clr.tabTextClr, fontSize: 8.sp),
                            hintTextStyle: TextStyle(fontWeight: FontWeight.w400, color: Clr.textFieldHintClr2, fontSize: 8.sp),
                          ),
                          /*SizedBox(
                            height: 10.w,
                            child: DropdownButtonFormField2<BusesListData?>(
                              alignment: Alignment.centerLeft,
                              dropdownMaxHeight: 80.w,
                              dropdownWidth: 50.w,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 4.w, left: 1.5.w),
                                border: borderInput,
                                focusedBorder: focusBorderInput,
                                errorBorder: errorBoarderInput,
                                enabledBorder: borderInput,
                                hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Clr.textFieldHintClr2, fontSize: 8.sp),
                                filled: true,
                                fillColor: Clr.whiteClr,
                              ),
                              style: TextStyle(fontWeight: FontWeight.w500, color: Clr.tabTextClr, fontSize: 8.sp),
                              isExpanded: true,
                              hint: Text(
                                "Select Buses",
                                style: TextStyle(fontWeight: FontWeight.w400, color: Clr.textFieldHintClr2, fontSize: 8.sp),
                              ),
                              icon: Padding(
                                padding: EdgeInsets.only(right: 2.w),
                                child: SvgPicture.asset(AstSVG.dropDownArrow_ic, color: Clr.textFieldHintClr),
                              ),
                              iconSize: 8.w,
                              buttonHeight: 10.w,
                              value: controller.busesTabController.selectedBuses,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(2.5.w),
                                  bottomRight: Radius.circular(2.5.w),
                                ),
                              ),
                              selectedItemBuilder: (BuildContext context) {
                                return controller.busesTabController.busesList.map((item) {
                                  return Text(item.busNumber ?? "", style: TextStyle(fontWeight: FontWeight.w500, color: Clr.tabTextClr, fontSize: 8.sp));
                                }).toList();
                              },
                              items: controller.busesTabController.busesList
                                  .map((item) => DropdownMenuItem<BusesListData>(
                                        value: item,
                                        onTap: () {
                                          controller.busesTabController.selectedBuses = item;
                                          controller.busesTabController.update();
                                          controller.update();
                                        },
                                        child: Text(
                                          item.busNumber ?? "",
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500,
                                            color: controller.busesTabController.selectedBuses == item ? Clr.primaryClr : Clr.bottomTextClr,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (BusesListData? value) async {
                                controller.busesTabController.selectedBuses = value;
                                print("SelectedBuses = ${controller.busesTabController.selectedBuses?.busNumber.toString()}");
                                if (controller.startDate != null && controller.endDate != null) {
                                  String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                                  String endDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.endDate.toString()))}";
                                  // adminTripList(loader: 1, startDate: startDate1, endDate: endDate1);
                                  await controller.adminTripList(startDate: startDate1, endDate: endDate1, loader: 1, busid: controller.busesTabController.selectedBuses?.id);
                                } else {
                                  String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                                  await controller.adminTripList(startDate: startDate1, loader: 1, busid: controller.busesTabController.selectedBuses?.id);

                                  // adminTripList(loader: 1, startDate: startDate1);
                                }

                                controller.update();
                              },
                              onSaved: (BusesListData? value) {
                                controller.busesTabController.selectedBuses = value;
                              },
                            ),
                          ),*/
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
                                                                      await controller.adminTripList(startDate: startDate1, endDate: endDate1, loader: 1, startId: controller.fromFilterId);
                                                                    } else {
                                                                      String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                                                                      await controller.adminTripList(startDate: startDate1, loader: 1, startId: controller.fromFilterId);
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
                                                                        await controller.adminTripList(startDate: startDate1, endDate: endDate1, loader: 1, startId: controller.fromFilterId);
                                                                      } else {
                                                                        String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                                                                        await controller.adminTripList(startDate: startDate1, loader: 1, startId: controller.fromFilterId);
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
                            focusBorder: focusBorderInput,
                            errorBorder: errorBoarderInput,
                            enableBorder: borderInput,
                            inputTextStyle: TextStyle(fontWeight: FontWeight.w500, color: Clr.tabTextClr, fontSize: 8.sp),
                            hintTextStyle: TextStyle(fontWeight: FontWeight.w400, color: Clr.textFieldHintClr2, fontSize: 8.sp),
                          ),
                          /*SizedBox(
                            height: 10.w,
                            child: DropdownButtonFormField2<SiteListData?>(
                              alignment: Alignment.centerLeft,
                              dropdownMaxHeight: 80.w,
                              dropdownWidth: 50.w,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 4.w, left: 1.5.w),
                                border: borderInput,
                                focusedBorder: focusBorderInput,
                                errorBorder: errorBoarderInput,
                                enabledBorder: borderInput,
                                hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Clr.textFieldHintClr2, fontSize: 8.sp),
                                filled: true,
                                fillColor: Clr.whiteClr,
                              ),
                              style: TextStyle(fontWeight: FontWeight.w500, color: Clr.tabTextClr, fontSize: 8.sp),
                              isExpanded: true,
                              hint: Text(
                                "Start Site",
                                style: TextStyle(fontWeight: FontWeight.w400, color: Clr.textFieldHintClr2, fontSize: 8.sp),
                              ),
                              icon: Padding(
                                padding: EdgeInsets.only(right: 2.w),
                                child: SvgPicture.asset(AstSVG.dropDownArrow_ic, color: Clr.textFieldHintClr),
                              ),
                              iconSize: 8.w,
                              buttonHeight: 10.w,
                              value: controller.sitesTabController.selectedSSite,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(2.5.w),
                                  bottomRight: Radius.circular(2.5.w),
                                ),
                              ),
                              selectedItemBuilder: (BuildContext context) {
                                return controller.sitesTabController.siteList.map((item) {
                                  return Text(item.name ?? "", style: TextStyle(fontWeight: FontWeight.w500, color: Clr.tabTextClr, fontSize: 8.sp));
                                }).toList();
                              },
                              items: controller.sitesTabController.siteList
                                  .map((item) => DropdownMenuItem<SiteListData>(
                                        value: item,
                                        onTap: () {
                                          controller.sitesTabController.selectedSSite = item;
                                          controller.sitesTabController.update();
                                          controller.update();
                                        },
                                        child: Text(
                                          item.name ?? "",
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500,
                                            color: controller.sitesTabController.selectedSSite == item ? Clr.primaryClr : Clr.bottomTextClr,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (SiteListData? value) async {
                                controller.sitesTabController.selectedSSite = value;
                                print("Selected start site = ${controller.sitesTabController.selectedSSite?.name.toString()}");
                                if (controller.startDate != null && controller.endDate != null) {
                                  String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                                  String endDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.endDate.toString()))}";
                                  await controller.adminTripList(startDate: startDate1, endDate: endDate1, loader: 1, startId: controller.sitesTabController.selectedSSite?.id);
                                } else {
                                  String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                                  await controller.adminTripList(startDate: startDate1, loader: 1, startId: controller.sitesTabController.selectedSSite?.id);
                                }
                                // await controller.adminTripList(startDate: DateFormat('yyyy-MM-dd').format(controller.selectedDate), loader: 1, startId: controller.sitesTabController.selectedSSite?.id);
                                controller.update();
                              },
                              onSaved: (SiteListData? value) {
                                controller.sitesTabController.selectedSSite = value;
                              },
                            ),
                          ),*/
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
                                                                      await controller.adminTripList(startDate: startDate1, endDate: endDate1, loader: 1, endId: controller.endFilterId);
                                                                    } else {
                                                                      String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                                                                      await controller.adminTripList(startDate: startDate1, loader: 1, endId: controller.endFilterId);
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
                                                                        await controller.adminTripList(startDate: startDate1, endDate: endDate1, loader: 1, endId: controller.endFilterId);
                                                                      } else {
                                                                        String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                                                                        await controller.adminTripList(startDate: startDate1, loader: 1, endId: controller.endFilterId);
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
                            focusBorder: focusBorderInput,
                            errorBorder: errorBoarderInput,
                            enableBorder: borderInput,
                            inputTextStyle: TextStyle(fontWeight: FontWeight.w500, color: Clr.tabTextClr, fontSize: 8.sp),
                            hintTextStyle: TextStyle(fontWeight: FontWeight.w400, color: Clr.textFieldHintClr2, fontSize: 8.sp),
                          ),
                          /*DropdownButtonFormField2<SiteListData?>(
                              alignment: Alignment.centerLeft,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 4.w, left: 1.5.w),
                                border: borderInput,
                                focusedBorder: focusBorderInput,
                                errorBorder: errorBoarderInput,
                                enabledBorder: borderInput,
                                hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Clr.textFieldHintClr2, fontSize: 8.sp),
                                filled: true,
                                fillColor: Clr.whiteClr,
                              ),
                              style: TextStyle(fontWeight: FontWeight.w500, color: Clr.tabTextClr, fontSize: 8.sp),
                              isExpanded: true,
                              hint: Text(
                                "End Site",
                                style: TextStyle(fontWeight: FontWeight.w400, color: Clr.textFieldHintClr2, fontSize: 8.sp),
                              ),
                              icon: Padding(
                                padding: EdgeInsets.only(right: 2.w),
                                child: SvgPicture.asset(AstSVG.dropDownArrow_ic, color: Clr.textFieldHintClr),
                              ),
                              iconSize: 8.w,
                              value: controller.sitesTabController.selectedESite,
                              dropdownMaxHeight: 80.w,
                              dropdownWidth: 50.w,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(2.5.w),
                                  bottomRight: Radius.circular(2.5.w),
                                ),
                              ),
                              selectedItemBuilder: (BuildContext context) {
                                return controller.sitesTabController.siteList.map((item) {
                                  return Text(item.name ?? "", style: TextStyle(fontWeight: FontWeight.w500, color: Clr.tabTextClr, fontSize: 8.sp));
                                }).toList();
                              },
                              items: controller.sitesTabController.siteList
                                  .map((item) => DropdownMenuItem<SiteListData>(
                                        value: item,
                                        onTap: () {
                                          controller.sitesTabController.selectedESite = item;
                                          controller.sitesTabController.update();
                                          controller.update();
                                        },
                                        child: Text(
                                          item.name ?? "",
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w500,
                                            color: controller.sitesTabController.selectedESite == item ? Clr.primaryClr : Clr.bottomTextClr,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (SiteListData? value) async {
                                controller.sitesTabController.selectedESite = value;
                                print("Selected End site = ${controller.sitesTabController.selectedESite?.name.toString()}");
                                if (controller.startDate != null && controller.endDate != null) {
                                  String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                                  String endDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.endDate.toString()))}";
                                  await controller.adminTripList(startDate: startDate1, endDate: endDate1, loader: 1, endId: controller.sitesTabController.selectedESite?.id);
                                } else {
                                  String startDate1 = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                                  await controller.adminTripList(startDate: startDate1, loader: 1, endId: controller.sitesTabController.selectedESite?.id);
                                }
                                // await controller.adminTripList(startDate: DateFormat('yyyy-MM-dd').format(controller.selectedDate), loader: 1, endId: controller.sitesTabController.selectedESite?.id);
                                controller.update();
                              },
                              onSaved: (SiteListData? value) {
                                controller.sitesTabController.selectedESite = value;
                              },
                            ),*/
                        ),
                      ],
                    ),
                    SizedBox(height: 3.80.w),
                    /*controller.filterListData.length != 0 && controller.searchC.text.isNotEmpty
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.5.w, color: Clr.borderClr),
                              borderRadius: BorderRadius.circular(2.78.w),
                            ),
                            child: IntrinsicWidth(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  tableViewTitle(),
                                  for (int index = 0; index < controller.filterListData.length; index++)
                                    StartTableView(
                                      context: context,
                                      triStatus: true,
                                      date: DateFormat("dd MMM yyyy").format(DateTime.parse(controller.filterListData[index].fromDate ?? "")),
                                      busNo: controller.filterListData[index].busNumber ?? "",
                                      busStatusdata: controller.filterListData[index].busStatusData,
                                      driverDetalis: controller.filterListData[index].driveName ?? "",
                                      driverMobile: controller.filterListData[index].driveMoble ?? "",
                                      borderRadius: (controller.filterListData.length == index + 1) ? BorderRadius.only(bottomLeft: Radius.circular(2.78.w), bottomRight: Radius.circular(2.78.w)) : BorderRadius.only(bottomLeft: Radius.circular(0.w), bottomRight: Radius.circular(0.w)),
                                    ),
                                ],
                              ),
                            ),
                          )
                        : */
                    controller.TripListData.length != 0
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.5.w, color: Clr.borderClr),
                              borderRadius: BorderRadius.circular(2.78.w),
                            ),
                            child: IntrinsicWidth(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  tableViewTitle(),
                                  for (int index = 0; index < controller.TripListData.length; index++)
                                    StartTableView(
                                      context: context,
                                      triStatus: true,
                                      date: DateFormat("dd MMM yyyy").format(DateTime.parse(controller.TripListData[index].fromDate ?? "")),
                                      busNo: controller.TripListData[index].busNumber ?? "",
                                      busStatusdata: controller.TripListData[index].busStatusData,
                                      driverDetalis: controller.TripListData[index].driveName ?? "",
                                      driverMobile: controller.TripListData[index].driveMoble ?? "",
                                      dataIndex: index,
                                      borderRadius: (controller.TripListData.length == index + 1)
                                          ? BorderRadius.only(
                                              bottomLeft: Radius.circular(2.78.w),
                                              bottomRight: Radius.circular(2.78.w),
                                            )
                                          : BorderRadius.only(
                                              bottomLeft: Radius.circular(0.w),
                                              bottomRight: Radius.circular(0.w),
                                            ),
                                    ),
                                ],
                              ),
                            ),
                          )
                        : Align(
                            alignment: Alignment.center,
                            child: Center(
                              child: noDataWidget(title: "No Data"),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/*Container(
                              decoration: BoxDecoration(
                                color: Clr.whiteClr,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(2.78.w),
                                  topRight: Radius.circular(2.78.w),
                                ),
                              ),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 11.5.w,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          right: BorderSide(color: Clr.borderClr, width: 0.3.w),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 1.w, right: 1.w),
                                        child: Text(
                                          "Date",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 8.sp, color: Clr.textFieldHintClr, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 12.5.w,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        right: BorderSide(color: Clr.borderClr, width: 0.3.w),
                                      )),
                                      child: Text(
                                        "Bus No.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 8.sp, color: Clr.textFieldHintClr, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: 40.w,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(top: 2.w, bottom: 2.w),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(color: Clr.borderClr, width: 0.3.w),
                                            ),
                                          ),
                                          child: Text(
                                            "Bus Status",
                                            style: TextStyle(fontSize: 8.sp, color: Clr.textFieldHintClr, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        IntrinsicHeight(
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(top: 1.w, bottom: 1.w),
                                                  width: 20.w,
                                                  height: double.infinity,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                    right: BorderSide(color: Clr.borderClr, width: 0.3.w),
                                                  )),
                                                  child: Text(
                                                    "Start",
                                                    style: TextStyle(fontSize: 8.sp, color: Clr.textFieldHintClr, fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                                Container(
                                                  width: 20.w,
                                                  padding: EdgeInsets.only(top: 1.w, bottom: 1.w),
                                                  height: double.infinity,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "End",
                                                    style: TextStyle(fontSize: 8.sp, color: Clr.textFieldHintClr, fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 11.w,
                                      height: double.infinity,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(color: Clr.borderClr, width: 0.3.w),
                                      )),
                                      child: Text(
                                        "No. of \nPassengers",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 8.sp, color: Clr.textFieldHintClr, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Container(
                                      width: 15.w,
                                      height: double.infinity,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(color: Clr.borderClr, width: 0.3.w),
                                      )),
                                      child: Text(
                                        "Driver Details",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 8.sp, color: Clr.textFieldHintClr, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),*/
/*for (int i = 0; i < 8; i++)
                              TableView(
                                context: context,
                                date: "17 Nov 2022",
                                busNo: "GJ-05 8964",
                                startSite: "Site A",
                                startUName: "Arjun Patel",
                                startTime: "9:00am",
                                endSite: "Swaminarayan nagar",
                                endUName: "Jignesh Jadeja",
                                endTime: "9:30am",
                                startSite2: "Swaminarayan nagar",
                                startUName2: "Jignesh Jadeja",
                                startTime2: "10:05am",
                                endSite2: "Site A",
                                endUName2: "Arjun Patel",
                                endTime2: "7:00am",
                                passenger1: 22,
                                passenger2: 20,
                                driverDetalis: "Kamalesh Patel",
                              ),*/
