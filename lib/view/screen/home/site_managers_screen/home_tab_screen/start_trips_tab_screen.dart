import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shuttleservice/controller/home/site_managers_controller/site_manager_home_screen_controller.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/screen/home/site_managers_screen/home_tab_screen/create_trip_screen.dart';
import 'package:shuttleservice/view/utils/assets.dart';
import 'package:shuttleservice/view/utils/color.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/buttons.dart';
import 'package:shuttleservice/view/widget/tableview.dart';
import 'package:shuttleservice/view/widget/widgets.dart';
import 'package:url_launcher/url_launcher_string.dart';

class StartTripTabScreen extends StatelessWidget {
  StartTripTabScreen({Key? key}) : super(key: key);

  SiteMHomeScreenController siteMHomeScreenController = Get.put(SiteMHomeScreenController());

  String? durationString(fromTime, toTime) {
    Duration duration = DateFormat("hh:mm:ss a").parse(toTime!).difference(DateFormat("hh:mm:ss a").parse(fromTime!));
    printDuration(duration);
    return prettyDuration(duration).replaceAll("hours", "hr").replaceAll("minutes", "min").replaceAll("seconds", "sec");
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SiteMHomeScreenController>(
      init: SiteMHomeScreenController(),
      builder: (controller) {
        return Scaffold(
          floatingActionButton: Padding(
            padding: EdgeInsets.only(left: 9.w),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                onPressed: () {
                  Get.to(() => CreateTripScreen(screen: "addscreen"));
                },
                child: Icon(Icons.add, color: Clr.whiteClr, size: 8.w),
                elevation: 0,
                backgroundColor: Clr.primaryClr,
              ),
            ),
          ),
          body: SmartRefresher(
            controller: controller.tripCController,
            onRefresh: () {
              controller.busNumFilterC.clear();
              controller.startSiteFilterC.clear();
              controller.endSiteFilterC.clear();
              if (controller.startDate != null && controller.endDate != null) {
                String startDate = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                String endDate = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.endDate.toString()))}";
                controller.startTripList(status: "", loader: 0, startDate: startDate, endDate: endDate);
                controller.endTripList(loader: 0, startDate: startDate, endDate: endDate);
                // siteMHomeScreenController.startTripList(status: "end_site", loader: 0, startDate: startDate, endDate: endDate);
              } else {
                String startDate = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                controller.startTripList(status: "", loader: 0, startDate: startDate);
                controller.endTripList(loader: 0, startDate: startDate);
                // siteMHomeScreenController.startTripList(status: "end_site", loader: 0, startDate: startDate);
              }

              Future.delayed(Duration(milliseconds: 200), () {
                controller.tripCController.refreshCompleted();
              });
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 1.3.w),
              child: controller.startTripListData.length != 0
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
                            for (int index = 0; index < controller.startTripListData.length; index++)
                              Slidable(
                                endActionPane: ActionPane(
                                  extentRatio: 0.15,
                                  motion: const ScrollMotion(),
                                  children: [
                                    IntrinsicWidth(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          // for (int i = 0; i < busStatusdata!.length; i++) ...[
                                          InkResponse(
                                              onTap: () {
                                                Get.to(
                                                  () => CreateTripScreen(
                                                    screen: "EditScreen",
                                                    id: controller.startTripListData[index].id,
                                                    busNo: controller.startTripListData[index].busNumber,
                                                    fromSideid: controller.startTripListData[index].fromSideid.toString(),
                                                    toSideid: controller.startTripListData[index].toSideid.toString(),
                                                    fromSideName: controller.startTripListData[index].fromSiteName,
                                                    toSideName: controller.startTripListData[index].toSiteName,
                                                    driveName: controller.startTripListData[index].driveName,
                                                    driveMoblie: controller.startTripListData[index].driveMoble,
                                                    fromCount: controller.startTripListData[index].toCount == "" ? "${controller.startTripListData[index].fromCount ?? 0}" : "${controller.startTripListData[index].toCount ?? 0}",
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
                                                                    await controller.deleteTrip(id: controller.startTripListData[index].id).then((value) async {
                                                                      if (value == true) {
                                                                        controller.startTripListData.remove(controller.startTripListData[index]);
                                                                        controller.update();
                                                                        Get.back();
                                                                      }
                                                                    });
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
                                                // delete(context, controller!, id: busStatusdata?[i].tripId);
                                                controller.update();
                                              },
                                              child: SizedBox(width: 13.w, child: SvgPicture.asset(AstSVG.delete, height: 5.w))),
                                          // if (busStatusdata!.length > 1 && i == 0) Divider(height: 1.w, thickness: 0.3.w, color: Clr.borderClr),
                                          // ],
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Clr.whiteClr,
                                    borderRadius: controller.startTripListData.length == index + 1
                                        ? BorderRadius.only(bottomLeft: Radius.circular(2.78.w), bottomRight: Radius.circular(2.78.w))
                                        : BorderRadius.only(
                                            bottomLeft: Radius.circular(0.w),
                                            bottomRight: Radius.circular(0.w),
                                          ),
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
                                                    controller.startTripListData[index].fromDate ?? "",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(fontSize: 9.sp, color: Clr.tabTextClr, fontWeight: FontWeight.w600),
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
                                                    controller.startTripListData[index].busNumber ?? "",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(fontSize: 11.5.sp, color: Clr.tabTextClr, fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                              IntrinsicWidth(
                                                child: Column(
                                                  children: [
                                                    // for (int i = 0; i < busStatusdata!.length; i++)
                                                    IntrinsicWidth(
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            width: 41.w,
                                                            height: 22.w,
                                                            decoration: BoxDecoration(
                                                                border: Border(
                                                                    // bottom: (busStatusdata?.length != i + 1) ? BorderSide(color: Clr.borderClr, width: 0.3.w) : BorderSide(color: Clr.borderClr, width: 0.0.w),
                                                                    // bottom: BorderSide(color: Clr.borderClr, width: 0.3.w),
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
                                                                            // bottom: (busStatusdata?.length != i + 1) ? BorderSide(color: Clr.borderClr, width: 0.3.w) : BorderSide(color: Clr.borderClr, width: 0.0.w),
                                                                            bottom: BorderSide(color: Clr.borderClr, width: 0.3.w),
                                                                          ),
                                                                        ),
                                                                        child: tableContainer(
                                                                          context,
                                                                          startSite: controller.startTripListData[index].fromSiteName ?? "",
                                                                          startUName: controller.startTripListData[index].fromUserName ?? "",
                                                                          // startTime: busStatusdata?[i].fromTime ?? "",
                                                                          startTime: "${DateFormat('hh:mm a').format(DateFormat("hh:mm:ss a").parse("${controller.startTripListData[index].fromTime ?? ""}"))}",
                                                                          userEmail: controller.startTripListData[index].fromEmailId ?? "",
                                                                          userMobile: controller.startTripListData[index].fromUserPhone ?? "",
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: 20.5.w,
                                                                        height: 16.5.w,
                                                                        padding: EdgeInsets.only(left: 1.w, top: 1.67.w, bottom: 1.w),
                                                                        decoration: BoxDecoration(
                                                                          border: Border(
                                                                            // bottom: (busStatusdata?.length != i + 1) ? BorderSide(color: Clr.borderClr, width: 0.3.w) : BorderSide(color: Clr.borderClr, width: 0.0.w),
                                                                            bottom: BorderSide(color: Clr.borderClr, width: 0.3.w),
                                                                          ),
                                                                        ),
                                                                        child: IntrinsicWidth(
                                                                          child: tableContainer(
                                                                            context,
                                                                            startSite: controller.startTripListData[index].toSiteName ?? "",
                                                                            startUName: controller.startTripListData[index].toUserName ?? "",
                                                                            // startTime: controller.startTripListData[index].toTime ?? "",
                                                                            startTime: controller.startTripListData[index].toTime != "" ? "${DateFormat('hh:mm a').format(DateFormat("hh:mm:ss a").parse("${controller.startTripListData[index].toTime ?? ""}"))}" : "",
                                                                            userEmail: controller.startTripListData[index].toEmailId ?? "",
                                                                            userMobile: controller.startTripListData[index].toUserPhone ?? "",
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                if (controller.startTripListData[index].toTime != "")
                                                                  Expanded(
                                                                    child: Padding(
                                                                      padding: EdgeInsets.only(top: 0.5.w, bottom: 0.5.w),
                                                                      child: Text(
                                                                        "Duration : ${durationString(controller.startTripListData[index].fromTime, controller.startTripListData[index].toTime)}",
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
                                                      color: controller.startTripListData[index].toCount == "" || controller.startTripListData[index].toCount == null ? Color(0xFFFFC7C7) : null,
                                                      border: Border(
                                                    left: BorderSide(color: Clr.borderClr, width: 0.3.w),
                                                  )),
                                                  child: Column(
                                                    children: [
                                                      // for (int i = 0; i < busStatusdata!.length; i++)
                                                      Container(
                                                        height: 22.w,
                                                        width: 11.w,
                                                        decoration: BoxDecoration(
                                                          border: Border(
                                                              // bottom: (busStatusdata?.length != i + 1) ? BorderSide(color: Clr.borderClr, width: 0.3.w) : BorderSide(color: Clr.borderClr, width: 0.0.w),
                                                              // bottom: BorderSide(color: Clr.borderClr, width: 0.3.w),
                                                              ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: 1.67.w),
                                                          child: Text(
                                                            controller.startTripListData[index].toCount == null || controller.startTripListData[index].toCount == "" ? "${controller.startTripListData[index].fromCount ?? 0}" : "${controller.startTripListData[index].toCount ?? 0}",
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
                                                          controller.startTripListData[index].driveName == "" ? "-" : controller.startTripListData[index].driveName ?? "",
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(fontSize: 8.5.sp, color: Clr.bottomTextClr, fontWeight: FontWeight.w500),
                                                        ),
                                                      ),
                                                      SizedBox(height: 2.w),
                                                      controller.startTripListData[index].driveMoble == ""
                                                          ? SizedBox()
                                                          : InkWell(
                                                              onTap: () {
                                                                FocusScopeNode currentFocus = FocusScope.of(context);
                                                                if (!currentFocus.hasPrimaryFocus) {
                                                                  currentFocus.unfocus();
                                                                }
                                                                launchUrlString('tel:+91 ${controller.startTripListData[index].driveMoble ?? ""}');
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
                              ),

                            /*for (int index = 0; index < controller.startTripListData.length; index++)
                              StartTableView(
                                context: context,
                                date: DateFormat("dd MMM yyyy").format(DateTime.parse(controller.startTripListData[index].fromDate ?? "")),
                                busNo: controller.startTripListData[index].busNumber ?? "",
                                busStatusdata: controller.startTripListData[index].busStatusData,
                                driverDetalis: controller.startTripListData[index].driveName ?? "",
                                driverMobile: controller.startTripListData[index].driveMoble ?? "",
                                endStatus: true,
                                controller: controller,
                                borderRadius: (controller.startTripListData.length == index + 1)
                                    ? BorderRadius.only(
                                        bottomLeft: Radius.circular(2.78.w),
                                        bottomRight: Radius.circular(2.78.w),
                                      )
                                    : BorderRadius.only(
                                        bottomLeft: Radius.circular(0.w),
                                        bottomRight: Radius.circular(0.w),
                                      ),
                              ),*/
                          ],
                        ),
                      ),
                    )

                  /*Container(
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
                            for (int index = 0; index < siteMHomeScreenController.startTripListData.length; index++)
                              StartTableView(
                                context: context,
                                date: DateFormat("dd MMM yyyy").format(DateTime.parse(siteMHomeScreenController.startTripListData[index].fromDate ?? "")),
                                busNo: siteMHomeScreenController.startTripListData[index].busNumber ?? "",
                                busStatusdata: siteMHomeScreenController.startTripListData[index].busStatusData,
                                driverDetalis: siteMHomeScreenController.startTripListData[index].driveName ?? "",
                                driverMobile: siteMHomeScreenController.startTripListData[index].driveMoble ?? "",
                                startStatus: true,
                                controller: siteMHomeScreenController,
                                dataIndex: index,
                                borderRadius: (siteMHomeScreenController.startTripListData.length == index + 1)
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
                    )*/
                  : Align(
                      alignment: Alignment.center,
                      child: Center(
                        child: noDataWidget(title: "No Data"),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
