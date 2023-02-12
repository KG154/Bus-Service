import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shuttleservice/controller/home/trips_tab_controller.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/utils/assets.dart';
import 'package:shuttleservice/view/utils/color.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/tableview.dart';
import 'package:shuttleservice/view/widget/textfields.dart';
import 'package:shuttleservice/view/widget/widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripsTabController>(
      init: TripsTabController(),
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
                  controller.filterListData.clear();
                  // controller.busses = 0;
                  controller.update();
                  for (int i = 0; i < controller.TripListData.length; i++) {
                    if (controller.TripListData[i].fromDate!.toLowerCase().contains(val) || controller.TripListData[i].busNumber!.toLowerCase().contains(val) || controller.TripListData[i].driveName!.toLowerCase().contains(val) || controller.TripListData[i].busStatusData!.first.fromSiteName!.toLowerCase().contains(val) || controller.TripListData[i].busStatusData!.first.fromUserName!.toLowerCase().contains(val) || controller.TripListData[i].busStatusData!.first.toSiteName!.toLowerCase().contains(val) || controller.TripListData[i].busStatusData!.first.toUserName!.toLowerCase().contains(val)) {
                      controller.busses = controller.busses + 1;
                      controller.filterListData.add(controller.TripListData[i]);
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
                controller.filterListData.length != 0 && controller.searchC.text.isNotEmpty
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
                              for (int index = 0; index < controller.filterListData.length; index++)
                                StartTableView(
                                  context: context,
                                  triStatus: true,
                                  date: DateFormat("dd MMM yyyy").format(DateTime.parse(controller.filterListData[index].fromDate ?? "")),
                                  busNo: controller.filterListData[index].busNumber ?? "",
                                  busStatusdata: controller.filterListData[index].busStatusData,
                                  driverDetalis: controller.filterListData[index].driveName ?? "",
                                  driverMobile: controller.filterListData[index].driveMoble ?? "",
                                  dataIndex: index,
                                  borderRadius: (controller.filterListData.length == index + 1) ? BorderRadius.only(bottomLeft: Radius.circular(2.78.w), bottomRight: Radius.circular(2.78.w)) : BorderRadius.only(bottomLeft: Radius.circular(0.w), bottomRight: Radius.circular(0.w)),
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
