import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/utils/assets.dart';
import 'package:shuttleservice/view/utils/color.dart';

class MyToasts {
  successToast({Color? color, String? toast}) {
    final Widget widget = Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xFFE8FFE1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SvgPicture.asset(AstSVG.Success_ic),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              toast ?? "Success",
              style: TextStyle(color: Clr.successClr, fontWeight: FontWeight.w700, fontSize: 10.sp),
            ),
          ),
        ],
      ),
    );

    final ToastFuture toastFuture = showToastWidget(
      widget,
      duration: const Duration(seconds: 3),
      position: ToastPosition.bottom,
      onDismiss: () {
        debugPrint('Toast has been dismissed.');
      },
    );
  }

  errorToast({Color? color, String? toast}) {
    final Widget widget = Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xFFFFE2E5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SvgPicture.asset(AstSVG.error_ic),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              toast ?? "Error",
              style: TextStyle(color: Clr.inactiveClr, fontWeight: FontWeight.w700, fontSize: 10.sp),
            ),
          ),
        ],
      ),
    );

    final ToastFuture toastFuture = showToastWidget(
      widget,
      duration: Duration(seconds: 3),
      position: ToastPosition.bottom,
      onDismiss: () {
        debugPrint('Toast has been dismissed.');
      },
    );
  }

  warningToast({Color? color, String? toast}) {
    final Widget widget = Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xFFFFF6D6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SvgPicture.asset(AstSVG.Warning_ic),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              toast ?? "Warning",
              style: TextStyle(color: Clr.warningClr, fontWeight: FontWeight.w700, fontSize: 10.sp),
            ),
          ),
        ],
      ),
    );

    final ToastFuture toastFuture = showToastWidget(
      widget,
      duration: Duration(seconds: 3),
      position: ToastPosition.bottom,
      onDismiss: () {
        debugPrint('Toast has been dismissed.');
      },
    );
  }
}
