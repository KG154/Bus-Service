import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:shuttleservice/controller/home/users_tab_controller.dart';
import 'package:shuttleservice/module/model/home/users_list_model.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/utils/assets.dart';
import 'package:shuttleservice/view/utils/color.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/button.dart';
import 'package:shuttleservice/view/widget/custom_drop_down_widget.dart';
import 'package:shuttleservice/view/widget/textfields.dart';
import 'package:shuttleservice/view/widget/widgets.dart';

import '../../../module/model/home/site_list_model.dart';

class AddUserScreen extends StatefulWidget {
  UsersListData? user;
  String? screenName;

  AddUserScreen({Key? key, required this.screenName, this.user}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  UsersTabController usersTabController = Get.put(UsersTabController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.screenName == "EditUser") {
      usersTabController.startSiteC.clear();
      usersTabController.endSiteC.clear();
      usersTabController.fromId = null;
      usersTabController.endId = null;
      usersTabController.selectedUserType = widget.user?.userType.toString() ?? "";
      if (usersTabController.selectedUserType == "sub_admin") {
        usersTabController.selectedUserType = Str.subAdmin1;
      } else {
        usersTabController.selectedUserType = Str.siteManager1;
      }
      print("selectedUserType == ${usersTabController.selectedUserType}");
      if (usersTabController.selectedUserType == Str.subAdmin1) {
        List<String> list = widget.user!.userAccess!.split(",");
        print("list == ${list}");
        print("list == ${usersTabController.userAccess}");
        usersTabController.selected = [];
        for (int i = 0; i < usersTabController.userAccess.length; i++) {
          for (int j = 0; j < list.length; j++) {
            if (usersTabController.userAccess[i] == list[j].replaceAll(" ", "")) {
              usersTabController.selected.add(usersTabController.userAccess[i]);
            }
          }
        }
        print(usersTabController.selected);
      } else {
        usersTabController.startSiteC.clear();
        usersTabController.endSiteC.clear();
        usersTabController.fromId = null;
        usersTabController.endId = null;
        usersTabController.fromId?.isEmpty;
        // usersTabController.sitesTabController.selectedSSite = null;
        // usersTabController.sitesTabController.selectedESite = null;
        for (int index = 0; index < usersTabController.sitesTabController.siteListForAdd.length; index++) {
          if (usersTabController.sitesTabController.siteListForAdd[index].name == widget.user?.startSiteName) {
            // usersTabController.sitesTabController.selectedSSite = usersTabController.sitesTabController.siteListForAdd[index];
            usersTabController.startSiteC.text = usersTabController.sitesTabController.siteListForAdd[index].name.toString();
            usersTabController.fromId = usersTabController.sitesTabController.siteListForAdd[index].id.toString();
          }
        }
        for (int index = 0; index < usersTabController.sitesTabController.siteListForAdd.length; index++) {
          if (usersTabController.sitesTabController.siteListForAdd[index].name == widget.user?.endSiteName) {
            // usersTabController.sitesTabController.selectedESite = usersTabController.sitesTabController.siteListForAdd[index];
            usersTabController.endSiteC.text = usersTabController.sitesTabController.siteListForAdd[index].name.toString();
            usersTabController.endId = usersTabController.sitesTabController.siteListForAdd[index].id;
          }
        }
        // print("selectedSSite == ${usersTabController.sitesTabController.selectedSSite?.name}");
        // print("selectedESite == ${usersTabController.sitesTabController.selectedESite?.name}");
        print("selectedSSite == ${usersTabController.fromId}");
        print("selectedESite == ${usersTabController.endId}");
      }

      usersTabController.uNameC.text = widget.user?.userName.toString() ?? "";
      usersTabController.emailC.text = widget.user?.emailId.toString() ?? "";
      usersTabController.phoneNoC.text = widget.user?.userPhone.toString() ?? "";
      usersTabController.passwordC.text = widget.user?.userPassword.toString() ?? "";
    } else {
      usersTabController.submitted = false;
      usersTabController.selectedUserType = null;
      usersTabController.selected = [];
      usersTabController.fromId = null;
      usersTabController.endId = null;
      // usersTabController.sitesTabController.selectedSSite = null;
      // usersTabController.sitesTabController.selectedESite = null;
      usersTabController.startSiteC.clear();
      usersTabController.endSiteC.clear();
      usersTabController.uNameC.clear();
      usersTabController.emailC.clear();
      usersTabController.phoneNoC.clear();
      usersTabController.passwordC.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsersTabController>(
      init: UsersTabController(),
      builder: (controller) {
        return KeyboardDismisser(
          gestures: [GestureType.onTap, GestureType.onPanUpdateAnyDirection],
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 15.w,
              titleSpacing: 0,
              centerTitle: true,
              title: Text(
                widget.screenName == "EditUser" ? "Edit User" : Str.addUser,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    userSText(text: Str.uType),
                    DropdownButtonFormField2(
                      alignment: Alignment.centerLeft,
                      decoration: InputDecoration(
                        // contentPadding: EdgeInsets.symmetric(vertical: 1.4.w),
                        contentPadding: EdgeInsets.only(bottom: 3.5.w, left: 0.w),
                        border: borderInput,
                        focusedBorder: focusBorderInput,
                        errorBorder: errorBoarderInput,
                        enabledBorder: borderInput,
                        hintStyle: hintTextStyle,
                        filled: true,
                        fillColor: Clr.textFieldBgClr,
                      ),
                      buttonHeight: 9.5.w,
                      style: inputTextStyle,
                      isExpanded: true,
                      hint: Text(
                        "Select User Type",
                        style: hintTextStyle,
                      ),
                      icon: Padding(
                        padding: EdgeInsets.only(right: 2.w),
                        child: SvgPicture.asset(AstSVG.dropDownArrow_ic, color: Clr.textFieldHintClr),
                      ),
                      iconSize: 8.w,
                      // buttonHeight: 10.w,
                      value: controller.selectedUserType,
                      // dropdownPadding: EdgeInsets.only(left: 2.55.w, right: 2.55.w, top: 1.5.w, bottom: 1.5.w),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(2.5.w),
                          bottomRight: Radius.circular(2.5.w),
                        ),
                      ),
                      selectedItemBuilder: (BuildContext context) {
                        //<-- SEE HERE
                        return controller.userType.map((item) {
                          return Text(
                            item,
                            style: inputTextStyle,
                          );
                        }).toList();
                      },
                      items: controller.userType
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                onTap: () {
                                  controller.selectedUserType = item;
                                  setState(() {});
                                },
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                    color: controller.selectedUserType == item.toString() ? Clr.primaryClr : Clr.bottomTextClr,
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return "    Please Select User Type";
                        }
                        return null;
                      },
                      onChanged: (value) async {
                        controller.selectedUserType = value.toString();
                        if (controller.selectedUserType == Str.siteManager1) {
                          usersTabController.startSiteC.clear();
                          usersTabController.fromId = null;
                          usersTabController.endId = null;
                          usersTabController.endSiteC.clear();
                          controller.selectedUserType == Str.siteManager1;
                          // await controller.sitesTabController.getSiteList(status: "active", loader: 0);
                          controller.update();
                        } else {
                          controller.selectedUserType == Str.subAdmin1;
                          controller.update();
                        }
                        controller.update();
                      },
                      onSaved: (value) {
                        controller.selectedUserType = value.toString();
                      },
                    ),
                    /*MyDropDown(
                      hintText: "Select User Type",
                      itemList: controller.userType,
                      selectedValue: controller.selectedUserType,
                      validatorText: "    Please Select User Type",
                      onChange: (value) async {
                        controller.selectedUserType = value.toString();
                        if (controller.selectedUserType == Str.siteManager) {
                          controller.selectedUserType == Str.siteManager;
                          await controller.sitesTabController.getSiteList(status: "active", loader: 0);
                          controller.update();
                        } else {
                          controller.selectedUserType == Str.subAdmin;
                          controller.update();
                        }
                        controller.update();
                      },
                    ),*/
                    controller.selectedUserType == Str.siteManager1 ? userSText(text: Str.startSite) : userSText(text: Str.access),
                    controller.selectedUserType == Str.siteManager1
                        ? MyTextField(
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
                                                      for (int index = 0; index < controller.sitesTabController.siteListForAdd.length; index++) {
                                                        if ("${controller.sitesTabController.siteListForAdd[index].name}".toLowerCase().contains(controller.searchC2.text.toLowerCase())) {
                                                          controller.filteredStartSite.add(controller.sitesTabController.siteListForAdd[index]);
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
                                                                  selected: controller.startSiteC.text == controller.sitesTabController.siteListForAdd[i].name.toString(),
                                                                  onTap: () {
                                                                    controller.startSiteC.text = controller.sitesTabController.siteListForAdd[i].name.toString();
                                                                    controller.fromId = controller.sitesTabController.siteListForAdd[i].id.toString();
                                                                    Get.back();
                                                                    setSta(() {});
                                                                  },
                                                                  name: controller.sitesTabController.siteListForAdd[i].name.toString(),
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
                          )
                        /*DropdownButtonFormField2<SiteListData?>(
                            alignment: Alignment.centerLeft,
                            decoration: InputDecoration(
                              // contentPadding: EdgeInsets.symmetric(vertical: 1.w),
                              contentPadding: EdgeInsets.only(bottom: 3.5.w, left: 0.w),
                              border: borderInput,
                              focusedBorder: focusBorderInput,
                              errorBorder: errorBoarderInput,
                              enabledBorder: borderInput,
                              hintStyle: hintTextStyle,
                              filled: true,
                              fillColor: Clr.textFieldBgClr,
                            ),
                            buttonHeight: 9.5.w,
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
                            // buttonHeight: 10.w,
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
                              controller.update();
                            },
                          )*/
                        : Container(
                            color: Clr.textFieldBgClr,
                            child: DropDownMultiSelect(
                              options: controller.userAccess,
                              style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500, color: Clr.bottomTextClr),
                              selectedValues: controller.selected,
                              onChanged: (List<String> x) {
                                controller.selected = x;
                                controller.update();
                                Future.delayed(Duration(milliseconds: 500), () {
                                  controller.update();
                                });
                              },
                              inputStyle: TextStyle(fontWeight: FontWeight.w600, color: Clr.tabTextClr, height: 1.2, fontSize: 13.sp),
                              hint: Text(
                                "Select Access",
                                style: TextStyle(color: Clr.textFieldHintClr2, fontWeight: FontWeight.w400, height: 1.2, fontSize: 13.sp),
                              ),
                              icon: Padding(
                                padding: EdgeInsets.only(right: 2.w),
                                child: SvgPicture.asset(AstSVG.dropDownArrow_ic, color: Clr.textFieldHintClr),
                              ),
                              validator: (value) {
                                return value == null ? "Please Select User Access" : null;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 3.3.w, bottom: 3.3.w, left: 4.w),
                                border: borderInput,
                                enabledBorder: borderInput,
                                focusedBorder: focusBorderInput,
                                errorBorder: errorBoarderInput,
                                // filled: true,
                                fillColor: Clr.textFieldBgClr,
                              ),
                            ),
                          ),
                    controller.selectedUserType == Str.siteManager1 ? userSText(text: Str.endSite) : SizedBox(),
                    controller.selectedUserType == Str.siteManager1
                        ? MyTextField(
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
                                                      for (int index = 0; index < controller.sitesTabController.siteListForAdd.length; index++) {
                                                        if ("${controller.sitesTabController.siteListForAdd[index].name}".toLowerCase().contains(controller.searchC3.text.toLowerCase())) {
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
                                                controller.sitesTabController.siteListForAdd.length != 0 && controller.searchC3.text.isEmpty
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
                          )
                        /*DropdownButtonFormField2<SiteListData?>(
                            alignment: Alignment.centerLeft,
                            decoration: InputDecoration(
                              // contentPadding: EdgeInsets.symmetric(vertical: 1.w),
                              contentPadding: EdgeInsets.only(bottom: 3.5.w, left: 0.w),
                              border: borderInput,
                              focusedBorder: focusBorderInput,
                              errorBorder: errorBoarderInput,
                              enabledBorder: borderInput,
                              hintStyle: hintTextStyle,
                              filled: true,
                              fillColor: Clr.textFieldBgClr,
                            ),
                            buttonHeight: 9.5.w,
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
                            // buttonHeight: 10.w,
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
                          )*/
                        /*MyDropDown(
                                hintText: "Select Site",
                                itemList: controller.endSiteType,
                                selectedValue: controller.selectedESite,
                                validatorText: "    Please Select End Site",
                                onChange: (value) {
                                  controller.selectedESite = value.toString();
                                  controller.update();
                                },
                              )*/
                        : SizedBox(),
                    userSText(text: Str.name),
                    MyTextField(
                      padding: EdgeInsets.zero,
                      fillColor: Clr.textFieldBgClr,
                      controller: controller.uNameC,
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
                    userSText(text: Str.email),
                    MyTextField(
                      padding: EdgeInsets.zero,
                      fillColor: Clr.textFieldBgClr,
                      controller: controller.emailC,
                      keyboardType: TextInputType.emailAddress,
                      inputFormat: Validate.emailFormat,
                      validate: Validate.emailVal,
                      onChanged: (_) {
                        controller.update();
                      },
                      hintText: Str.eEmail,
                      validator: (v) {
                        bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(v!);
                        if (v.isEmpty) {
                          return Validate.emailEmptyValidator;
                        } else if (!emailValid) {
                          return Validate.emailValidValidator;
                        }
                        return null;
                      },
                      border: borderInput,
                      focusBorder: focusBorderInput,
                      errorBorder: errorBoarderInput,
                      inputTextStyle: inputTextStyle,
                      hintTextStyle: hintTextStyle,
                    ),
                    userSText(text: Str.phoneNumber),
                    MyTextField(
                      padding: EdgeInsets.zero,
                      fillColor: Clr.textFieldBgClr,
                      maxLength: 10,
                      controller: controller.phoneNoC,
                      keyboardType: TextInputType.phone,
                      inputFormat: Validate.numberFormat,
                      validate: Validate.numVal,
                      onChanged: (_) {
                        controller.update();
                      },
                      /*prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 3.5.w, top: 3.2.w, bottom: 3.5.w),
                            child: Text(
                              "+91",
                              style: TextStyle(fontWeight: FontWeight.w600, color: Clr.tabTextClr, height: 1.2, fontSize: 13.sp),
                            ),
                          ),*/
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
                    userSText(text: Str.password),
                    MyTextField(
                      padding: EdgeInsets.zero,
                      fillColor: Clr.textFieldBgClr,
                      controller: controller.passwordC,
                      keyboardType: TextInputType.visiblePassword,
                      validate: Validate.passVal,
                      inputFormat: Validate.passFormat,
                      onChanged: (_) {
                        controller.update();
                      },
                      obscureText: controller.showPassword,
                      textInputAction: TextInputAction.done,
                      hintText: Str.ePassword,
                      suffixIcon: InkWell(
                        onTap: () {
                          controller.showPassClick();
                        },
                        child: Padding(padding: EdgeInsets.all(3.8.w), child: controller.showPassword ? SvgPicture.asset(AstSVG.eye_slash_ic) : SvgPicture.asset(AstSVG.eye_ic)),
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return Validate.passwordEmptyValidator;
                        } else if (v.length < 6) {
                          return Validate.passwordValidValidator;
                        }
                        return null;
                      },
                      border: borderInput,
                      focusBorder: focusBorderInput,
                      errorBorder: errorBoarderInput,
                      inputTextStyle: inputTextStyle,
                      hintTextStyle: hintTextStyle,
                    ),
                    SizedBox(height: 13.w),
                    Center(
                      child: MyButton(
                        width: 55.98.w,
                        title: widget.screenName == "EditUser" ? "Submit" : Str.addUser,
                        onClick: () async {
                          controller.submitted = true;
                          if (controller.formKey.currentState!.validate()) {
                            print("Add New User");
                            print(controller.selectedUserType.toString());
                            if (controller.selectedUserType == Str.siteManager1) {
                              // print(controller.sitesTabController.selectedSSite?.id.toString());
                              print(controller.fromId.toString());
                              print(controller.endId.toString());
                              // print(controller.sitesTabController.selectedESite?.id.toString());
                            } else {
                              print(controller.selected.toString().replaceAll("[", "").replaceAll("]", ""));
                            }
                            print(controller.uNameC.text.toString());
                            print(controller.emailC.text.toString());
                            print(controller.phoneNoC.text.toString());
                            print(controller.passwordC.text.toString());
                            widget.screenName == "EditUser"
                                ? await controller.editDeleteUser(
                                    widget.user?.userId.toString(),
                                    DeleteStatus: "",
                                    type: Str.subAdmin1,
                                    startId: controller.fromId.toString(),
                                    endId: controller.endId,
                                  )
                                : await controller.addUsers(
                                    startId: controller.fromId.toString(),
                                    endId: controller.endId,
                                  );
                          }
                          controller.update();
                        },
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
