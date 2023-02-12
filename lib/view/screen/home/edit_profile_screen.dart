import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:shuttleservice/view/screen/home/change_password_screen.dart';
import 'package:shuttleservice/controller/home/edit_profile_controller.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/utils/assets.dart';
import 'package:shuttleservice/view/utils/color.dart';
import 'package:shuttleservice/view/utils/const.dart';
import 'package:shuttleservice/view/utils/strings.dart';
import 'package:shuttleservice/view/widget/button.dart';
import 'package:shuttleservice/view/widget/textfields.dart';
import 'package:shuttleservice/view/widget/widgets.dart';

class EditProfileScreen extends StatelessWidget {
  String? type;

  EditProfileScreen({Key? key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      init: EditProfileController(),
      builder: (controller) {
        return KeyboardDismisser(
          gestures: [GestureType.onTap, GestureType.onPanUpdateAnyDirection],
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 15.w,
              titleSpacing: 0,
              centerTitle: true,
              title: Text(
                Str.editProfile,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp, color: Clr.textFieldTextClr),
              ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    userSText(text: Str.userName),
                    MyTextField(
                      padding: EdgeInsets.zero,
                      fillColor: Clr.textFieldBgClr,
                      controller: controller.nameC,
                      keyboardType: TextInputType.text,
                      inputFormat: Validate.nameFormat,
                      validate: Validate.nameVal,
                      onChanged: (_) {
                        controller.update();
                      },
                      hintText: Str.eName,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return Validate.nameEmptyValidator;
                        }
                        return null;
                      },
                      border: borderInput,
                      focusBorder: focusBorderInput,
                      errorBorder: errorBoarderInput,
                      inputTextStyle: inputTextStyle,
                      hintTextStyle: hintTextStyle,
                    ),
                    userSText(text: Str.phoneNumber),
                    MyTextField(
                      padding: EdgeInsets.zero,
                      fillColor: Clr.textFieldBgClr,
                      maxLength: 10,
                      controller: controller.phoneNoC,
                      keyboardType: TextInputType.phone,
                      inputFormat: Validate.numberFormat,
                      validate: Validate.numVal,
                      onChanged: (_) {
                        controller.update();
                      },
                      // prefixIcon: Padding(
                      //   padding: EdgeInsets.only(left: 3.5.w, top: 3.2.w, bottom: 3.5.w),
                      //   child: Text(
                      //     "+91",
                      //     style: TextStyle(fontWeight: FontWeight.w600, color: Clr.tabTextClr, height: 1.2, fontSize: 13.sp),
                      //   ),
                      // ),
                      hintText: Str.ePhoneNumber,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return Validate.mobileNoEmpty;
                        } else if (!RegExp(r'^(?:[+0]9)?[0-9]{10,10}$').hasMatch(v)) {
                          return Validate.mobileNoValid;
                        }
                        return null;
                      },
                      border: borderInput,
                      focusBorder: focusBorderInput,
                      errorBorder: errorBoarderInput,
                      inputTextStyle: inputTextStyle,
                      hintTextStyle: hintTextStyle,
                    ),
                    userSText(text: Str.email),
                    MyTextField(
                      padding: EdgeInsets.zero,
                      fillColor: Clr.textFieldBgClr,
                      controller: controller.emailC,
                      keyboardType: TextInputType.emailAddress,
                      inputFormat: Validate.emailFormat,
                      validate: Validate.emailVal,
                      textInputAction: TextInputAction.done,
                      onChanged: (_) {
                        controller.update();
                      },
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
                      border: borderInput,
                      focusBorder: focusBorderInput,
                      errorBorder: errorBoarderInput,
                      inputTextStyle: inputTextStyle,
                      hintTextStyle: hintTextStyle,
                    ),
                    SizedBox(height: 2.w),
                    ListTile(
                      onTap: () {
                        Get.to(() => ChangePasswordScreen(type : type));
                      },
                      contentPadding: EdgeInsets.all(0),
                      minLeadingWidth: 20,
                      title: userSText(text: "Change Password"),
                      trailing: SvgPicture.asset(AstSVG.nextArrow_ic),
                    ),
                    SizedBox(height: 30.w),
                    Center(
                      child: MyButton(
                        width: 55.98.w,
                        title: Str.save,
                        onClick: () async {
                          controller.submitted = true;
                          if (controller.formKey.currentState!.validate()) {
                            print("Save");
                            print(controller.nameC.text.toString());
                            print(controller.emailC.text.toString());
                            print(controller.phoneNoC.text.toString());
                            await controller.editProfile();
                            controller.update();
                          }
                          controller.update();
                        },
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
