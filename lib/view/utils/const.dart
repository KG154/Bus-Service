import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/utils/color.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");

//Local
// String baseUrl = "http://192.168.29.72/Shuttle_service/api/v1";

//Live
// String baseUrl = "http://shuttle.appteamsurat.in/api/v1";
String baseUrl = "http://shuttle.appteamsurat.in/Staging/api/v1";

class Utils {
  static String? token;
  static String? userID;
  static String? userType;
  static String? deviceToken;
  static String? deviceType;
  static String? applicationUpdate;
  static String? baseUrl;
  static String? fileUrl;
}

//TextStyle
TextStyle appTitleStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp, color: Clr.textFieldTextClr);
TextStyle inputTextStyle = TextStyle(fontWeight: FontWeight.w600, color: Clr.tabTextClr, height: 1.2, fontSize: 13.sp);
TextStyle hintTextStyle = TextStyle(color: Clr.textFieldHintClr2, fontWeight: FontWeight.w400, height: 1.2, fontSize: 13.sp);

InputBorder borderInput = OutlineInputBorder(borderSide: BorderSide(width: 0.50.w, color: Clr.borderClr), borderRadius: BorderRadius.circular(2.5.w));
InputBorder focusBorderInput = OutlineInputBorder(borderSide: BorderSide(width: 0.50.w, color: Clr.primaryClr), borderRadius: BorderRadius.circular(2.5.w));
InputBorder errorBoarderInput = OutlineInputBorder(borderRadius: BorderRadius.circular(2.5.w), borderSide: BorderSide(color: Clr.inactiveClr, width: 0.40.w));

//for calender
final config = CalendarDatePicker2WithActionButtonsConfig(
  calendarType: CalendarDatePicker2Type.range,
  selectedDayHighlightColor: Clr.primaryClr,
  closeDialogOnCancelTapped: true,
  firstDate: DateTime(2022),
  lastDate: DateTime(2030),
  gapBetweenCalendarAndButtons: 0.5.w,
  okButton: Container(
    alignment: Alignment.center,
    width: 23.33.w,
    height: 11.11.w,
    decoration: BoxDecoration(color: Clr.primaryClr, borderRadius: BorderRadius.circular(2.5.w), border: Border.all(color: Clr.primaryClr, width: 0.3.w)),
    child: Text(
      "Ok",
      style: TextStyle(color: Clr.whiteClr, fontWeight: FontWeight.w600, fontSize: 13.sp),
    ),
  ),
  cancelButton: Container(
    alignment: Alignment.center,
    width: 23.33.w,
    height: 11.11.w,
    decoration: BoxDecoration(color: Clr.whiteClr, borderRadius: BorderRadius.circular(2.5.w), border: Border.all(color: Clr.primaryClr, width: 0.3.w)),
    child: Text(
      "Cancel",
      style: TextStyle(color: Clr.primaryClr, fontWeight: FontWeight.w600, fontSize: 13.sp),
    ),
  ),
  dayTextStyle: TextStyle(color: Clr.tabTextClr, fontWeight: FontWeight.w500, fontSize: 11.sp),
);
