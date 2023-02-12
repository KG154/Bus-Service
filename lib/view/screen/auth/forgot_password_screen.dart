import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:shuttleservice/controller/auth/forgot_pass_controller.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/screen/auth/verification_screen.dart';
import 'package:shuttleservice/view/utils/assets.dart';
import 'package:shuttleservice/view/utils/color.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/button.dart';
import 'package:shuttleservice/view/widget/textfields.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPassScreenController>(
      init: ForgotPassScreenController(),
      builder: (logicController) {
        return KeyboardDismisser(
          gestures: [GestureType.onTap, GestureType.onPanUpdateAnyDirection],
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 15.w,
              titleSpacing: 0,
              centerTitle: true,
              title: Text(Str.forgotPwd, style: appTitleStyle),
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
                autovalidateMode: logicController.submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                key: logicController.formKey,
                child: Column(
                  children: [
                    SizedBox(height: 29.w),
                    Text(
                      "Enter the email address \nassociated with your account.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Clr.textFieldTextClr,
                      ),
                    ),
                    SizedBox(height: 2.w),
                    Text(
                      "we will email a code to reset your Password.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.w500, color: Clr.textFieldHintClr),
                    ),
                    SizedBox(height: 13.w),
                    MyTextField(
                      controller: logicController.emailC,
                      keyboardType: TextInputType.emailAddress,
                      inputFormat: Validate.emailFormat,
                      validate: Validate.emailVal,
                      textInputAction: TextInputAction.done,
                      onChanged: (_) {
                        logicController.update();
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
                    ),
                    SizedBox(height: 12.w),
                    MyButton(
                      width: 55.98.w,
                      title: Str.send,
                      onClick: () async {
                        logicController.submitted = true;
                        if (logicController.formKey.currentState!.validate()) {
                          print("Forgot Password");
                          await logicController.forgotPassword();
                          // Get.to(() => Verification_screen(email: logicController.emailC.text));
                        }
                        logicController.update();
                      },
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
