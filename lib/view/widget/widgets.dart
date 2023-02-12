import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shuttleservice/controller/home/dashboard_tab_controller.dart';
import 'package:shuttleservice/controller/home/site_managers_controller/site_manager_home_screen_controller.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/utils/assets.dart';
import 'package:shuttleservice/view/utils/color.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/bottomsheet.dart';
import 'package:shuttleservice/view/widget/button.dart';
import 'package:shuttleservice/view/widget/buttons.dart';
import 'package:shuttleservice/view/widget/textfields.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

Widget userSText({required String? text, EdgeInsetsGeometry? padding}) {
  return Padding(
    padding: padding ?? EdgeInsets.only(top: 3.w, bottom: 1.38.w),
    child: Text(
      text.toString(),
      textAlign: TextAlign.start,
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11.5.sp, color: Clr.bottomTextClr),
    ),
  );
}

settingListTile({
  required String? name,
  Color? imageColor,
  double? minLeadingWidth,
  Color? textClr,
  Widget? leadings,
  bool selected = false,
  required void Function()? onTap,
  double? width,
  double? height,
}) {
  return InkWell(
    customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    onTap: onTap,
    // borderRadius: BorderRadius.circular(10),
    child: ListTile(
      minLeadingWidth: minLeadingWidth,
      dense: true,
      title: Text(
        name!,
        style: TextStyle(color: selected ? Clr.primaryClr : textClr ?? Clr.bottomTextClr, fontSize: 11.sp, fontWeight: FontWeight.w500),
      ),
      // trailing: Icon(Icons.arrow_forward_ios, color: Clr.settingSc),
    ),
  );
}

Future<List<DateTime?>?> calender(
  BuildContext context,
  config, {
  bool Function(DateTime)? selectableDayPredicate,
  List<DateTime?>? initialValue,
}) {
  return showCalendarDatePicker2Dialog(
    context: context,
    config: config,
    dialogSize: Size(325, 400),
    borderRadius: BorderRadius.circular(15),
    initialValue: initialValue!,
    dialogBackgroundColor: Color(0XFFF8F9FC),
    selectableDayPredicate: selectableDayPredicate,
  );
}

Widget tableViewTitle() {
  return Container(
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
  );
}

Widget tableContainer(
  BuildContext context, {
  String? startSite,
  String? startUName,
  String? startTime,
  String? userMobile,
  String? userEmail,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Text(
          startSite.toString(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 8.sp, color: Clr.tabTextClr, fontWeight: FontWeight.w600),
        ),
      ),
      SizedBox(height: 1.w),
      InkWell(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          showCustomBottomSheet(
            context,
            child: userDetails(
              context,
              userName: startUName.toString(),
              userMobile: userMobile.toString(),
              userEmail: userEmail.toString(),
            ),
          );
        },
        child: Text(
          startUName.toString(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 8.sp,
            shadows: [Shadow(color: Clr.bottomTextClr, offset: Offset(0, -2))],
            color: Colors.transparent,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
            decorationColor: Clr.bottomTextClr,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 0.5.w),
        child: Text(
          startTime.toString(),
          style: TextStyle(fontSize: 7.3.sp, color: Clr.bottomTextClr, fontWeight: FontWeight.w700),
        ),
      ),
    ],
  );
}

Widget userDetails(BuildContext context, {String? userName, String? userMobile, String? userEmail}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.071.w, vertical: 2.54.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 3.5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text("Details", style: TextStyle(fontSize: 13.sp, color: Clr.textFieldTextClr, fontWeight: FontWeight.w600)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 0),
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
        Padding(
          padding: EdgeInsets.only(left: 0.5.w, bottom: 1.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userName.toString(),
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp, color: Clr.tabTextClr),
              ),
              Padding(
                padding: EdgeInsets.only(right: 2.w),
                child: InkWell(
                  onTap: () {
                    launchUrlString('tel:+91 ${userMobile.toString()}');
                  },
                  child: Container(
                    height: 8.w,
                    width: 8.w,
                    child: SvgPicture.asset(AstSVG.call_ic),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            SvgPicture.asset(AstSVG.phone_ic),
            Padding(
              padding: EdgeInsets.only(left: 2.w),
              child: Text(
                "+91 ${userMobile.toString()}",
                style: TextStyle(fontSize: 10.sp, color: Clr.bottomTextClr, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.w),
        Row(
          children: [
            SvgPicture.asset(AstSVG.email_ic_2),
            Padding(
              padding: EdgeInsets.only(left: 2.w),
              child: Text(
                userEmail.toString(),
                style: TextStyle(fontSize: 10.sp, color: Clr.bottomTextClr, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        SizedBox(height: 7.w),
      ],
    ),
  );
}

logOutDialog(BuildContext context, DashboardTabController controller) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Clr.whiteClr,
        titlePadding: EdgeInsets.only(
          top: 3.h,
          bottom: 2.h,
        ),
        contentPadding: EdgeInsets.all(2.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.w)),
        title: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          child: Text(
            Str.logoutStr,
            textAlign: TextAlign.center,
            style: TextStyle(color: Clr.textFieldTextClr, fontSize: 16.sp),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(bottom: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Button(
                    height: 9.w,
                    width: 26.w,
                    buttonColor: Color(0xFF10A932),
                    fontWeight: FontWeight.w500,
                    textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Colors.white),
                    onPressed: () async {
                      await controller.userLogOut();
                      controller.update();
                    },
                    text: Str.yesStr),
                SizedBox(width: 4.w),
                Button(
                    height: 9.w,
                    width: 26.w,
                    fontWeight: FontWeight.w500,
                    textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Colors.white),
                    buttonColor: Color(0xFFF6655A),
                    onPressed: () {
                      Get.back();
                    },
                    text: Str.noStr),
              ],
            ),
          )
        ],
      );
    },
  );
}

deleteDialog(BuildContext context, {String? textTitle, void Function()? onPressed}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Clr.whiteClr,
        titlePadding: EdgeInsets.only(
          top: 3.h,
          bottom: 2.h,
        ),
        contentPadding: EdgeInsets.all(2.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.w)),
        title: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          child: Text(
            textTitle.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(color: Clr.textFieldTextClr, fontSize: 16.sp),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(bottom: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Button(
                  height: 9.w,
                  width: 26.w,
                  buttonColor: Color(0xFF10A932),
                  fontWeight: FontWeight.w500,
                  textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Colors.white),
                  onPressed: onPressed,
                  text: Str.yesStr,
                ),
                SizedBox(width: 4.w),
                Button(
                  height: 9.w,
                  width: 26.w,
                  fontWeight: FontWeight.w500,
                  textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Colors.white),
                  buttonColor: Color(0xFFF6655A),
                  onPressed: () {
                    Get.back();
                  },
                  text: Str.noStr,
                ),
              ],
            ),
          )
        ],
      );
    },
  );
}

////

Widget UserCard({
  required BuildContext context,
  required String? userName,
  required String? userPhone,
  required String? emailId,
  required String? userPassword,
  required void Function() onTapEdit,
  required void Function() onTapDelete,
}) {
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
                      userName ?? "",
                      style: TextStyle(fontSize: 13.sp, color: Clr.tabTextClr, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.32.w, right: 2.w),
                      child: InkWell(
                        onTap: () {
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
                                      onTap: onTapEdit,
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
                                      onTap: onTapDelete,
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
                        userPhone ?? "",
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
                        emailId ?? "",
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
                          userPassword ?? "",
                          style: TextStyle(fontSize: 10.sp, color: Clr.bottomTextClr, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      InkWell(
                        onTap: () {},
                        child: Icon(Icons.visibility_off, color: Clr.bottomTextClr, size: 5.w),
                      ),
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
                    launchUrlString('tel:+91 ${userPhone}');
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
}

Widget noDataWidget({String? title, String? des}) {
  return Container(
    constraints: BoxConstraints(maxWidth: 80.w, maxHeight: 100.w),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title ?? "",
          textAlign: TextAlign.center,
          style: TextStyle(color: Clr.textFieldHintClr2, fontWeight: FontWeight.w400, height: 1.2, fontSize: 20.sp),
        ),
        SizedBox(
          height: 1.5.w,
        ),
        Text(
          des ?? "",
          textAlign: TextAlign.center,
          style: TextStyle(color: Clr.textFieldHintClr2, fontWeight: FontWeight.w400, height: 1.2, fontSize: 20.sp),
        ),
      ],
    ),
  );
}
