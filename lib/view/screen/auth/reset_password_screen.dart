import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:shuttleservice/controller/auth/reset_pass_controller.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/screen/auth/login_screen.dart';
import 'package:shuttleservice/view/utils/assets.dart';
import 'package:shuttleservice/view/utils/color.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/button.dart';
import 'package:shuttleservice/view/widget/textfields.dart';

class ResetPasswordScreen extends StatelessWidget {
  String? email;

  ResetPasswordScreen({Key? key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetPassScreenController>(
      init: ResetPassScreenController(),
      builder: (resetPassController) {
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
                autovalidateMode: resetPassController.submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                key: resetPassController.formKey,
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
                      controller: resetPassController.passwordC,
                      keyboardType: TextInputType.visiblePassword,
                      validate: Validate.passVal,
                      inputFormat: Validate.passFormat,
                      onChanged: (_) {
                        // loginController.update();
                      },
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 3.81.w, top: 2.79, bottom: 2.79, right: 3.81.w),
                        child: SvgPicture.asset(AstSVG.password_ic),
                      ),
                      obscureText: resetPassController.showPassword,
                      textInputAction: TextInputAction.done,
                      hintText: Str.ePassword,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          resetPassController.showPassClick();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(3.8.w),
                          child: resetPassController.showPassword ? SvgPicture.asset(AstSVG.eye_slash_ic) : SvgPicture.asset(AstSVG.eye_ic),
                        ),
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return Validate.passwordEmptyValidator;
                        } else if (v.length < 6) {
                          return Validate.passwordValidValidator;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 2.w),
                    MyTextField(
                      controller: resetPassController.cPasswordC,
                      keyboardType: TextInputType.visiblePassword,
                      validate: Validate.passVal,
                      inputFormat: Validate.passFormat,
                      onChanged: (_) {
                        resetPassController.update();
                      },
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 3.81.w, top: 2.79, bottom: 2.79, right: 3.81.w),
                        child: SvgPicture.asset(AstSVG.password_ic),
                      ),
                      obscureText: resetPassController.showCPassword,
                      textInputAction: TextInputAction.done,
                      hintText: Str.cPassword,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          resetPassController.showCPassClick();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(3.8.w),
                          child: resetPassController.showCPassword ? SvgPicture.asset(AstSVG.eye_slash_ic) : SvgPicture.asset(AstSVG.eye_ic),
                        ),
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return Validate.confirmPasswordEmptyValidator;
                        } else if (v != resetPassController.passwordC.text) {
                          return Validate.passwordMatchValidator;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30.w),
                    Center(
                      child: MyButton(
                        width: 55.98.w,
                        title: Str.resetPassword,
                        onClick: () async {
                          resetPassController.submitted = true;
                          if (resetPassController.formKey.currentState!.validate()) {
                            print("Reset Password");
                            await resetPassController.resetPassword(email);
                          }
                          resetPassController.update();
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
