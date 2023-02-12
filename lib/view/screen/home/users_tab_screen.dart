import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:shuttleservice/controller/home/users_tab_controller.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/screen/home/add_user_screen.dart';
import 'package:shuttleservice/view/screen/home/user_tab_screen/subadmin_tab_screen.dart';
import 'package:shuttleservice/view/utils/assets.dart';
import 'package:shuttleservice/view/utils/color.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/textfields.dart';
import 'user_tab_screen/sitemanager_tab_screen.dart';

class UsersTabScreen extends StatefulWidget {
  const UsersTabScreen({Key? key}) : super(key: key);

  @override
  State<UsersTabScreen> createState() => _UsersTabScreenState();
}

class _UsersTabScreenState extends State<UsersTabScreen> {
  // UsersTabController usersTabController = Get.put(UsersTabController());
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   usersTabController.getUsersList(type: "sub_admin");
  //   usersTabController.getUsersList(type: "site_manager");
  //   usersTabController.sitesTabController.getSiteList(status: "active", loader: 0);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsersTabController>(
      init: UsersTabController(),
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: KeyboardDismisser(
            gestures: [GestureType.onTap, GestureType.onPanUpdateAnyDirection],
            child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 17.81.w,
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Text(
                  "USERS",
                  style: TextStyle(fontSize: 18.sp),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      print("Tap");
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      Get.to(() => AddUserScreen(screenName: "AddUser"));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 4.w),
                      child: SvgPicture.asset(AstSVG.add_ic, width: 10.w, height: 10.w),
                    ),
                  ),
                ],
              ),
              body: DefaultTabController(
                length: 2,
                initialIndex: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 0.5.h),
                      child: SizedBox(
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
                          controller: controller.searchC,
                          fillColor: Clr.whiteClr,
                          textInputAction: TextInputAction.done,
                          hintText: Str.searchStr,
                          validate: Validate.nameVal,
                          keyboardType: TextInputType.name,
                          inputFormat: Validate.nameFormat,
                          onChanged: (val) {
                            controller.update();
                          },
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          border: borderInput,
                          focusBorder: focusBorderInput,
                          inputTextStyle: TextStyle(fontWeight: FontWeight.w600, color: Clr.tabTextClr, height: 1.2, fontSize: 11.sp),
                          hintTextStyle: TextStyle(color: Clr.textFieldHintClr2, fontWeight: FontWeight.w400, height: 1.2, fontSize: 11.sp),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.81.w),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.071.w),
                      child: Container(
                        height: 8.w,
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.4.w, color: Clr.borderClr)),
                        ),
                        child: TabBar(
                          indicatorColor: Clr.primaryClr,
                          isScrollable: false,
                          labelColor: Clr.primaryClr,
                          labelStyle: TextStyle(color: Clr.primaryClr, fontWeight: FontWeight.w600, fontSize: 13.sp),
                          unselectedLabelColor: Clr.textFieldHintClr,
                          unselectedLabelStyle: TextStyle(color: Clr.textFieldHintClr, fontWeight: FontWeight.w400, fontSize: 13.sp),
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorWeight: 0.51.w,
                          tabs: [
                            Tab(text: Str.subAdmin1),
                            Tab(text: "Site Managers"),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          SubAdminTabScreen(),
                          SiteManagerTabScreen(),
                        ],
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
