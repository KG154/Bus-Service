import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:shuttleservice/controller/auth/login_screen_controller.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/screen/auth/forgot_password_screen.dart';
import 'package:shuttleservice/view/screen/home/site_managers_screen/site_manager_home_screen.dart';
import 'package:shuttleservice/view/screen/main_screen.dart';
import 'package:shuttleservice/view/utils/assets.dart';
import 'package:shuttleservice/view/utils/color.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/button.dart';
import 'package:shuttleservice/view/widget/textfields.dart';
import 'package:shuttleservice/view/widget/toasts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginScreenController>(
      init: LoginScreenController(),
      builder: (loginController) {
        return KeyboardDismisser(
          gestures: [GestureType.onTap, GestureType.onPanUpdateAnyDirection],
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 0.5.h),
                child: Form(
                  autovalidateMode: loginController.submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                  key: loginController.formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 50.w),
                      Text(
                        Str.shuttleService,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Clr.lgTitleClr, fontSize: 28.sp, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 1.5.w),
                      Text(
                        Str.existingAccount,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Clr.lgTextClr, fontSize: 12.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 9.w),
                      MyTextField(
                        padding: EdgeInsets.zero,
                        maxLength: 10,
                        controller: loginController.phoneNoC,
                        keyboardType: TextInputType.phone,
                        inputFormat: Validate.numberFormat,
                        validate: Validate.numVal,
                        onChanged: (_) {
                          loginController.update();
                        },
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 3.81.w, top: 2.79, bottom: 2.79, right: 3.81.w),
                          child: SvgPicture.asset(AstSVG.phone_ic1),
                        ),
                        hintText: Str.ePhoneNumber,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return Validate.mobileNoEmpty;
                          } else if (!RegExp(r'^(?:[+0]9)?[0-9]{10,10}$').hasMatch(v)) {
                            return Validate.mobileNoValid;
                          }
                          return null;
                        },
                      ),
                      /*MyTextField(
                        padding: EdgeInsets.zero,
                        controller: loginController.emailC,
                        keyboardType: TextInputType.emailAddress,
                        inputFormat: Validate.emailFormat,
                        validate: Validate.emailVal,
                        onChanged: (_) {
                          loginController.update();
                        },
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 3.81.w, top: 2.79, bottom: 2.79, right: 3.81.w),
                          child: SvgPicture.asset(AstSVG.email_ic),
                        ),
                        hintText: Str.eEmail,
                        validator: (v) {
                          bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(v!);
                          if (v.isEmpty) {
                            return Validate.emailEmptyValidator;
                          } else if (!emailValid) {
                            return Validate.emailValidValidator;
                          }
                          return null;
                        },
                      ),*/
                      SizedBox(height: 3.5.w),
                      MyTextField(
                        padding: EdgeInsets.zero,
                        controller: loginController.passwordC,
                        keyboardType: TextInputType.visiblePassword,
                        validate: Validate.passVal,
                        inputFormat: Validate.passFormat,
                        onChanged: (_) {
                          loginController.update();
                        },
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 3.81.w, top: 2.79, bottom: 2.79, right: 3.81.w),
                          child: SvgPicture.asset(AstSVG.password_ic),
                        ),
                        obscureText: loginController.showPassword,
                        textInputAction: TextInputAction.done,
                        hintText: Str.ePassword,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            loginController.showPassClick();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(3.8.w),
                            child: loginController.showPassword ? SvgPicture.asset(AstSVG.eye_slash_ic) : SvgPicture.asset(AstSVG.eye_ic),
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => ForgotPasswordScreen());
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 2.8.w, right: 2.w),
                            child: Text(
                              "${Str.forgotPwd} ?",
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11.sp, color: Clr.lgTextClr),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 14.w),
                      MyButton(
                        width: 55.98.w,
                        title: Str.login,
                        onClick: () async {
                          loginController.submitted = true;
                          if (loginController.formKey.currentState!.validate()) {
                            print("Login");
                            await loginController.userLogin();
                          }
                          loginController.update();
                        },
                      ),
                      SizedBox(height: 2.w),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
