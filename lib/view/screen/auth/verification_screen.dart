import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shuttleservice/controller/auth/forgot_pass_controller.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/utils/color.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/button.dart';
import 'package:shuttleservice/view/widget/toasts.dart';

class Verification_screen extends StatelessWidget {
  String email;

  Verification_screen({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPassScreenController>(
      init: ForgotPassScreenController(),
      initState: (logicController) {
        logicController.controller?.pin = null;
      },
      dispose: (logicController) {
        logicController.controller?.otpSingUpC.clear();
      },
      builder: (logicController) {
        return KeyboardDismisser(
          gestures: [GestureType.onTap, GestureType.onPanUpdateAnyDirection],
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 15.w,
              titleSpacing: 0,
              centerTitle: true,
              title: Text(Str.verification, style: appTitleStyle),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 30.w),
                  Text(
                    "Check Your mail",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Clr.textFieldTextClr,
                    ),
                  ),
                  SizedBox(height: 2.w),
                  Text(
                    "we have sent a password recover code \nto your email.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Clr.textFieldHintClr,
                    ),
                  ),
                  SizedBox(height: 4.5.w),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 4,
                      autoDisposeControllers: false,
                      obscureText: false,
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.underline,
                        fieldHeight: 60,
                        fieldWidth: 55,
                        activeFillColor: Colors.white,
                        activeColor: Clr.primaryClr,
                        errorBorderColor: Colors.red,
                        selectedColor: Clr.textFieldHintClr,
                        inactiveColor: Clr.textFieldHintClr,
                        selectedFillColor: Clr.primaryClr,
                      ),
                      cursorHeight: 40,
                      cursorColor: Clr.primaryClr,
                      // showCursor: false,
                      textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 40.sp, color: Clr.primaryClr),
                      animationDuration: Duration(milliseconds: 300),
                      controller: logicController.otpSingUpC,
                      keyboardType: TextInputType.number,
                      onCompleted: (v) {
                        logicController.pin = v;
                        logicController.update();
                      },
                      beforeTextPaste: (text) {
                        debugPrint("Allowing to paste $text");
                        return true;
                      },
                      onChanged: (String value) {
                        // logicController.update();
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Str.otpNotReceive,
                        style: TextStyle(color: Clr.textFieldHintClr, fontSize: 12.5.sp, fontWeight: FontWeight.normal),
                      ),
                      TextButton(
                          onPressed: () async {
                            await logicController.forgotPassword();
                            logicController.update();
                          },
                          child: Text(
                            Str.resend,
                            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400, color: Clr.textFieldTextClr, decoration: TextDecoration.underline, decorationThickness: 3),
                          ))
                    ],
                  ),
                  SizedBox(height: 8.w),
                  MyButton(
                    width: 55.98.w,
                    title: Str.send,
                    onClick: () async {
                      if (logicController.otpSingUpC.text.length == 4) {
                        await logicController.verification();
                      } else {
                        MyToasts().errorToast(toast: "Please Enter Verification Code");
                        print("Not valid");
                      }
                      logicController.update();
                    },
                  ),
                  SizedBox(height: 2.w),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
