import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/utils/assets.dart';
import 'package:shuttleservice/view/utils/color.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/button.dart';
import 'package:shuttleservice/view/widget/textfields.dart';

import '../../../controller/home/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  String? type;

  ChangePasswordScreen({Key? key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePassController>(
      init: ChangePassController(),
      builder: (controller) {
        return KeyboardDismisser(
          gestures: [GestureType.onTap, GestureType.onPanUpdateAnyDirection],
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 15.w,
              titleSpacing: 0,
              centerTitle: true,
              title: Text(Str.resetPassword, style: appTitleStyle),
              leading: Padding(
                padding: EdgeInsets.only(left: 3),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back_ios_new_rounded, color: Clr.textFieldTextClr),
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 0.5.h),
              child: Form(
                autovalidateMode: controller.submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 7.w),
                    Text(
                      "Your password must be more than six characters \nlong and include a combination of numbers,letters \nand special characters. (!\$@%#)",
                      style: TextStyle(fontSize: 11.5.sp, fontWeight: FontWeight.w400, color: Clr.textFieldHintClr),
                    ),
                    SizedBox(height: 6.63.w),
                    MyTextField(
                      controller: controller.cuPasswordC,
                      keyboardType: TextInputType.visiblePassword,
                      validate: Validate.passVal,
                      inputFormat: Validate.passFormat,
                      onChanged: (_) {
                        controller.update();
                      },
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 3.81.w, top: 2.79, bottom: 2.79, right: 3.81.w),
                        child: SvgPicture.asset(AstSVG.password_ic),
                      ),
                      obscureText: controller.showCuPassword,
                      textInputAction: TextInputAction.next,
                      hintText: Str.eCuPassword,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          controller.showCuPassClick();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(3.8.w),
                          child: controller.showCuPassword ? SvgPicture.asset(AstSVG.eye_slash_ic) : SvgPicture.asset(AstSVG.eye_ic),
                        ),
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return Validate.CuPassEmptyValidator;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 2.w),
                    MyTextField(
                      controller: controller.passwordC,
                      keyboardType: TextInputType.visiblePassword,
                      validate: Validate.passVal,
                      inputFormat: Validate.passFormat,
                      onChanged: (_) {
                        controller.update();
                      },
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 3.81.w, top: 2.79, bottom: 2.79, right: 3.81.w),
                        child: SvgPicture.asset(AstSVG.password_ic),
                      ),
                      obscureText: controller.showPassword,
                      textInputAction: TextInputAction.next,
                      hintText: Str.ePassword,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          controller.showPassClick();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(3.8.w),
                          child: controller.showPassword ? SvgPicture.asset(AstSVG.eye_slash_ic) : SvgPicture.asset(AstSVG.eye_ic),
                        ),
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return Validate.newPassEmptyValidator;
                        } else if (v.length < 6) {
                          return Validate.passwordValidValidator;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 2.w),
                    MyTextField(
                      controller: controller.cPasswordC,
                      keyboardType: TextInputType.visiblePassword,
                      validate: Validate.passVal,
                      inputFormat: Validate.passFormat,
                      onChanged: (_) {
                        controller.update();
                      },
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 3.81.w, top: 2.79, bottom: 2.79, right: 3.81.w),
                        child: SvgPicture.asset(AstSVG.password_ic),
                      ),
                      obscureText: controller.showCPassword,
                      textInputAction: TextInputAction.done,
                      hintText: Str.cPassword,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          controller.showCPassClick();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(3.8.w),
                          child: controller.showCPassword ? SvgPicture.asset(AstSVG.eye_slash_ic) : SvgPicture.asset(AstSVG.eye_ic),
                        ),
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return Validate.confirmPasswordEmptyValidator;
                        } else if (v != controller.passwordC.text) {
                          return Validate.passwordMatchValidator;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 40.w),
                    Center(
                      child: MyButton(
                        width: 40.98.w,
                        title: "Submit",
                        // title: Str.updatePassword,
                        onClick: () async {
                          controller.submitted = true;
                          if (controller.formKey.currentState!.validate()) {
                            print("Change Password");
                            await controller.changePassword(type : type);
                            controller.update();
                          }
                          controller.update();
                        },
                      ),
                    ),
                    SizedBox(height: 2.w),
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
