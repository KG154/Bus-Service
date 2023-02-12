import 'package:flutter/material.dart';
import 'package:shuttleservice/plugins/sizer.dart';

class Button extends StatelessWidget {
  double? width;

  final double? height;
  final ButtonStyle? style;
  final void Function()? onPressed;
  final String? text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? textColor;
  bool? bordered = false;
  final Color? buttonColor;
  final Color? borderColor;
  final double? radius;
  final Gradient? gradient;
  final TextStyle? textStyle;

  Button({Key? key, this.width, this.height, this.style, required this.onPressed, required this.text, this.fontWeight, this.fontSize, this.textColor, this.buttonColor, this.bordered, this.borderColor, this.gradient, this.radius, this.textStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      hoverColor: Colors.transparent,
      borderRadius: BorderRadius.circular(radius ?? 10000.w),
      child: Container(
        width: width ?? double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: buttonColor ?? Color(0xFF869EBA), borderRadius: BorderRadius.circular(radius ?? 10000.w), gradient: bordered == true ? null : gradient, border: Border.all(color: bordered == true ? Color(0xFF4F5051) : Colors.transparent, width: 2)),
        height: height ?? 13.5.w,
        child: Text(
          text ?? "Login",
          textAlign: TextAlign.center,
          style: textStyle ?? TextStyle(fontWeight: FontWeight.w600, fontSize: fontSize ?? 14.sp, color: textColor ?? Colors.white),
        ),
      ),
    );
  }
}
