import 'package:flutter/material.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/utils/color.dart';

class MyButton extends StatelessWidget {
  double? width;
  double? height;
  Color? buttonClr;
  BorderRadiusGeometry? borderRadius;
  final String title;
  double? fontSize;
  final Function onClick;
  FontWeight? fontWeight;

  MyButton({
    Key? key,
    this.width,
    this.height,
    this.buttonClr,
    this.borderRadius,
    required this.title,
    this.fontSize,
    required this.onClick,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 10.68.w,
      decoration: BoxDecoration(color: buttonClr ?? Clr.primaryClr, borderRadius: borderRadius ?? BorderRadius.circular(2.55.w)),
      child: InkWell(
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          onClick();
        },
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: Clr.whiteClr, fontSize: fontSize ?? 12.5.sp, fontWeight: fontWeight ?? FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
