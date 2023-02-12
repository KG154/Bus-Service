import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:shuttleservice/controller/home/trips_tab_controller.dart';
import 'package:shuttleservice/module/model/home/buses_list_model.dart';
import 'package:shuttleservice/module/model/home/site_list_model.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/utils/assets.dart';
import 'package:shuttleservice/view/utils/color.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/button.dart';
import 'package:shuttleservice/view/widget/textfields.dart';
import 'package:shuttleservice/view/widget/widgets.dart';

class EditTripScreenAdmin extends StatefulWidget {
  String? screen;
  int? id;
  String? busNo;
  String? fromSideid;
  String? toSideid;
  String? toSideName;
  String? fromSideName;
  String? driveName;
  String? driveMoblie;
  String? fromCount;

  EditTripScreenAdmin({
    Key? key,
    this.screen,
    this.id,
    this.busNo,
    this.toSideid,
    this.toSideName,
    this.fromSideName,
    this.fromSideid,
    this.driveName,
    this.driveMoblie,
    this.fromCount,
  }) : super(key: key);

  @override
  State<EditTripScreenAdmin> createState() => _EditTripScreenAdminState();
}

class _EditTripScreenAdminState extends State<EditTripScreenAdmin> {
  TripsTabController tripsTabController = Get.put(TripsTabController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() {
    if (widget.screen == "EditScreen") {
      tripsTabController.busNumC.clear();
      tripsTabController.startSiteC.clear();
      tripsTabController.endSiteC.clear();
      tripsTabController.dPhoneNoC.clear();
      tripsTabController.dNameC.clear();
      tripsTabController.noOfPassC.clear();
      // tripsTabController.busesTabController.selectedBuses2 = null;
      // tripsTabController.sitesTabController.selectedSSite = null;
      // tripsTabController.sitesTabController.selectedESite = null;

      for (int index = 0; index < tripsTabController.busesTabController.busesList.length; index++) {
        if (tripsTabController.busesTabController.busesList[index].busNumber == widget.busNo) {
          // tripsTabController.busesTabController.selectedBuses2 = tripsTabController.busesTabController.busesList[index];
          tripsTabController.busNumC.text = tripsTabController.busesTabController.busesList[index].busNumber.toString();
          tripsTabController.busId = tripsTabController.busesTabController.busesList[index].id;
        }
      }
      // print(tripsTabController.busesTabController.selectedBuses2?.busNumber);
      // tripsTabController.startSiteC.text = widget.fromSideName ?? "";
      // tripsTabController.endSiteC.text = widget.toSideName ?? "";
      for (int index = 0; index < tripsTabController.sitesTabController.siteList.length; index++) {
        if (tripsTabController.sitesTabController.siteList[index].name == widget.fromSideName) {
          // tripsTabController.sitesTabController.selectedSSite = tripsTabController.sitesTabController.siteList[index];
          tripsTabController.startSiteC.text = tripsTabController.sitesTabController.siteList[index].name.toString();
          tripsTabController.fromId = tripsTabController.sitesTabController.siteList[index].id.toString();
        }
      }
      for (int index = 0; index < tripsTabController.sitesTabController.siteList.length; index++) {
        if (tripsTabController.sitesTabController.siteList[index].name == widget.toSideName) {
          // tripsTabController.sitesTabController.selectedESite = tripsTabController.sitesTabController.siteList[index];
          tripsTabController.endSiteC.text = tripsTabController.sitesTabController.siteList[index].name.toString();
          tripsTabController.endId = tripsTabController.sitesTabController.siteList[index].id;
        }
      }
      tripsTabController.dPhoneNoC.text = widget.driveMoblie.toString();
      tripsTabController.dNameC.text = widget.driveName.toString();
      tripsTabController.noOfPassC.text = widget.fromCount.toString();
      print(tripsTabController.busId.toString());
      print(tripsTabController.fromId.toString());
      print(tripsTabController.endId.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripsTabController>(
      init: TripsTabController(),
      builder: (controller) {
        return KeyboardDismisser(
          gestures: [GestureType.onTap, GestureType.onPanUpdateAnyDirection],
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 15.w,
              titleSpacing: 0,
              centerTitle: true,
              title: Text(
                widget.screen == "EditScreen" ? Str.editTrip : Str.addTrip,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp, color: Clr.textFieldTextClr),
              ),
              leading: Padding(
                padding: EdgeInsets.only(left: 3),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back_ios_new_rounded, color: Clr.textFieldTextClr),
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 0.5.h),
              child: Form(
                autovalidateMode: controller.submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                key: controller.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    userSText(text: Str.selectBus),
                    MyTextField(
                      padding: EdgeInsets.zero,
                      fillColor: Clr.textFieldBgClr,
                      readOnly: true,
                      controller: controller.busNumC,
                      keyboardType: TextInputType.text,
                      inputFormat: Validate.nameFormat,
                      validate: Validate.nameVal,
                      suffixIcon: Icon(
                        Icons.arrow_drop_down_rounded,
                        size: 12.w,
                        color: Clr.textFieldHintClr,
                      ),
                      onChanged: (val) {
                        controller.update();
                      },
                      onTap: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        controller.searchC1.clear();
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
                                              controller: controller.searchC1,
                                              fillColor: Clr.whiteClr,
                                              textInputAction: TextInputAction.done,
                                              hintText: Str.searchStr,
                                              validate: Validate.nameVal,
                                              keyboardType: TextInputType.name,
                                              inputFormat: Validate.nameFormat,
                                              onChanged: (val) {
                                                if (val.isNotEmpty) {
                                                  controller.search = true;
                                                  controller.update();
                                                  setSta(() {});
                                                } else {
                                                  controller.search = false;
                                                  controller.update();
                                                  setSta(() {});
                                                }
                                                controller.filteredBuses.clear();
                                                for (int index = 0; index < controller.busesTabController.busesList.length; index++) {
                                                  if ("${controller.busesTabController.busesList[index].busNumber}".toLowerCase().contains(controller.searchC1.text.toLowerCase())) {
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
                                          controller.busesTabController.busesList.length != 0 && controller.searchC1.text.isEmpty
                                              ? Container(
                                                  height: 50.h,
                                                  child: SingleChildScrollView(
                                                    child: ListView.builder(
                                                        shrinkWrap: true,
                                                        physics: NeverScrollableScrollPhysics(),
                                                        itemCount: controller.busesTabController.busesList.length,
                                                        itemBuilder: (context, i) {
                                                          return settingListTile(
                                                            selected: controller.busNumC.text == controller.busesTabController.busesList[i].busNumber.toString(),
                                                            onTap: () {
                                                              controller.busNumC.text = controller.busesTabController.busesList[i].busNumber.toString();
                                                              controller.busId = controller.busesTabController.busesList[i].id;

                                                              Get.back();
                                                              setSta(() {});
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
                                                              selected: controller.busNumC.text == controller.filteredBuses[index].busNumber.toString(),
                                                              onTap: () {
                                                                controller.busNumC.text = controller.filteredBuses[index].busNumber.toString();
                                                                controller.busId = controller.filteredBuses[index].id;
                                                                Get.back();
                                                                setSta(() {});
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
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Please Select Bus";
                        }
                        return null;
                      },
                      hintText: "Select Bus",
                      border: borderInput,
                      focusBorder: borderInput,
                      errorBorder: errorBoarderInput,
                      inputTextStyle: inputTextStyle,
                      hintTextStyle: hintTextStyle,
                    ),
                    /*DropdownButtonFormField2<BusesListData?>(
                      alignment: Alignment.centerLeft,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3.5.w, left: 0.w),
                        border: borderInput,
                        focusedBorder: focusBorderInput,
                        errorBorder: errorBoarderInput,
                        enabledBorder: borderInput,
                        hintStyle: hintTextStyle,
                        filled: true,
                        fillColor: Clr.textFieldBgClr,
                      ),
                      style: inputTextStyle,
                      isExpanded: true,
                      hint: Text(
                        "Select Bus",
                        style: hintTextStyle,
                      ),
                      icon: Padding(
                        padding: EdgeInsets.only(right: 2.w),
                        child: SvgPicture.asset(AstSVG.dropDownArrow_ic, color: Clr.textFieldHintClr),
                      ),
                      iconSize: 8.w,
                      buttonHeight: 9.5.w,
                      value: controller.busesTabController.selectedBuses2,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(2.5.w),
                          bottomRight: Radius.circular(2.5.w),
                        ),
                      ),
                      selectedItemBuilder: (BuildContext context) {
                        return controller.busesTabController.busesList.map((item) {
                          return Text(
                            item.busNumber ?? "",
                            style: inputTextStyle,
                          );
                        }).toList();
                      },
                      items: controller.busesTabController.busesList
                          .map((item) => DropdownMenuItem<BusesListData>(
                                value: item,
                                onTap: () {
                                  controller.busesTabController.selectedBuses2 = item;
                                  controller.busesTabController.update();
                                  controller.update();
                                },
                                child: Text(
                                  item.busNumber ?? "",
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                    color: controller.busesTabController.selectedBuses2 == item ? Clr.primaryClr : Clr.bottomTextClr,
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return "    Please Select Bus";
                        }
                        return null;
                      },
                      onChanged: (BusesListData? value) {
                        controller.busesTabController.selectedBuses2 = value;
                        controller.update();
                      },
                      onSaved: (BusesListData? value) {
                        controller.busesTabController.selectedBuses2 = value;
                      },
                    ),*/

                    userSText(text: Str.startSite),
                    MyTextField(
                      padding: EdgeInsets.zero,
                      fillColor: Clr.textFieldBgClr,
                      readOnly: true,
                      controller: controller.startSiteC,
                      keyboardType: TextInputType.text,
                      inputFormat: Validate.nameFormat,
                      validate: Validate.nameVal,
                      suffixIcon: Icon(
                        Icons.arrow_drop_down_rounded,
                        size: 12.w,
                        color: Clr.textFieldHintClr,
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
                                                  controller.search1 = true;
                                                  controller.update();
                                                  setSta(() {});
                                                } else {
                                                  controller.search1 = false;
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
                                                            selected: controller.startSiteC.text == controller.sitesTabController.siteList[i].name.toString(),
                                                            onTap: () {
                                                              controller.startSiteC.text = controller.sitesTabController.siteList[i].name.toString();
                                                              controller.fromId = controller.sitesTabController.siteList[i].id.toString();
                                                              Get.back();
                                                              setSta(() {});
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
                                                              selected: controller.startSiteC.text == controller.filteredStartSite[index].name.toString(),
                                                              onTap: () {
                                                                controller.startSiteC.text = controller.filteredStartSite[index].name.toString();
                                                                controller.fromId = controller.filteredStartSite[index].id.toString();
                                                                Get.back();
                                                                setSta(() {});
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Select Start Site";
                        }
                        return null;
                      },
                      hintText: "Select Site",
                      border: borderInput,
                      focusBorder: borderInput,
                      errorBorder: errorBoarderInput,
                      inputTextStyle: inputTextStyle,
                      hintTextStyle: hintTextStyle,
                    ),
                    /*DropdownButtonFormField2<SiteListData?>(
                      alignment: Alignment.centerLeft,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3.5.w, left: 0.w),
                        border: borderInput,
                        focusedBorder: focusBorderInput,
                        errorBorder: errorBoarderInput,
                        enabledBorder: borderInput,
                        hintStyle: hintTextStyle,
                        filled: true,
                        fillColor: Clr.textFieldBgClr,
                      ),
                      style: inputTextStyle,
                      isExpanded: true,
                      hint: Text(
                        "Select Site",
                        style: hintTextStyle,
                      ),
                      icon: Padding(
                        padding: EdgeInsets.only(right: 2.w),
                        child: SvgPicture.asset(AstSVG.dropDownArrow_ic, color: Clr.textFieldHintClr),
                      ),
                      iconSize: 8.w,
                      buttonHeight: 9.5.w,
                      value: controller.sitesTabController.selectedSSite,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(2.5.w),
                          bottomRight: Radius.circular(2.5.w),
                        ),
                      ),
                      selectedItemBuilder: (BuildContext context) {
                        return controller.sitesTabController.siteList.map((item) {
                          return Text(
                            item.name ?? "",
                            style: inputTextStyle,
                          );
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
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                    color: controller.sitesTabController.selectedSSite == item ? Clr.primaryClr : Clr.bottomTextClr,
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return "    Please Select Start Site";
                        }
                        return null;
                      },
                      onChanged: (SiteListData? value) {
                        controller.sitesTabController.selectedSSite = value;
                        controller.update();
                      },
                      onSaved: (SiteListData? value) {
                        controller.sitesTabController.selectedSSite = value;
                      },
                    ),*/
                    userSText(text: Str.endSite),
                    MyTextField(
                      padding: EdgeInsets.zero,
                      fillColor: Clr.textFieldBgClr,
                      readOnly: true,
                      controller: controller.endSiteC,
                      keyboardType: TextInputType.text,
                      inputFormat: Validate.nameFormat,
                      validate: Validate.nameVal,
                      suffixIcon: Icon(
                        Icons.arrow_drop_down_rounded,
                        size: 12.w,
                        color: Clr.textFieldHintClr,
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
                                                  controller.search2 = true;
                                                  controller.update();
                                                  setSta(() {});
                                                } else {
                                                  controller.search2 = false;
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
                                                            selected: controller.endSiteC.text == controller.sitesTabController.siteList[i].name.toString(),
                                                            onTap: () {
                                                              controller.endSiteC.text = controller.sitesTabController.siteList[i].name.toString();
                                                              controller.endId = controller.sitesTabController.siteList[i].id;
                                                              Get.back();
                                                              setSta(() {});
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
                                                              selected: controller.endSiteC.text == controller.filteredSite[index].name.toString(),
                                                              onTap: () {
                                                                controller.endSiteC.text = controller.filteredSite[index].name.toString();
                                                                controller.endId = controller.filteredSite[index].id;
                                                                Get.back();
                                                                setSta(() {});
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Select End Site";
                        } else if (controller.startSiteC.text == controller.endSiteC.text) {
                          return "Start site and End site should be different's ";
                        }
                        return null;
                      },
                      hintText: "Select Site",
                      border: borderInput,
                      focusBorder: borderInput,
                      errorBorder: errorBoarderInput,
                      inputTextStyle: inputTextStyle,
                      hintTextStyle: hintTextStyle,
                    ),
                    /*MyTextField(
                      padding: EdgeInsets.zero,
                      fillColor: Clr.textFieldBgClr,
                      readOnly: true,
                      controller: controller.endSiteC,
                      keyboardType: TextInputType.text,
                      inputFormat: Validate.nameFormat,
                      validate: Validate.nameVal,
                      onChanged: (_) {
                        controller.update();
                      },
                      hintText: Str.eName,
                      border: borderInput,
                      focusBorder: borderInput,
                      errorBorder: errorBoarderInput,
                      inputTextStyle: inputTextStyle,
                      hintTextStyle: hintTextStyle,
                    ),*/
                    /*DropdownButtonFormField2<SiteListData?>(
                      alignment: Alignment.centerLeft,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3.5.w, left: 0.w),
                        border: borderInput,
                        focusedBorder: focusBorderInput,
                        errorBorder: errorBoarderInput,
                        enabledBorder: borderInput,
                        hintStyle: hintTextStyle,
                        filled: true,
                        fillColor: Clr.textFieldBgClr,
                      ),
                      style: inputTextStyle,
                      isExpanded: true,
                      hint: Text(
                        "Select Site",
                        style: hintTextStyle,
                      ),
                      icon: Padding(
                        padding: EdgeInsets.only(right: 2.w),
                        child: SvgPicture.asset(AstSVG.dropDownArrow_ic, color: Clr.textFieldHintClr),
                      ),
                      iconSize: 8.w,
                      buttonHeight: 9.5.w,
                      value: controller.sitesTabController.selectedESite,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(2.5.w),
                          bottomRight: Radius.circular(2.5.w),
                        ),
                      ),
                      selectedItemBuilder: (BuildContext context) {
                        return controller.sitesTabController.siteList.map((item) {
                          return Text(
                            item.name ?? "",
                            style: inputTextStyle,
                          );
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
                      validator: (value) {
                        if (value == null) {
                          return "    Please Select End Site";
                        } else if (controller.startSiteC.text == value.name) {
                          return "    Start site and End site should be different's ";
                        }
                        return null;
                      },
                      onChanged: (SiteListData? value) {
                        controller.sitesTabController.selectedESite = value;
                        controller.update();
                      },
                      onSaved: (SiteListData? value) {
                        controller.sitesTabController.selectedESite = value;
                      },
                    ),*/
                    userSText(text: Str.driverName),
                    MyTextField(
                      padding: EdgeInsets.zero,
                      fillColor: Clr.textFieldBgClr,
                      controller: controller.dNameC,
                      keyboardType: TextInputType.text,
                      inputFormat: Validate.nameFormat,
                      validate: Validate.nameVal,
                      onChanged: (_) {
                        controller.update();
                      },
                      hintText: Str.eName,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return Validate.nameEmptyValidator;
                        }
                        return null;
                      },
                      border: borderInput,
                      focusBorder: focusBorderInput,
                      errorBorder: errorBoarderInput,
                      inputTextStyle: inputTextStyle,
                      hintTextStyle: hintTextStyle,
                    ),
                    userSText(text: Str.driverPhoneNo),
                    MyTextField(
                      padding: EdgeInsets.zero,
                      fillColor: Clr.textFieldBgClr,
                      maxLength: 10,
                      controller: controller.dPhoneNoC,
                      keyboardType: TextInputType.phone,
                      inputFormat: Validate.numberFormat,
                      validate: Validate.numVal,
                      onChanged: (_) {
                        controller.update();
                      },
                      // prefixIcon: Padding(
                      //   padding: EdgeInsets.only(left: 3.5.w, top: 3.2.w, bottom: 3.5.w),
                      //   child: Text("+91", style: inputTextStyle),
                      // ),
                      hintText: Str.ePhoneNumber,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return Validate.mobileNoEmpty;
                        } else if (!RegExp(r'^(?:[+0]9)?[0-9]{10,10}$').hasMatch(v)) {
                          return Validate.mobileNoValid;
                        }
                        return null;
                      },
                      border: borderInput,
                      focusBorder: focusBorderInput,
                      errorBorder: errorBoarderInput,
                      inputTextStyle: inputTextStyle,
                      hintTextStyle: hintTextStyle,
                    ),
                    userSText(text: Str.noOfPassengers),
                    MyTextField(
                      padding: EdgeInsets.zero,
                      fillColor: Clr.textFieldBgClr,
                      maxLength: 10,
                      controller: controller.noOfPassC,
                      keyboardType: TextInputType.phone,
                      inputFormat: Validate.numberFormat,
                      textInputAction: TextInputAction.done,
                      validate: Validate.numVal,
                      onChanged: (_) {
                        controller.update();
                      },
                      hintText: Str.eNumber,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return Validate.passengersEmpty;
                        }
                        return null;
                      },
                      border: borderInput,
                      focusBorder: focusBorderInput,
                      errorBorder: errorBoarderInput,
                      inputTextStyle: inputTextStyle,
                      hintTextStyle: hintTextStyle,
                    ),
                    SizedBox(height: 15.w),
                    Center(
                      child: MyButton(
                        width: 55.98.w,
                        title: widget.screen == "EditScreen" ? "Submit" : Str.addTrip,
                        onClick: () async {
                          controller.submitted = true;
                          if (controller.formKey.currentState!.validate()) {
                            print("Add");
                            print(controller.busId.toString());
                            print(controller.fromId.toString());
                            print(controller.endId.toString());
                            print(controller.busNumC.text.toString());
                            print(controller.startSiteC.text.toString());
                            print(controller.endSiteC.text.toString());
                            print(controller.dNameC.text.toString());
                            print(controller.dPhoneNoC.text.toString());
                            print(controller.noOfPassC.text.toString());
                            widget.screen == "EditScreen"
                                ? await controller.editUsers(
                                    id: widget.id,
                                    fromId: controller.fromId,
                                    endId: controller.endId.toString(),
                                    busId: controller.busId,
                                  )
                                : SizedBox();
                          }
                          controller.update();
                        },
                      ),
                    ),
                    SizedBox(height: 8.w),
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
