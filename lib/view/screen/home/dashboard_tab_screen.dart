import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shuttleservice/controller/home/dashboard_tab_controller.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/screen/home/edit_profile_screen.dart';
import 'package:shuttleservice/view/utils/assets.dart';
import 'package:shuttleservice/view/utils/color.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/button.dart';
import 'package:shuttleservice/view/widget/buttons.dart';
import 'package:shuttleservice/view/widget/textfields.dart';
import 'package:shuttleservice/view/widget/toasts.dart';
import 'package:shuttleservice/view/widget/widgets.dart';

class DashboardTabScreen extends StatefulWidget {
  DashboardTabScreen({Key? key}) : super(key: key);

  @override
  State<DashboardTabScreen> createState() => _DashboardTabScreenState();
}

class _DashboardTabScreenState extends State<DashboardTabScreen> {
  final ReceivePort _port = ReceivePort();
  var dio = Dio();
  bool fileExist = false;

  @override
  void initState() {
    // TODO: implement initState
    getExist();
    // IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    // _port.listen((dynamic data) {
    //   String id = data[0];
    //   DownloadTaskStatus status = data[1];
    //   int progress = data[2];
    //   setState(() {});
    // });

    // FlutterDownloader.registerCallback(downloadCallback);
    super.initState();
  }

  getExist() async {
    fileExist = await File("/storage/emulated/0/Download/TripExel.xlsx").exists();
    setState(() {});
  }

  @override
  void dispose() {
    // IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  // static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
  //   final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port')!;
  //   send.send([id, status, progress]);
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardTabController>(
      init: DashboardTabController(),
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
                                Get.to(() => EditProfileScreen(type: ""));
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
                GestureDetector(
                  onTap: () {
                    print("setting");
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(7.63.w), topRight: Radius.circular(7.63.w)),
                        ),
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4.071.w, vertical: 2.54.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 0.w, bottom: 1.w),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  Str.setting,
                                                  style: TextStyle(color: Clr.textFieldTextClr, fontSize: 13.sp, fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(right: 0.0),
                                              child: InkWell(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(3.w),
                                                    child: SvgPicture.asset(AstSVG.close_ic, color: Clr.textFieldHintClr),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 2.5.w, bottom: 1.5.w),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: MyButton(
                                                buttonClr: controller.dashboardModel?.data?.sessionId != 0 ? Clr.sessStartClr : Clr.primaryClr,
                                                width: 62.w,
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w500,
                                                borderRadius: BorderRadius.circular(2.5.w),
                                                title: Str.sessionStart,
                                                onClick: () async {
                                                  if (controller.dashboardModel?.data?.sessionId == 0) {
                                                    Get.back();
                                                    sessionDialog(
                                                      context,
                                                      onPressedNagar: () async {
                                                        await controller.sessionStart(busesType: 1);
                                                        controller.update();
                                                      },
                                                      onPressedScheme: () async {
                                                        await controller.sessionStart(busesType: 2);
                                                        controller.update();
                                                      },
                                                    );
                                                    controller.update();
                                                  }
                                                },
                                              ),
                                            ),
                                            SizedBox(width: 3.w),
                                            Expanded(
                                              child: MyButton(
                                                buttonClr: controller.dashboardModel?.data?.sessionId != 0 ? Clr.primaryClr : Clr.sessStartClr,
                                                width: 62.w,
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w500,
                                                borderRadius: BorderRadius.circular(2.w),
                                                title: Str.sessionEnd,
                                                onClick: () async {
                                                  if (controller.dashboardModel?.data?.sessionId != 0) {
                                                    Get.back();
                                                    sessionDialog(
                                                      context,
                                                      onPressedNagar: () async {
                                                        await controller.sessionEnd(busesType: 1);
                                                        controller.update();
                                                      },
                                                      onPressedScheme: () async {
                                                        await controller.sessionEnd(busesType: 2);
                                                        controller.update();
                                                      },
                                                    );
                                                    controller.update();
                                                  } else {
                                                    print("Not Data");
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 3.5.w),
                                          child: controller.dashboardModel?.data?.sessionEndAt == ""
                                              ? Text(
                                                  "Start Time : ${DateFormat('hh:mm a').format(DateFormat("hh:mm:ss").parse("${controller.dashboardModel?.data?.sessionStartAt ?? ""}"))}",
                                                  style: TextStyle(color: Clr.textFieldHintClr, fontSize: 9.sp, fontWeight: FontWeight.w500),
                                                )
                                              : Text(
                                                  "End Time : ${DateFormat('hh:mm a').format(DateFormat("hh:mm:ss").parse("${controller.dashboardModel?.data?.sessionEndAt ?? ""}"))}",
                                                  style: TextStyle(color: Clr.textFieldHintClr, fontSize: 9.sp, fontWeight: FontWeight.w500),
                                                )),
                                      SizedBox(height: 2.w),
                                      Container(height: 0.4.w, color: Clr.borderClr),
                                      SizedBox(height: 2.5.w),
                                      ListTile(
                                        onTap: () {
                                          print("Log Out");
                                          Get.back();
                                          logOutDialog(context, controller);
                                          controller.update();
                                        },
                                        dense: true,
                                        minVerticalPadding: 0,
                                        contentPadding: EdgeInsets.zero,
                                        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                        title: Text(
                                          Str.logOut,
                                          style: TextStyle(color: Clr.textFieldTextClr, fontSize: 12.sp, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(height: 3.w),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                        });
                  },
                  child: SvgPicture.asset(
                    AstSVG.settings_ic,
                    width: 10.w,
                    height: 10.w,
                  ),
                )
              ],
            ),
          ),
          body: controller.userModel?.userType == "sub_admin"
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You have no access",
                        style: TextStyle(color: Clr.bottomTextClr, fontWeight: FontWeight.w500, height: 1.2, fontSize: 20.sp),
                      ),
                      Text(
                        "This screen can only viewed by admin",
                        style: TextStyle(color: Clr.bottomTextClr, fontWeight: FontWeight.w400, height: 1.2, fontSize: 14.sp),
                      ),
                    ],
                  ),
                )
              : SmartRefresher(
                  controller: controller.deshboardController,
                  onRefresh: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    controller.searchC.clear();
                    controller.update();
                    print(controller.startDate.toString());
                    print(controller.endDate.toString());

                    if (controller.startDate != null && controller.endDate != null) {
                      String startDate = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                      String endDate = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.endDate.toString()))}";
                      controller.dashboardCounter(startDate: startDate, endDate: endDate);
                    } else {
                      String startDate = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                      controller.dashboardCounter(startDate: startDate);
                    }

                    Future.delayed(Duration(milliseconds: 200), () {
                      controller.deshboardController.refreshCompleted();
                    });
                  },
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 0.5.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                          await controller.dashboardCounter(startDate: DateFormat("yyyy-MM-dd").format(DateTime.parse(controller.startDate.toString())));
                                          controller.update();
                                        } else {
                                          if (DateTime.parse(controller.endDate.toString()).difference(DateTime.parse(controller.startDate.toString())).inDays == 0) {
                                            controller.dateC.text = DateFormat("dd MMM yyyy").format(DateTime.parse(controller.startDate.toString()));
                                            await controller.dashboardCounter(startDate: DateFormat("yyyy-MM-dd").format(DateTime.parse(controller.startDate.toString())));
                                            controller.update();
                                          } else {
                                            controller.dateC.text = "${DateFormat("dd MMM yyyy").format(DateTime.parse(controller.startDate.toString()))} to ${DateFormat("dd MMM yyyy").format(DateTime.parse(controller.endDate.toString()))}";
                                            await controller.dashboardCounter(startDate: DateFormat("yyyy-MM-dd").format(DateTime.parse(controller.startDate.toString())), endDate: DateFormat("yyyy-MM-dd").format(DateTime.parse(controller.endDate.toString())));
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
                                  focusBorder: borderInput,
                                  border: borderInput,
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
                                      await controller.dashboardCounter(startDate: DateFormat("yyyy-MM-dd").format(DateTime.parse(controller.startDate.toString())));
                                      controller.update();
                                    } else {
                                      if (DateTime.parse(controller.endDate.toString()).difference(DateTime.parse(controller.startDate.toString())).inDays == 0) {
                                        controller.dateC.text = DateFormat("dd MMM yyyy").format(DateTime.parse(controller.startDate.toString()));
                                        await controller.dashboardCounter(startDate: DateFormat("yyyy-MM-dd").format(DateTime.parse(controller.startDate.toString())));
                                        controller.update();
                                      } else {
                                        controller.dateC.text = "${DateFormat("dd MMM yyyy").format(DateTime.parse(controller.startDate.toString()))} to ${DateFormat("dd MMM yyyy").format(DateTime.parse(controller.endDate.toString()))}";
                                        await controller.dashboardCounter(startDate: DateFormat("yyyy-MM-dd").format(DateTime.parse(controller.startDate.toString())), endDate: DateFormat("yyyy-MM-dd").format(DateTime.parse(controller.endDate.toString())));
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
                        SizedBox(height: 5.w),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            commonCard(text: "Trips", counter: controller.dashboardModel?.data?.tripCounter.toString() ?? "0"),
                            commonCard(text: "Total Buses", counter: controller.dashboardModel?.data?.busCounter.toString() ?? "0"),
                          ],
                        ),
                        SizedBox(height: 2.5.w),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            commonCard(text: "Total Passengers", counter: controller.dashboardModel?.data?.passenger.toString() ?? "0"),
                            commonCard(text: "Buses On the way", counter: controller.dashboardModel?.data?.onTheWayCounter.toString() ?? "0"),
                          ],
                        ),
                        SizedBox(height: 2.5.w),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            commonCard(text: "Buses On Nagar", counter: controller.dashboardModel?.data?.getNagerCounter.toString() ?? "0"),
                            commonCard(text: "Buses On Scheme", counter: controller.dashboardModel?.data?.getSchemeCounter.toString() ?? "0"),
                          ],
                        ),
                        SizedBox(height: 2.5.w),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            commonCard(text: "Trips With Passenger", counter: controller.dashboardModel?.data?.passengerTripCounter.toString() ?? "0"),
                            commonCard(text: "Empty Trips", counter: controller.dashboardModel?.data?.emptyTripCounter.toString() ?? "0"),
                          ],
                        ),
                        SizedBox(height: 4.w),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: MyButton(
                                width: 30.98.w,
                                title: "Export",
                                fontSize: 11.sp,
                                onClick: () async {
                                  final status = await Permission.storage.request();
                                  if (status.isGranted) {
                                    await controller.tripExport().then((value) async {
                                      if (value != null) {
                                        print(value);
                                        Directory? directory;
                                        directory = Directory('/storage/emulated/0/Download');
                                        // final externalDir = await getExternalStorageDirectory();
                                        // String path = externalDir!.path.toString();
                                        String path = directory.path.toString();
                                        print(path);
                                        // String url = "http://192.168.29.72/Shuttle_service";
                                        // String urlLive = "http://shuttle.appteamsurat.in";
                                        print("url = ${Utils.fileUrl}/${value}");
                                        // await FlutterDownloader.enqueue(url: "${Utils.fileUrl}/${value}", savedDir: path, fileName: "Trip Exel", showNotification: true, openFileFromNotification: true);
                                        try {
                                          await Dio().download("${Utils.fileUrl}/${value}", path + "/" + "TripExel.xlsx");
                                          print("Download Completed.");
                                          fileExist = await File("/storage/emulated/0/Download/TripExel.xlsx").exists();
                                          controller.update();
                                          MyToasts().successToast(toast: "Download Completed.");
                                        } catch (e) {
                                          print("Download Failed.\n\n" + e.toString());
                                          MyToasts().errorToast(toast: "Download Failed.\n" + e.toString());
                                        }
                                        controller.update();
                                      }
                                    });
                                  } else {
                                    print("Permission denied");
                                  }
                                  controller.update();
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.w),
                        if (fileExist)
                          Center(
                            child: InkWell(
                              onTap: () async {
                                print("On Tap");

                                await OpenFile.open("/storage/emulated/0/Download/TripExel.xlsx");

                                controller.update();
                              },
                              child: Text(
                                "View File",
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  shadows: [Shadow(color: Clr.bottomTextClr, offset: Offset(0, -2))],
                                  color: Colors.transparent,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Clr.bottomTextClr,
                                ),
                              ),
                            ),
                          ),
                        SizedBox(height: 4.w),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  sessionDialog(BuildContext context, {String? textTitle, void Function()? onPressedNagar, void Function()? onPressedScheme}) {
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
              "Please select your all buses location",
              textAlign: TextAlign.center,
              style: TextStyle(color: Clr.textFieldTextClr, fontSize: 15.sp),
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
                    buttonColor: Clr.primaryClr,
                    fontWeight: FontWeight.w500,
                    radius: 2.w,
                    textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Colors.white),
                    onPressed: onPressedNagar,
                    text: Str.nagar,
                  ),
                  SizedBox(width: 4.w),
                  Button(
                    height: 9.w,
                    width: 26.w,
                    radius: 2.w,
                    fontWeight: FontWeight.w500,
                    textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Colors.white),
                    buttonColor: Clr.primaryClr,
                    onPressed: onPressedScheme,
                    text: Str.scheme,
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Widget commonCard({
    required String? text,
    required String? counter,
  }) {
    return Container(
      height: 25.w,
      width: 43.55.w,
      decoration: BoxDecoration(
        color: Clr.whiteClr,
        borderRadius: BorderRadius.circular(2.8.w),
        border: Border.all(width: 0.3.w, color: Clr.primaryClr),
        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: [
        //     Clr.whiteClr.withOpacity(0.2),
        //     Clr.whiteClr.withOpacity(0.5),
        //     Color(0XFFBFADFF).withOpacity(0.4),
        //   ],
        // ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            counter.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 27.sp, color: Clr.primaryClr, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 2.w),
          Text(
            text.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.sp, color: Clr.textFieldTextClr, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
