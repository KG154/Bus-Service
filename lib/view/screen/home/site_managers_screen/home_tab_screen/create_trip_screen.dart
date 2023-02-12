import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:shuttleservice/controller/home/site_managers_controller/create_tripe_controller.dart';
import 'package:shuttleservice/module/model/home/buses_list_model.dart';
import 'package:shuttleservice/module/model/home/site_list_model.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/utils/assets.dart';
import 'package:shuttleservice/view/utils/color.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/shared_preference.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/bottomsheet.dart';
import 'package:shuttleservice/view/widget/button.dart';
import 'package:shuttleservice/view/widget/dropdown.dart';
import 'package:shuttleservice/view/widget/textfields.dart';
import 'package:shuttleservice/view/widget/widgets.dart';

class CreateTripScreen extends StatefulWidget {
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

  CreateTripScreen({
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
  State<CreateTripScreen> createState() => _CreateTripScreenState();
}

class _CreateTripScreenState extends State<CreateTripScreen> {
  CreateTripeController createTripeController = Get.put(CreateTripeController());

  @override
  void initState() {
    // TODO: implement initState
    abc();
    super.initState();
  }

  abc() async {
    createTripeController.userModel = await Storage.getUser();

    createTripeController.update();
    await createTripeController.busesTabController.getActiveBusesList(loader: 0, status: "active");
    await createTripeController.sitesTabController.getSiteListForAdd(status: "active", loader: 0);

    createTripeController.update();

    if (widget.screen == "EditScreen") {
      // createTripeController.busesTabController.selectedBuses = null;
      // createTripeController.sitesTabController.selectedESite = null;
      for (int index = 0; index < createTripeController.busesTabController.busesListForAdd.length; index++) {
        if (createTripeController.busesTabController.busesListForAdd[index].busNumber == widget.busNo) {
          // createTripeController.busesTabController.selectedBuses = createTripeController.busesTabController.busesListForAdd[index];
          createTripeController.busNumC.text = createTripeController.busesTabController.busesListForAdd[index].busNumber.toString();
          createTripeController.busId = createTripeController.busesTabController.busesListForAdd[index].id;
        }
      }
      // print(createTripeController.busesTabController.selectedBuses?.busNumber);
      print(createTripeController.busNumC.text.toString());
      createTripeController.startSiteC.text = widget.fromSideName ?? "";
      createTripeController.update();
      for (int index = 0; index < createTripeController.sitesTabController.siteListForAdd.length; index++) {
        if (createTripeController.sitesTabController.siteListForAdd[index].name == widget.toSideName) {
          // createTripeController.sitesTabController.selectedESite = createTripeController.sitesTabController.siteListForAdd[index];
          createTripeController.endSiteC.text = createTripeController.sitesTabController.siteListForAdd[index].name.toString();
          createTripeController.endId = createTripeController.sitesTabController.siteListForAdd[index].id;
        }
      }
      /* if (createTripeController.sitesTabController.selectedESite == null) {
        createTripeController.sitesTabController.selectedESite?.name = widget.toSideName ?? "";
        createTripeController.update();
      }
      print(createTripeController.sitesTabController.selectedESite?.name.toString());*/
      createTripeController.dPhoneNoC.text = widget.driveMoblie.toString();
      createTripeController.dNameC.text = widget.driveName.toString();
      createTripeController.noOfPassC.text = widget.fromCount.toString();
      createTripeController.update();
    } else {
      // createTripeController.busesTabController.selectedBuses = null;
      // createTripeController.sitesTabController.selectedESite = null;
      createTripeController.busNumC.clear();
      createTripeController.endSiteC.clear();
      createTripeController.dPhoneNoC.clear();
      createTripeController.dNameC.clear();
      createTripeController.noOfPassC.clear();
      createTripeController.noOfPassC.text = "50";
      createTripeController.startSiteC.text = createTripeController.userModel!.startSiteName.toString();
      createTripeController.fromId = createTripeController.userModel!.startSiteId.toString();
      for (int i = 0; i < createTripeController.sitesTabController.siteListForAdd.length; i++) {
        if (createTripeController.sitesTabController.siteListForAdd[i].name == createTripeController.userModel?.endSiteName) {
          createTripeController.endSiteC.text = createTripeController.sitesTabController.siteListForAdd[i].name.toString();
          createTripeController.endId = createTripeController.sitesTabController.siteListForAdd[i].id;
        }
      }
      createTripeController.update();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateTripeController>(
      init: CreateTripeController(),
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
                                                /*controller.filteredUser.clear();
                                                controller.update();
                                                setSta(() {});
                                                for (int i = 0; i < controller.busesTabController.busesListForAdd.length; i++) {
                                                  if (controller.busesTabController.busesListForAdd[i].busNumber!.toLowerCase().contains(val)) {
                                                    controller.filteredUser.add(controller.busesTabController.busesListForAdd[i]);
                                                    controller.update();
                                                    setSta(() {});
                                                  }
                                                }
                                                controller.update();*/
                                                // setSta(() {});

                                                if (val.isNotEmpty) {
                                                  controller.search = true;
                                                  controller.update();
                                                  setSta(() {});
                                                } else {
                                                  controller.search = false;
                                                  controller.update();
                                                  setSta(() {});
                                                }
                                                controller.filteredUser.clear();
                                                for (int index = 0; index < controller.busesTabController.busesListForAdd.length; index++) {
                                                  if ("${controller.busesTabController.busesListForAdd[index].busNumber}".toLowerCase().contains(controller.searchC.text.toLowerCase())) {
                                                    controller.filteredUser.add(controller.busesTabController.busesListForAdd[index]);
                                                  }
                                                }
                                                print(controller.filteredUser.length);
                                                setSta(() {});
                                              },
                                              contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                              border: borderInput,
                                              focusBorder: focusBorderInput,
                                              inputTextStyle: TextStyle(fontWeight: FontWeight.w600, color: Clr.tabTextClr, height: 1.2, fontSize: 11.sp),
                                              hintTextStyle: TextStyle(color: Clr.textFieldHintClr2, fontWeight: FontWeight.w400, height: 1.2, fontSize: 11.sp),
                                            ),
                                          ),
                                          controller.busesTabController.busesListForAdd.length != 0 && controller.searchC.text.isEmpty
                                              ? Container(
                                                  height: 40.h,
                                                  child: SingleChildScrollView(
                                                    child: ListView.builder(
                                                        shrinkWrap: true,
                                                        physics: NeverScrollableScrollPhysics(),
                                                        itemCount: controller.busesTabController.busesListForAdd.length,
                                                        itemBuilder: (context, i) {
                                                          return settingListTile(
                                                            selected: controller.busNumC.text == controller.busesTabController.busesListForAdd[i].busNumber.toString(),
                                                            onTap: () {
                                                              controller.busNumC.text = controller.busesTabController.busesListForAdd[i].busNumber.toString();
                                                              controller.busId = controller.busesTabController.busesListForAdd[i].id;

                                                              Get.back();
                                                              setSta(() {});
                                                            },
                                                            name: controller.busesTabController.busesListForAdd[i].busNumber.toString(),
                                                          );
                                                        }),
                                                  ),
                                                )
                                              : controller.filteredUser.length != 0
                                                  ? SizedBox(
                                                      height: 40.h,
                                                      child: SingleChildScrollView(
                                                        child: ListView.builder(
                                                          shrinkWrap: true,
                                                          physics: NeverScrollableScrollPhysics(),
                                                          itemBuilder: (context, index) {
                                                            return settingListTile(
                                                              selected: controller.busNumC.text == controller.filteredUser[index].busNumber.toString(),
                                                              onTap: () {
                                                                controller.busNumC.text = controller.filteredUser[index].busNumber.toString();
                                                                controller.busId = controller.filteredUser[index].id;
                                                                Get.back();
                                                                setSta(() {});
                                                              },
                                                              name: controller.filteredUser[index].busNumber.toString(),
                                                            );
                                                          },
                                                          itemCount: controller.filteredUser.length,
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
                        // contentPadding: EdgeInsets.symmetric(vertical: 1.3.w),
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
                      value: controller.busesTabController.selectedBuses,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(2.5.w),
                          bottomRight: Radius.circular(2.5.w),
                        ),
                      ),
                      selectedItemBuilder: (BuildContext context) {
                        return controller.busesTabController.busesListForAdd.map((item) {
                          return Text(
                            item.busNumber ?? "",
                            style: inputTextStyle,
                          );
                        }).toList();
                      },
                      items: controller.busesTabController.busesListForAdd
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
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                    color: controller.busesTabController.selectedBuses == item ? Clr.primaryClr : Clr.bottomTextClr,
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
                        controller.busesTabController.selectedBuses = value;
                        controller.update();
                      },
                      onSaved: (BusesListData? value) {
                        controller.busesTabController.selectedBuses = value;
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
                      onChanged: (_) {
                        controller.update();
                      },
                      hintText: Str.eName,
                      border: borderInput,
                      focusBorder: borderInput,
                      errorBorder: errorBoarderInput,
                      inputTextStyle: inputTextStyle,
                      hintTextStyle: hintTextStyle,
                    ),
                    /*DropdownButtonFormField2<SiteListData?>(
                      alignment: Alignment.centerLeft,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 1.3.w),
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
                      buttonHeight: 10.w,
                      value: controller.sitesTabController.selectedSSite,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(2.5.w),
                          bottomRight: Radius.circular(2.5.w),
                        ),
                      ),
                      selectedItemBuilder: (BuildContext context) {
                        return controller.sitesTabController.siteListForAdd.map((item) {
                          return Text(
                            item.name ?? "",
                            style: inputTextStyle,
                          );
                        }).toList();
                      },
                      items: controller.sitesTabController.siteListForAdd
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
                    /*MyDropDown(
                      hintText: "Select Site",
                      itemList: controller.startSiteType,
                      selectedValue: controller.selectedSSite,
                      validatorText: "    Please Select Start Site",
                      onChange: (value) {
                        controller.selectedSSite = value.toString();
                        controller.update();
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
                                                  controller.search2 = true;
                                                  controller.update();
                                                  setSta(() {});
                                                } else {
                                                  controller.search2 = false;
                                                  controller.update();
                                                  setSta(() {});
                                                }
                                                controller.filteredSite.clear();
                                                for (int index = 0; index < controller.sitesTabController.siteListForAdd.length; index++) {
                                                  if ("${controller.sitesTabController.siteListForAdd[index].name}".toLowerCase().contains(controller.searchC2.text.toLowerCase())) {
                                                    controller.filteredSite.add(controller.sitesTabController.siteListForAdd[index]);
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
                                          controller.sitesTabController.siteListForAdd.length != 0 && controller.searchC2.text.isEmpty
                                              ? Container(
                                                  height: 50.h,
                                                  child: SingleChildScrollView(
                                                    child: ListView.builder(
                                                        shrinkWrap: true,
                                                        physics: NeverScrollableScrollPhysics(),
                                                        itemCount: controller.sitesTabController.siteListForAdd.length,
                                                        itemBuilder: (context, i) {
                                                          return settingListTile(
                                                            selected: controller.endSiteC.text == controller.sitesTabController.siteListForAdd[i].name.toString(),
                                                            onTap: () {
                                                              controller.endSiteC.text = controller.sitesTabController.siteListForAdd[i].name.toString();
                                                              controller.endId = controller.sitesTabController.siteListForAdd[i].id;
                                                              Get.back();
                                                              setSta(() {});
                                                            },
                                                            name: controller.sitesTabController.siteListForAdd[i].name.toString(),
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
                        if (value == null) {
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
                    /*DropdownButtonFormField2<SiteListData?>(
                      alignment: Alignment.centerLeft,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3.5.w, left: 0.w),
                        // contentPadding: EdgeInsets.symmetric(vertical: 1.3.w),
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
                        return controller.sitesTabController.siteListForAdd.map((item) {
                          return Text(
                            item.name ?? "",
                            style: inputTextStyle,
                          );
                        }).toList();
                      },
                      items: controller.sitesTabController.siteListForAdd
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
                    /*MyDropDown(
                      hintText: "Select Site",
                      itemList: controller.endSiteType,
                      selectedValue: controller.selectedESite,
                      validatorText: "    Please Select End Site",
                      onChange: (value) {
                        controller.selectedESite = value.toString();
                        controller.update();
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
                      // validator: (v) {
                      //   if (v!.isEmpty) {
                      //     return Validate.nameEmptyValidator;
                      //   }
                      //   return null;
                      // },
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
                      // validator: (v) {
                      //   if (v!.isEmpty) {
                      //     return Validate.mobileNoEmpty;
                      //   } else if (!RegExp(r'^(?:[+0]9)?[0-9]{10,10}$').hasMatch(v)) {
                      //     return Validate.mobileNoValid;
                      //   }
                      //   return null;
                      // },
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
                            widget.screen == "EditScreen" ? print("Edit") : print("Add");
                            // print(controller.sitesTabController.selectedESite?.id.toString());
                            print(controller.busId.toString());
                            print(controller.endId.toString());
                            // print(controller.busesTabController.selectedBuses?.id.toString());
                            print(controller.busNumC.text.toString());
                            print(controller.startSiteC.text.toString());
                            print(controller.endSiteC.text.toString());
                            print(controller.dNameC.text.toString());
                            print(controller.dPhoneNoC.text.toString());
                            print(controller.noOfPassC.text.toString());
                            widget.screen == "EditScreen"
                                ? await controller.editTrip(
                                    id: widget.id,
                                    busId: controller.busId,
                                    fromId: widget.fromSideid,
                                    endId: controller.endId,
                                  )
                                : await controller.addTrip(
                                    busId: controller.busId,
                                    fromId: controller.fromId,
                                    endId: controller.endId,
                                  );
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
