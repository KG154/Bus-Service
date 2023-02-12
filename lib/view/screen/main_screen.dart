import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shuttleservice/controller/main_screen_controller.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/utils/assets.dart';
import 'package:shuttleservice/view/utils/color.dart';
import 'package:shuttleservice/view/utils/strings.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainScreenController>(
      init: MainScreenController(context),
      /*initState: (mainScreenLogic) {
        mainScreenLogic.controller?.currentIndex = 0.obs;
        versionDialog(context);
        mainScreenLogic.controller?.update();
      },*/
      builder: (mainScreenLogic) {
        return Scaffold(
          body: PageView(
            children: [
              mainScreenLogic.page.elementAt(mainScreenLogic.currentIndex.value),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: 4.w, left: 3.w, right: 3.w, top: 2.w),
            child: Container(
              height: 13.61.w,
              decoration: BoxDecoration(
                color: Clr.whiteClr,
                borderRadius: BorderRadius.circular(6.67.w),
                boxShadow: [
                  BoxShadow(color: Clr.primaryClr.withOpacity(0.1), blurRadius: 3, spreadRadius: 1),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: 2.w),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        mainScreenLogic.currentIndex = 0.obs;
                        mainScreenLogic.update();
                      },
                      child: mainScreenLogic.currentIndex == 0
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  Str.dashboard,
                                  style: TextStyle(color: Clr.primaryClr, fontWeight: FontWeight.w600, fontSize: 10.sp),
                                ),
                                SizedBox(height: 0.7.h),
                                Container(
                                  height: 0.3.h,
                                  width: 1.5.h,
                                  color: Clr.primaryClr,
                                )
                              ],
                            )
                          : SvgPicture.asset(AstSVG.dashboard_ic),
                    ),
                  ),
                  if (mainScreenLogic.userModel?.isTrip == true)
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          mainScreenLogic.currentIndex = 1.obs;
                          mainScreenLogic.update();
                        },
                        child: mainScreenLogic.currentIndex == 1
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    Str.trips,
                                    style: TextStyle(color: Clr.primaryClr, fontWeight: FontWeight.w600, fontSize: 10.sp),
                                  ),
                                  SizedBox(height: 0.7.h),
                                  Container(
                                    height: 0.3.h,
                                    width: 1.5.h,
                                    color: Clr.primaryClr,
                                  )
                                ],
                              )
                            : SvgPicture.asset(AstSVG.trips_ic),
                      ),
                    ),
                  if (mainScreenLogic.userModel?.isBus == true)
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          mainScreenLogic.currentIndex = 2.obs;
                          mainScreenLogic.update();
                        },
                        child: mainScreenLogic.currentIndex == 2
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    Str.buses,
                                    style: TextStyle(color: Clr.primaryClr, fontWeight: FontWeight.w600, fontSize: 10.sp),
                                  ),
                                  SizedBox(height: 0.7.h),
                                  Container(
                                    height: 0.3.h,
                                    width: 1.5.h,
                                    color: Clr.primaryClr,
                                  )
                                ],
                              )
                            : SvgPicture.asset(AstSVG.buses_ic),
                      ),
                    ),
                  if (mainScreenLogic.userModel?.isSites == true)
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          mainScreenLogic.currentIndex = 3.obs;
                          mainScreenLogic.update();
                        },
                        child: mainScreenLogic.currentIndex == 3
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    Str.sites,
                                    style: TextStyle(color: Clr.primaryClr, fontWeight: FontWeight.w600, fontSize: 10.sp),
                                  ),
                                  SizedBox(height: 0.7.h),
                                  Container(
                                    height: 0.3.h,
                                    width: 1.5.h,
                                    color: Clr.primaryClr,
                                  )
                                ],
                              )
                            : SvgPicture.asset(AstSVG.sites_ic),
                      ),
                    ),
                  if (mainScreenLogic.userModel?.isUsers == true)
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          mainScreenLogic.currentIndex = 4.obs;
                          mainScreenLogic.update();
                        },
                        child: mainScreenLogic.currentIndex == 4
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    Str.users,
                                    style: TextStyle(color: Clr.primaryClr, fontWeight: FontWeight.w600, fontSize: 10.sp),
                                  ),
                                  SizedBox(height: 0.7.h),
                                  Container(
                                    height: 0.3.h,
                                    width: 1.5.h,
                                    color: Clr.primaryClr,
                                  )
                                ],
                              )
                            : SvgPicture.asset(AstSVG.user_ic),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
