import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shuttleservice/controller/home/site_managers_controller/create_tripe_controller.dart';
import 'package:shuttleservice/controller/home/site_managers_controller/site_manager_home_screen_controller.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/screen/home/site_managers_screen/home_tab_screen/create_trip_screen.dart';
import 'package:shuttleservice/view/utils/assets.dart';
import 'package:shuttleservice/view/utils/color.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/buttons.dart';
import 'package:shuttleservice/view/widget/textfields.dart';
import 'package:shuttleservice/view/widget/widgets.dart';
import 'package:url_launcher/url_launcher_string.dart';

class StartTripSearchScreen extends StatefulWidget {
  const StartTripSearchScreen({Key? key}) : super(key: key);

  @override
  State<StartTripSearchScreen> createState() => _StartTripSearchScreenState();
}

CreateTripeController createTripeController = Get.put(CreateTripeController());

class _StartTripSearchScreenState extends State<StartTripSearchScreen> {
  String? durationString(fromTime, toTime) {
    Duration duration = DateFormat("hh:mm:ss a").parse(toTime!).difference(DateFormat("hh:mm:ss a").parse(fromTime!));
    printDuration(duration);
    return prettyDuration(duration).replaceAll("hours", "hr").replaceAll("minutes", "min").replaceAll("seconds", "sec");
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SiteMHomeScreenController>(
      init: SiteMHomeScreenController(),
      builder: (controller) => WillPopScope(
        onWillPop: () {
          controller.searchC.clear();
          controller.update();
          Get.back();
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 17.81.w,
            automaticallyImplyLeading: false,
            title: SizedBox(
              height: 14.w,
              child: MyTextField(
                suffixIcon: Container(
                  padding: EdgeInsets.all(3.w),
                  child: SvgPicture.asset(AstSVG.search_ic, color: Clr.textFieldHintClr),
                ),
                hintSize: 11.5.sp,
                fontSize: 11.5.sp,
                borderRadius: 3.w,
                cursorHeight: 18,
                isCollapsed: false,
                autoFocus: true,
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
                  controller.startFilterListData.clear();
                  // controller.busses = 0;
                  controller.update();
                  for (int i = 0; i < controller.startTripListData.length; i++) {
                    if (controller.startTripListData[i].fromDate!.toLowerCase().contains(val) || controller.startTripListData[i].busNumber!.toLowerCase().contains(val) || controller.startTripListData[i].driveName!.toLowerCase().contains(val) || controller.startTripListData[i].fromSiteName!.toLowerCase().contains(val) || controller.startTripListData[i].fromUserName!.toLowerCase().contains(val) || controller.startTripListData[i].toSiteName!.toLowerCase().contains(val) || controller.startTripListData[i].toUserName!.toLowerCase().contains(val)) {
                      // controller.busses = controller.busses + 1;
                      controller.startFilterListData.add(controller.startTripListData[i]);
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
            ),
            leading: Padding(
              padding: EdgeInsets.only(left: 3),
              child: GestureDetector(
                onTap: () {
                  controller.searchC.clear();
                  Get.back();
                },
                child: Icon(Icons.arrow_back, color: Clr.textFieldTextClr),
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 0.5.h),
            child: Column(
              children: [
                SizedBox(height: 10.w),
                controller.startFilterListData.length != 0 && controller.searchC.text.isNotEmpty
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
                              for (int index = 0; index < controller.startFilterListData.length; index++)
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
                                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                                  if (!currentFocus.hasPrimaryFocus) {
                                                    currentFocus.unfocus();
                                                  }
                                                  Get.to(
                                                    () => CreateTripScreen(
                                                      screen: "EditScreen",
                                                      id: controller.startFilterListData[index].id,
                                                      busNo: controller.startFilterListData[index].busNumber,
                                                      fromSideid: controller.startFilterListData[index].fromSideid.toString(),
                                                      toSideid: controller.startFilterListData[index].toSideid.toString(),
                                                      fromSideName: controller.startFilterListData[index].fromSiteName,
                                                      toSideName: controller.startFilterListData[index].toSiteName,
                                                      driveName: controller.startFilterListData[index].driveName,
                                                      driveMoblie: controller.startFilterListData[index].driveMoble,
                                                      fromCount: controller.startFilterListData[index].toCount == "" ? "${controller.startFilterListData[index].fromCount ?? 0}" : "${controller.startFilterListData[index].toCount ?? 0}",
                                                    ),
                                                  )?.then((value) {
                                                    if (createTripeController.successModel?.status == true) {
                                                      FocusScopeNode currentFocus = FocusScope.of(context);
                                                      if (!currentFocus.hasPrimaryFocus) {
                                                        currentFocus.unfocus();
                                                      }
                                                      controller.searchC.clear();
                                                      Get.back();
                                                      controller.update();
                                                    }
                                                  });
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
                                                                      await controller.deleteTrip(id: controller.startFilterListData[index].id).then((value) async {
                                                                        if (value == true) {
                                                                          controller.startFilterListData.remove(controller.startFilterListData[index]);
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
                                      borderRadius: controller.startFilterListData.length == index + 1
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
                                                      controller.startFilterListData[index].fromDate ?? "",
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
                                                      controller.startFilterListData[index].busNumber ?? "",
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
                                                                            startSite: controller.startFilterListData[index].fromSiteName ?? "",
                                                                            startUName: controller.startFilterListData[index].fromUserName ?? "",
                                                                            // startTime: busStatusdata?[i].fromTime ?? "",
                                                                            startTime: "${DateFormat('hh:mm a').format(DateFormat("hh:mm:ss a").parse("${controller.startFilterListData[index].fromTime ?? ""}"))}",
                                                                            userEmail: controller.startFilterListData[index].fromEmailId ?? "",
                                                                            userMobile: controller.startFilterListData[index].fromUserPhone ?? "",
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
                                                                              startSite: controller.startFilterListData[index].toSiteName ?? "",
                                                                              startUName: controller.startFilterListData[index].toUserName ?? "",
                                                                              // startTime: controller.startFilterListData[index].toTime ?? "",
                                                                              startTime: controller.startFilterListData[index].toTime != "" ? "${DateFormat('hh:mm a').format(DateFormat("hh:mm:ss a").parse("${controller.startFilterListData[index].toTime ?? ""}"))}" : "",
                                                                              userEmail: controller.startFilterListData[index].toEmailId ?? "",
                                                                              userMobile: controller.startFilterListData[index].toUserPhone ?? "",
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  if (controller.startFilterListData[index].toTime != "")
                                                                    Expanded(
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(top: 0.5.w, bottom: 0.5.w),
                                                                        child: Text(
                                                                          "Duration : ${durationString(controller.startFilterListData[index].fromTime, controller.startFilterListData[index].toTime)}",
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
                                                              controller.startFilterListData[index].toCount == null || controller.startFilterListData[index].toCount == "" ? "${controller.startFilterListData[index].fromCount ?? 0}" : "${controller.startFilterListData[index].toCount ?? 0}",
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
                                                            controller.startFilterListData[index].driveName == "" ? "-" : controller.startFilterListData[index].driveName ?? "",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(fontSize: 8.5.sp, color: Clr.bottomTextClr, fontWeight: FontWeight.w500),
                                                          ),
                                                        ),
                                                        SizedBox(height: 2.w),
                                                        controller.startFilterListData[index].driveMoble == ""
                                                            ? SizedBox()
                                                            : InkWell(
                                                                onTap: () {
                                                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                                                  if (!currentFocus.hasPrimaryFocus) {
                                                                    currentFocus.unfocus();
                                                                  }
                                                                  launchUrlString('tel:+91 ${controller.startFilterListData[index].driveMoble ?? ""}');
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
                            ],
                          ),
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1, maxHeight: MediaQuery.of(context).size.height * 0.75),
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
  }
}
