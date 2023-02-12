import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shuttleservice/controller/home/site_managers_controller/site_manager_home_screen_controller.dart';
import 'package:shuttleservice/controller/home/trips_tab_controller.dart';
import 'package:shuttleservice/module/model/home/site_manager/start_trip_list_model.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/screen/home/edit_trip_screen_admin.dart';
import 'package:shuttleservice/view/screen/home/site_managers_screen/home_tab_screen/create_trip_screen.dart';
import 'package:shuttleservice/view/utils/assets.dart';
import 'package:shuttleservice/view/utils/color.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/button.dart';
import 'package:shuttleservice/view/widget/buttons.dart';
import 'package:shuttleservice/view/widget/textfields.dart';
import 'package:shuttleservice/view/widget/widgets.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TableView extends StatelessWidget {
  BuildContext context;
  String? date;
  String? busNo;
  String? startSite;
  String? startSite2;
  String? startUName;
  String? startUName2;
  String? startTime;
  String? startTime2;
  String? endSite;
  String? endSite2;
  String? endUName;
  String? endUName2;
  String? endTime;
  String? endTime2;
  int? passenger1;
  int? passenger2;
  String? driverDetalis;
  bool? endStatus;
  SiteMHomeScreenController? controller;

  TableView({
    Key? key,
    required this.context,
    this.date,
    this.busNo,
    this.startSite,
    this.startSite2,
    this.startUName,
    this.startUName2,
    this.startTime,
    this.startTime2,
    this.endSite,
    this.endSite2,
    this.endUName,
    this.endUName2,
    this.endTime,
    this.endTime2,
    this.passenger1,
    this.passenger2,
    this.driverDetalis,
    this.endStatus,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Clr.whiteClr,
        //  borderRadius: BorderRadius.only(
        //   bottomLeft:  Radius.circular(2.78.w),
        //   bottomRight:  Radius.circular(2.78.w),
        // ),
      ),
      child: IntrinsicWidth(
        child: Column(
          children: [
            Container(height: 0.3.w, color: Clr.borderClr),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    width: 11.5.w,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(color: Clr.borderClr, width: 0.3.w),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 1.w, right: 1.w, top: 1.67.w),
                      child: Text(
                        date.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 8.sp, color: Clr.tabTextClr, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    width: 12.5.w,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(color: Clr.borderClr, width: 0.3.w),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 1.67.w),
                      child: Text(
                        busNo.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 8.sp, color: Clr.tabTextClr, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  IntrinsicWidth(
                    child: Column(
                      children: [
                        Container(
                          width: 40.w,
                          height: 23.w,
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(color: Clr.borderClr, width: 0.3.w),
                          )),
                          child: Column(
                            children: [
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 20.w,
                                      height: 16.5.w,
                                      padding: EdgeInsets.only(left: 1.w, top: 1.67.w, bottom: 1.w),
                                      decoration: BoxDecoration(
                                          border: Border(
                                        right: BorderSide(color: Clr.borderClr, width: 0.3.w),
                                        bottom: BorderSide(color: Clr.borderClr, width: 0.3.w),
                                      )),
                                      child: tableContainer(
                                        context,
                                        startSite: startSite.toString(),
                                        startUName: startUName.toString(),
                                        startTime: startTime.toString(),
                                      ),
                                    ),
                                    Container(
                                      width: 20.w,
                                      height: 16.5.w,
                                      padding: EdgeInsets.only(left: 1.w, top: 1.67.w, bottom: 1.w),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(color: Clr.borderClr, width: 0.3.w),
                                        ),
                                      ),
                                      child: IntrinsicWidth(
                                        child: tableContainer(
                                          context,
                                          startSite: endSite,
                                          startUName: endUName,
                                          startTime: endTime,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(padding: EdgeInsets.only(top: 0.5.w, bottom: 0.5.w), child: Text("data")),
                            ],
                          ),
                        ),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Container(
                                width: 20.w,
                                height: 16.5.w,
                                padding: EdgeInsets.only(left: 1.w, top: 1.67.w, bottom: 1.w),
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(color: Clr.borderClr, width: 0.3.w),
                                  ),
                                ),
                                child: tableContainer(
                                  context,
                                  startSite: startSite2,
                                  startUName: startUName2,
                                  startTime: startTime2,
                                ),
                              ),
                              Container(
                                width: 20.w,
                                height: 16.5.w,
                                padding: EdgeInsets.only(left: 1.w, top: 1.67.w, bottom: 1.w),
                                child: tableContainer(
                                  context,
                                  startSite: endSite2,
                                  startUName: endUName2,
                                  startTime: endTime2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IntrinsicWidth(
                    child: Container(
                      width: 10.9.w,
                      decoration: BoxDecoration(
                          border: Border(
                        left: BorderSide(color: Clr.borderClr, width: 0.3.w),
                      )),
                      child: Column(
                        children: [
                          Container(
                            height: 23.w,
                            width: 11.w,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Clr.borderClr, width: 0.3.w),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 1.67.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    passenger1.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 8.sp, color: Clr.tabTextClr, fontWeight: FontWeight.w600),
                                  ),
                                  endStatus == true
                                      ? Padding(
                                          padding: EdgeInsets.all(3),
                                          child: InkWell(
                                            onTap: () {
                                              showModalBottomSheet(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  backgroundColor: Clr.bgColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30.0)),
                                                  ),
                                                  builder: (BuildContext context) {
                                                    return SafeArea(
                                                      child: StatefulBuilder(builder: (context, setState) {
                                                        return SingleChildScrollView(
                                                          child: Container(
                                                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: 4.071.w, vertical: 2.54.w),
                                                              child: Form(
                                                                autovalidateMode: controller!.submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                                                                key: controller!.formKey,
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
                                                                              child: Text(Str.addBus, style: TextStyle(fontSize: 13.sp, color: Clr.textFieldTextClr, fontWeight: FontWeight.w600)),
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
                                                                    userSText(text: "No. of Passengers"),
                                                                    MyTextField(
                                                                      padding: EdgeInsets.zero,
                                                                      fillColor: Clr.textFieldBgClr,
                                                                      controller: controller!.noOFPassC,
                                                                      keyboardType: TextInputType.phone,
                                                                      inputFormat: Validate.numberFormat,
                                                                      validate: Validate.numVal,
                                                                      onChanged: (_) {
                                                                        controller?.update();
                                                                      },
                                                                      hintText: Str.eNumber,
                                                                      validator: (v) {
                                                                        if (v!.isEmpty) {
                                                                          return "Please Enter Number";
                                                                        }
                                                                        return null;
                                                                      },
                                                                      border: borderInput,
                                                                      focusBorder: focusBorderInput,
                                                                      errorBorder: errorBoarderInput,
                                                                      inputTextStyle: inputTextStyle,
                                                                      hintTextStyle: hintTextStyle,
                                                                    ),
                                                                    SizedBox(height: 3.5.w),
                                                                    Padding(
                                                                      padding: EdgeInsets.symmetric(vertical: 20),
                                                                      child: Center(
                                                                        child: MyButton(
                                                                          width: 62.w,
                                                                          title: "End Trip",
                                                                          onClick: () async {
                                                                            controller?.submitted = true;
                                                                            if (controller!.formKey.currentState!.validate()) {
                                                                              print("Add Site");
                                                                              print(controller?.noOFPassC.text.toString());
                                                                              // await controller?.endTrip(id: 2);
                                                                            }
                                                                            controller?.update();
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
                                                      }),
                                                    );
                                                  });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(bottom: 2.5, top: 2.5),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Clr.primaryClr,
                                                border: Border.all(color: Clr.primaryClr),
                                                borderRadius: BorderRadius.circular(3),
                                              ),
                                              child: Text(
                                                "End",
                                                style: TextStyle(fontSize: 7.sp, color: Clr.whiteClr, fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 16.5.w,
                            child: Padding(
                              padding: EdgeInsets.only(top: 1.67.w),
                              child: Text(
                                passenger2.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 8.sp, color: Clr.tabTextClr, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IntrinsicWidth(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                        left: BorderSide(color: Clr.borderClr, width: 0.3.w),
                      )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 14.8.w,
                            child: Text(
                              driverDetalis.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 8.5.sp, color: Clr.bottomTextClr, fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(height: 2.w),
                          InkWell(
                            onTap: () {
                              launchUrlString('tel:+91 ${7990305385}');
                            },
                            child: Container(
                              height: 7.w,
                              width: 7.w,
                              child: SvgPicture.asset(AstSVG.call_ic),
                            ),
                          ),
                        ],
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
  }
}

///
class StartTableView extends StatelessWidget {
  BuildContext context;
  String? date;
  String? busNo;
  String? driverDetalis;
  bool? endStatus;
  bool? triStatus;
  bool? startStatus;
  String? driverMobile;
  List<BusStatusData>? busStatusdata;
  BorderRadiusGeometry? borderRadius;

  int? dataIndex;

  StartTableView({
    Key? key,
    required this.context,
    this.date,
    this.busNo,
    this.driverDetalis,
    this.endStatus,
    this.triStatus,
    this.startStatus,
    this.busStatusdata,
    this.borderRadius,
    this.driverMobile,
    this.dataIndex,
  }) : super(key: key);

  String? durationString(fromTime, toTime) {
    Duration duration = DateFormat("hh:mm:ss a").parse(toTime!).difference(DateFormat("hh:mm:ss a").parse(fromTime!));
    printDuration(duration);
    return prettyDuration(duration).replaceAll("hours", "hr").replaceAll("minutes", "min").replaceAll("seconds", "sec");
  }

  SiteMHomeScreenController siteMHomeScreenController = Get.put(SiteMHomeScreenController());
  TripsTabController tripsTabController = Get.put(TripsTabController());

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: endStatus != true
          ? ActionPane(
              extentRatio: 0.15,
              motion: const ScrollMotion(),
              children: [
                IntrinsicWidth(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int i = 0; i < busStatusdata!.length; i++) ...[
                        InkResponse(
                            onTap: () {
                              triStatus == true
                                  ? Get.to(
                                      () => EditTripScreenAdmin(
                                        screen: "EditScreen",
                                        id: busStatusdata?[i].tripId,
                                        busNo: busNo,
                                        fromSideid: busStatusdata?[i].fromSideid.toString(),
                                        toSideid: busStatusdata?[i].toSideid.toString(),
                                        toSideName: busStatusdata?[i].toSiteName.toString(),
                                        fromSideName: busStatusdata?[i].fromSiteName,
                                        driveName: driverDetalis,
                                        driveMoblie: driverMobile,
                                        fromCount: busStatusdata?[i].toCount == "" ? "${busStatusdata?[i].fromCount ?? 0}" : "${busStatusdata?[i].toCount ?? 0}",
                                      ),
                                    )
                                  : Get.to(
                                      () => CreateTripScreen(
                                        screen: "EditScreen",
                                        id: busStatusdata?[i].tripId,
                                        busNo: busNo,
                                        fromSideid: busStatusdata?[i].fromSideid.toString(),
                                        toSideid: busStatusdata?[i].toSideid.toString(),
                                        toSideName: busStatusdata?[i].toSiteName.toString(),
                                        fromSideName: busStatusdata?[i].fromSiteName,
                                        driveName: driverDetalis,
                                        driveMoblie: driverMobile,
                                        fromCount: busStatusdata?[i].toCount == "" ? "${busStatusdata?[i].fromCount ?? 0}" : "${busStatusdata?[i].toCount ?? 0}",
                                      ),
                                    );
                            },
                            child: SizedBox(width: 13.w, child: SvgPicture.asset(AstSVG.edit, height: 5.w))),
                        InkResponse(
                            onTap: () {
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
                                        Str.deleteTripStr,
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
                                                  print("Yes");
                                                  triStatus == true
                                                      ? tripsTabController.deleteTrip(id: busStatusdata?[i].tripId).then((value) {
                                                          if (value == true) {
                                                            if (busStatusdata!.length > 1) {
                                                              tripsTabController.TripListData[dataIndex!].busStatusData!.remove(busStatusdata?[i]);
                                                            } else {
                                                              tripsTabController.TripListData.remove(tripsTabController.TripListData[dataIndex!]);
                                                            }
                                                            // await siteMHomeScreenController.startTripList(status: "", loader: 1, startDate: DateFormat('yyyy-MM-dd').format(siteMHomeScreenController.selectedDate));
                                                            tripsTabController.update();
                                                            Get.back();
                                                          }
                                                        })
                                                      : await siteMHomeScreenController.deleteTrip(id: busStatusdata?[i].tripId).then((value) async {
                                                          if (value == true) {
                                                            if (busStatusdata!.length > 1) {
                                                              // siteMHomeScreenController.startTripListData[dataIndex!].busStatusData!.remove(busStatusdata?[i]);
                                                            } else {
                                                              siteMHomeScreenController.startTripListData.remove(siteMHomeScreenController.startTripListData[dataIndex!]);
                                                            }
                                                            // await siteMHomeScreenController.startTripList(status: "", loader: 1, startDate: DateFormat('yyyy-MM-dd').format(siteMHomeScreenController.selectedDate));
                                                            siteMHomeScreenController.update();
                                                            Get.back();
                                                          }
                                                        });
                                                  siteMHomeScreenController.update();
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
                              // delete(context, controller!, id: busStatusdata?[i].tripId);
                              tripsTabController.update();
                            },
                            child: SizedBox(width: 13.w, child: SvgPicture.asset(AstSVG.delete, height: 5.w))),
                        if (busStatusdata!.length > 1 && i == 0) Divider(height: 1.w, thickness: 0.3.w, color: Clr.borderClr),
                      ],
                    ],
                  ),
                )
              ],
            )
          : null,
      child: Container(
        decoration: BoxDecoration(
          color: Clr.whiteClr,
          borderRadius: borderRadius,
        ),
        child: IntrinsicWidth(
          child: Column(
            children: [
              Container(height: 0.3.w, color: Clr.borderClr),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      width: 11.5.w,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: Clr.borderClr, width: 0.3.w),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 1.w, right: 1.w, top: 1.67.w),
                        child: Text(
                          date.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 8.sp, color: Clr.tabTextClr, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      width: 13.w,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: Clr.borderClr, width: 0.3.w),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 1.55.w, right: 1.w, left: 1.w),
                        child: Text(
                          busNo.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 11.5.sp, color: Clr.tabTextClr, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    IntrinsicWidth(
                      child: Column(
                        children: [
                          for (int i = 0; i < busStatusdata!.length; i++)
                            IntrinsicWidth(
                              child: Column(
                                children: [
                                  Container(
                                    width: 41.w,
                                    height: 22.w,
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: (busStatusdata?.length != i + 1) ? BorderSide(color: Clr.borderClr, width: 0.3.w) : BorderSide(color: Clr.borderClr, width: 0.0.w),
                                    )),
                                    child: Column(
                                      children: [
                                        IntrinsicHeight(
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 20.5.w,
                                                height: 16.5.w,
                                                padding: EdgeInsets.only(left: 1.w, top: 1.67.w, bottom: 1.w),
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(color: Clr.borderClr, width: 0.3.w),
                                                    bottom: (busStatusdata?.length != i + 1) ? BorderSide(color: Clr.borderClr, width: 0.3.w) : BorderSide(color: Clr.borderClr, width: 0.0.w),
                                                  ),
                                                ),
                                                child: tableContainer(
                                                  context,
                                                  startSite: busStatusdata?[i].fromSiteName ?? "",
                                                  startUName: busStatusdata?[i].fromUserName ?? "",
                                                  // startTime: busStatusdata?[i].fromTime ?? "",
                                                  startTime: "${DateFormat('hh:mm a').format(DateFormat("hh:mm:ss a").parse("${busStatusdata?[i].fromTime ?? ""}"))}",
                                                  userEmail: busStatusdata?[i].fromEmailId ?? "",
                                                  userMobile: busStatusdata?[i].fromUserPhone ?? "",
                                                ),
                                              ),
                                              Container(
                                                width: 20.5.w,
                                                height: 16.5.w,
                                                padding: EdgeInsets.only(left: 1.w, top: 1.67.w, bottom: 1.w),
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: (busStatusdata?.length != i + 1) ? BorderSide(color: Clr.borderClr, width: 0.3.w) : BorderSide(color: Clr.borderClr, width: 0.0.w),
                                                  ),
                                                ),
                                                child: IntrinsicWidth(
                                                  child: tableContainer(
                                                    context,
                                                    startSite: busStatusdata?[i].toSiteName ?? "",
                                                    startUName: busStatusdata?[i].toUserName ?? "",
                                                    // startTime: busStatusdata?[i].toTime ?? "",
                                                    startTime: busStatusdata?[i].toTime != "" && busStatusdata?[i].toTime != null ? "${DateFormat('hh:mm a').format(DateFormat("hh:mm:ss a").parse("${busStatusdata?[i].toTime ?? ""}"))}" : "",
                                                    userEmail: busStatusdata?[i].toEmailId ?? "",
                                                    userMobile: busStatusdata?[i].toUserPhone ?? "",
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (busStatusdata?[i].toTime != "" && busStatusdata?[i].toTime != null)
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 0.5.w, bottom: 0.5.w),
                                              child: Text(
                                                "Duration : ${durationString(busStatusdata?[i].fromTime, busStatusdata?[i].toTime)}",
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                style: TextStyle(fontSize: 8.sp, color: Clr.durationClr, fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    IntrinsicWidth(
                      child: Container(
                        width: 11.4.w,
                        decoration: BoxDecoration(
                            border: Border(
                          left: BorderSide(color: Clr.borderClr, width: 0.3.w),
                        )),
                        child: Column(
                          children: [
                            for (int i = 0; i < busStatusdata!.length; i++)
                              Container(
                                height: 22.w,
                                width: 11.w,
                                decoration: BoxDecoration(
                                  color: busStatusdata![i].toCount == "" || busStatusdata![i].toCount == null ? Color(0xFFFFC7C7) : null,
                                  border: Border(
                                    bottom: (busStatusdata?.length != i + 1) ? BorderSide(color: Clr.borderClr, width: 0.3.w) : BorderSide(color: Clr.borderClr, width: 0.0.w),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 1.67.w,bottom: 1.w),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        busStatusdata?[i].toCount == "" ? "${busStatusdata?[i].fromCount ?? 0}" : "${busStatusdata?[i].toCount ?? 0}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 8.sp, color: Clr.tabTextClr, fontWeight: FontWeight.w600),
                                      ),
                                      // endStatus == true ||
                                      triStatus == true
                                          // ? controller?.userModel?.userId != busStatusdata![i].fromUserId
                                          ? busStatusdata![i].toCount == "" || busStatusdata![i].toCount == null
                                              ? Padding(
                                                  padding: EdgeInsets.all(3),
                                                  child: InkWell(
                                                    onTap: () {
                                                      tripsTabController.noOFPassC.text = busStatusdata![i].fromCount.toString();
                                                      showModalBottomSheet(
                                                          context: context,
                                                          isScrollControlled: true,
                                                          backgroundColor: Clr.bgColor,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30.0)),
                                                          ),
                                                          builder: (BuildContext context) {
                                                            return SafeArea(
                                                              child: StatefulBuilder(builder: (context, setState) {
                                                                return SingleChildScrollView(
                                                                  child: Container(
                                                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                    child: Padding(
                                                                      padding: EdgeInsets.symmetric(horizontal: 4.071.w, vertical: 2.54.w),
                                                                      child: Form(
                                                                        autovalidateMode: tripsTabController.submitted2 ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                                                                        key: tripsTabController.formKey2,
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
                                                                                      child: Text(Str.addBus, style: TextStyle(fontSize: 13.sp, color: Clr.textFieldTextClr, fontWeight: FontWeight.w600)),
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
                                                                            userSText(text: "No. of Passengers"),
                                                                            MyTextField(
                                                                              padding: EdgeInsets.zero,
                                                                              fillColor: Clr.textFieldBgClr,
                                                                              controller: tripsTabController.noOFPassC,
                                                                              keyboardType: TextInputType.phone,
                                                                              inputFormat: Validate.numberFormat,
                                                                              validate: Validate.numVal,
                                                                              onChanged: (_) {
                                                                                tripsTabController.update();
                                                                              },
                                                                              hintText: Str.eNumber,
                                                                              validator: (v) {
                                                                                if (v!.isEmpty) {
                                                                                  return "Please Enter Number";
                                                                                }
                                                                                return null;
                                                                              },
                                                                              border: borderInput,
                                                                              focusBorder: focusBorderInput,
                                                                              errorBorder: errorBoarderInput,
                                                                              inputTextStyle: inputTextStyle,
                                                                              hintTextStyle: hintTextStyle,
                                                                            ),
                                                                            SizedBox(height: 3.5.w),
                                                                            Padding(
                                                                              padding: EdgeInsets.symmetric(vertical: 20),
                                                                              child: Center(
                                                                                child: MyButton(
                                                                                  width: 62.w,
                                                                                  title: "End Trip",
                                                                                  onClick: () async {
                                                                                    tripsTabController.submitted2 = true;
                                                                                    if (tripsTabController.formKey2.currentState!.validate()) {
                                                                                      print("Add Site");
                                                                                      print(tripsTabController.noOFPassC.text.toString());
                                                                                      print(busStatusdata?[i].tripId.toString());
                                                                                      await tripsTabController.endTrip(id: busStatusdata?[i].tripId.toString(), noOFPassC: tripsTabController.noOFPassC.text.toString());
                                                                                    }
                                                                                    tripsTabController.update();
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
                                                              }),
                                                            );
                                                          });
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.only(bottom: 3, top: 2.5),
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color: Clr.primaryClr,
                                                        border: Border.all(color: Clr.primaryClr),
                                                        borderRadius: BorderRadius.circular(3),
                                                      ),
                                                      child: Text(
                                                        "End",
                                                        style: TextStyle(fontSize: 9.sp, color: Clr.whiteClr, fontWeight: FontWeight.w600),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox()
                                          : SizedBox(),
                                      // : SizedBox(),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    IntrinsicWidth(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                          left: BorderSide(color: Clr.borderClr, width: 0.3.w),
                        )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 14.8.w,
                              child: Text(
                                driverDetalis == "" ? "-" : driverDetalis.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 8.5.sp, color: Clr.bottomTextClr, fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(height: 2.w),
                            driverMobile == ""
                                ? SizedBox()
                                : InkWell(
                                    onTap: () {
                                      FocusScopeNode currentFocus = FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }
                                      launchUrlString('tel:+91 ${driverMobile ?? ""}');
                                    },
                                    child: Container(
                                      height: 7.w,
                                      width: 7.w,
                                      child: SvgPicture.asset(AstSVG.call_ic),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
