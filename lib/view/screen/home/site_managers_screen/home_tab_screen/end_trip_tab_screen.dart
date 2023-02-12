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
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/button.dart';
import 'package:shuttleservice/view/widget/buttons.dart';
import 'package:shuttleservice/view/widget/tableview.dart';
import 'package:shuttleservice/view/widget/textfields.dart';
import 'package:shuttleservice/view/widget/widgets.dart';
import 'package:url_launcher/url_launcher_string.dart';

class EndTripTabScreen extends StatelessWidget {
  const EndTripTabScreen({Key? key}) : super(key: key);

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
          body: SmartRefresher(
            controller: controller.tripECController,
            onRefresh: () {
              controller.busNumFilterC.clear();
              controller.startSiteFilterC.clear();
              controller.endSiteFilterC.clear();
              if (controller.startDate != null && controller.endDate != null) {
                String startDate = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                String endDate = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.endDate.toString()))}";
                controller.startTripList(status: "", loader: 0, startDate: startDate, endDate: endDate);
                controller.endTripList(loader: 0, startDate: startDate, endDate: endDate);
              } else {
                String startDate = "${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.startDate.toString()))}";
                controller.startTripList(status: "", loader: 0, startDate: startDate);
                controller.endTripList(loader: 0, startDate: startDate);
              }

              // String startDate = "${DateFormat('yyyy-MM-dd').format(DateFormat("dd MMM yyyy").parse("${controller.dateC.text}"))}";
              // controller.startTripList(status: "", loader: 0, startDate: startDate);
              // controller.endTripList(loader: 0, startDate: startDate);
              // controller.startTripList(status: "end_site", loader: 0, startDate: startDate);
              Future.delayed(Duration(milliseconds: 200), () {
                controller.tripECController.refreshCompleted();
              });
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 1.3.w),
              child: controller.endTripListData.length != 0
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
                            for (int index = 0; index < controller.endTripListData.length; index++)
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
                                                    id: controller.endTripListData[index].id,
                                                    busNo: controller.endTripListData[index].busNumber,
                                                    fromSideid: controller.endTripListData[index].fromSideid.toString(),
                                                    toSideid: controller.endTripListData[index].toSideid.toString(),
                                                    fromSideName: controller.endTripListData[index].fromSiteName,
                                                    toSideName: controller.endTripListData[index].toSiteName,
                                                    driveName: controller.endTripListData[index].driveName,
                                                    driveMoblie: controller.endTripListData[index].driveMoble,
                                                    fromCount: controller.endTripListData[index].toCount == "" ? "${controller.endTripListData[index].fromCount ?? 0}" : "${controller.endTripListData[index].toCount ?? 0}",
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
                                                                    await controller.deleteTrip(id: controller.endTripListData[index].id).then((value) async {
                                                                      if (value == true) {
                                                                        controller.endTripListData.remove(controller.endTripListData[index]);
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
                                    borderRadius: controller.endTripListData.length == index + 1
                                        ? BorderRadius.only(
                                            bottomLeft: Radius.circular(2.78.w),
                                            bottomRight: Radius.circular(2.78.w),
                                          )
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
                                                    controller.endTripListData[index].fromDate ?? "",
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
                                                    controller.endTripListData[index].busNumber ?? "",
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
                                                                          startSite: controller.endTripListData[index].fromSiteName ?? "",
                                                                          startUName: controller.endTripListData[index].fromUserName ?? "",
                                                                          // startTime: busStatusdata?[i].fromTime ?? "",
                                                                          startTime: "${DateFormat('hh:mm a').format(DateFormat("hh:mm:ss a").parse("${controller.endTripListData[index].fromTime ?? ""}"))}",
                                                                          userEmail: controller.endTripListData[index].fromEmailId ?? "",
                                                                          userMobile: controller.endTripListData[index].fromUserPhone ?? "",
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
                                                                            startSite: controller.endTripListData[index].toSiteName ?? "",
                                                                            startUName: controller.endTripListData[index].toUserName ?? "",
                                                                            // startTime: controller.endTripListData[index].toTime ?? "",
                                                                            startTime: controller.endTripListData[index].toTime != "" ? "${DateFormat('hh:mm a').format(DateFormat("hh:mm:ss a").parse("${controller.endTripListData[index].toTime ?? ""}"))}" : "",
                                                                            userEmail: controller.endTripListData[index].toEmailId ?? "",
                                                                            userMobile: controller.endTripListData[index].toUserPhone ?? "",
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                if (controller.endTripListData[index].toTime != "")
                                                                  Expanded(
                                                                    child: Padding(
                                                                      padding: EdgeInsets.only(top: 0.5.w, bottom: 0.5.w),
                                                                      child: Text(
                                                                        "Duration : ${durationString(controller.endTripListData[index].fromTime, controller.endTripListData[index].toTime)}",
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
                                                          color: controller.endTripListData[index].toCount == "" || controller.endTripListData[index].toCount == null ? Color(0xFFFFC7C7) : null,
                                                          border: Border(
                                                              // bottom: (busStatusdata?.length != i + 1) ? BorderSide(color: Clr.borderClr, width: 0.3.w) : BorderSide(color: Clr.borderClr, width: 0.0.w),
                                                              // bottom: BorderSide(color: Clr.borderClr, width: 0.3.w),
                                                              ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: 1.67.w,bottom: 1.w),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text(
                                                                controller.endTripListData[index].toCount == null || controller.endTripListData[index].toCount == "" ? "${controller.endTripListData[index].fromCount ?? 0}" : "${controller.endTripListData[index].toCount ?? 0}",
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(fontSize: 8.sp, color: Clr.tabTextClr, fontWeight: FontWeight.w600),
                                                              ),
                                                              // controller.userModel?.userId != controller.endTripListData[index].fromUserid ?
                                                              controller.endTripListData[index].toCount == null || controller.endTripListData[index].toCount == ""
                                                                  ? Padding(
                                                                      padding: EdgeInsets.all(3),
                                                                      child: InkWell(
                                                                        onTap: () {
                                                                          controller.noOFPassC.text = controller.endTripListData[index].fromCount.toString();
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
                                                                                            autovalidateMode: controller.submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                                                                                            key: controller.formKey,
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
                                                                                                  controller: controller.noOFPassC,
                                                                                                  keyboardType: TextInputType.phone,
                                                                                                  inputFormat: Validate.numberFormat,
                                                                                                  validate: Validate.numVal,
                                                                                                  onChanged: (_) {
                                                                                                    controller.update();
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
                                                                                                        controller.submitted = true;
                                                                                                        if (controller.formKey.currentState!.validate()) {
                                                                                                          print("End Trip");
                                                                                                          print(controller.noOFPassC.text.toString());
                                                                                                          print(controller.endTripListData[index].id.toString());
                                                                                                          await controller.endTrip(id: controller.endTripListData[index].id.toString(), noOFPassC: controller.noOFPassC.text.toString());
                                                                                                          controller.update();
                                                                                                        }
                                                                                                        controller.update();
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
                                                          controller.endTripListData[index].driveName == "" ? "-" : controller.endTripListData[index].driveName ?? "",
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(fontSize: 8.5.sp, color: Clr.bottomTextClr, fontWeight: FontWeight.w500),
                                                        ),
                                                      ),
                                                      SizedBox(height: 2.w),
                                                      controller.endTripListData[index].driveMoble == ""
                                                          ? SizedBox()
                                                          : InkWell(
                                                              onTap: () {
                                                                FocusScopeNode currentFocus = FocusScope.of(context);
                                                                if (!currentFocus.hasPrimaryFocus) {
                                                                  currentFocus.unfocus();
                                                                }
                                                                launchUrlString('tel:+91 ${controller.endTripListData[index].driveMoble ?? ""}');
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

                            /*for (int index = 0; index < controller.endTripListData.length; index++)
                              StartTableView(
                                context: context,
                                date: DateFormat("dd MMM yyyy").format(DateTime.parse(controller.endTripListData[index].fromDate ?? "")),
                                busNo: controller.endTripListData[index].busNumber ?? "",
                                busStatusdata: controller.endTripListData[index].busStatusData,
                                driverDetalis: controller.endTripListData[index].driveName ?? "",
                                driverMobile: controller.endTripListData[index].driveMoble ?? "",
                                endStatus: true,
                                controller: controller,
                                borderRadius: (controller.endTripListData.length == index + 1)
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

/*TableView(
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
                          endStatus: true,
                          controller: controller,
                        ),*/
