import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/utils/color.dart';
import 'package:shuttleservice/view/utils/strings.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  EdgeInsetsGeometry? contentPadding;
  EdgeInsetsGeometry? padding;
  TextEditingController controller;
  bool? readOnly;
  String hintText;
  String validate;
  bool? obscureText;
  TextInputAction? textInputAction;
  TextInputType keyboardType;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool? fill;
  Color? fillColor;
  Color? cursorColor;
  String inputFormat;
  TextStyle? hintTextStyle;
  TextStyle? inputTextStyle;
  int? extraSetup;
  Function()? fun;
  Function(String)? onChanged;
  Function(String)? onFieldSubmitted;
  void Function()? onTap;
  int? maxLines;
  String? error;
  int? maxLength;
  int? minLine;
  bool? isDense;
  bool? isCollapsed;
  InputBorder? border;
  InputBorder? enableBorder;
  InputBorder? focusBorder;
  InputBorder? errorBorder;
  bool? autoFocus;
  BoxConstraints? prefixIconConstraints;
  BoxConstraints? suffixIconConstraints;
  String? Function(String?)? validator;
  double? hintSize;
  double? fontSize;
  double? borderWidth;
  double? borderRadius;
  double? cursorHeight;
  Color? borderColor;


  MyTextField({
    Key? key,
    this.cursorHeight,
    this.readOnly,
    this.autoFocus,
    required this.controller,
    required this.hintText,
    required this.validate,
    this.obscureText,
    required this.keyboardType,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.extraSetup,
    this.fill,
    this.fillColor,
    required this.inputFormat,
    this.hintTextStyle,
    this.inputTextStyle,
    this.fun,
    this.onChanged,
    this.onFieldSubmitted,
    this.maxLines,
    this.minLine,
    this.error,
    this.onTap,
    this.contentPadding,
    this.padding,
    this.maxLength,
    this.isDense,
    this.border,
    this.enableBorder,
    this.isCollapsed,
    this.focusBorder,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.validator,
    this.cursorColor,
    this.errorBorder,
    this.hintSize,
    this.fontSize,
    this.borderWidth,
    this.borderRadius,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.only(top: 3.w, left: 1.w, right: 1.w),
      child: TextFormField(
        controller: controller,
        onTap: onTap,
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        maxLines: maxLines ?? 1,
        onChanged: onChanged,
        cursorColor: cursorColor ?? Clr.textFieldHintClr,
        cursorHeight: cursorHeight ?? 20,
        cursorWidth: 1.5,
        textInputAction: textInputAction ?? TextInputAction.next,
        inputFormatters: inputFormattersFun(),
        textAlign: TextAlign.left,
        readOnly: readOnly ?? false,
        style: inputTextStyle ?? TextStyle(fontWeight: FontWeight.w600, color: Clr.textFieldTextClr, height: 1.2, fontSize: fontSize),
        maxLength: maxLength,
        validator: validator,
        minLines: minLine ?? 1,
        autofocus: autoFocus ?? false,
        decoration: InputDecoration(
          isCollapsed: isCollapsed ?? false,
          errorText: error,
          fillColor: fillColor ?? Clr.whiteClr,
          filled: true,
          isDense: isDense ?? true,
          counterText: '',
          contentPadding: contentPadding,
          hintText: hintText,
          hintStyle: hintTextStyle ?? TextStyle(color: Clr.textFieldHintClr, fontWeight: FontWeight.w400, height: 1.2, fontSize: hintSize),
          border: border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 7.w),
                borderSide: BorderSide(color: borderColor ?? Clr.whiteClr, width: borderWidth ?? 0),
              ),
          enabledBorder: border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 7.w),
                borderSide: BorderSide(color: borderColor ?? Clr.whiteClr, width: 0),
              ),
          focusedBorder: focusBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 7.w),
                borderSide: BorderSide(color: Clr.whiteClr, width: 0),
              ),
          errorBorder: errorBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 7.w),
                borderSide: BorderSide(color: Clr.inactiveClr, width: 0.40.w),
              ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          prefixIconConstraints: prefixIconConstraints,
          suffixIconConstraints: suffixIconConstraints,
        ),
      ),
    );
  }

  inputFormattersFun() {
    switch (inputFormat) {
      case Validate.nameFormat:
        return [
          LengthLimitingTextInputFormatter(35),
          NoLeadingSpaceFormatter(),
          FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú 0-9 .,-]")),
        ];
      case Validate.numberFormat:
        return [
          NoLeadingSpaceFormatter(),
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        ];
      case Validate.emailFormat:
        return [
          NoLeadingSpaceFormatter(),
          LowerCaseTextFormatter(),
          FilteringTextInputFormatter.deny(RegExp("[ ]")),
          FilteringTextInputFormatter.allow(RegExp("[a-zá-ú0-9.,-_@]")),
          LengthLimitingTextInputFormatter(50),
        ];
      case Validate.passFormat:
        return [
          LengthLimitingTextInputFormatter(20),
          FilteringTextInputFormatter.deny(RegExp('[ ]')),
          FilteringTextInputFormatter.allow(RegExp("[a-zA-Zá-úÁ-Ú0-9-@\$%&#*]")),
        ];
      // case Validate.chatFormat:
      //   return [
      //     // LengthLimitingTextInputFormatter(35),
      //     NoLeadingSpaceFormatter(),
      //     FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú 0-9 .,-]")),
      //   ];
      // case Validate.addressFormat:
      //   return [
      //     NoLeadingSpaceFormatter(),
      //     FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú 0-9 .,-]")),
      //   ];
      // case Validate.numberFormat:
      //   return [
      //     hintText == Hints.pinCodeHint
      //         ? LengthLimitingTextInputFormatter(6)
      //         : LengthLimitingTextInputFormatter(10),
      //     NoLeadingSpaceFormatter(),
      //     FilteringTextInputFormatter.allow(RegExp("[0-9]")),
      //   ];
      // case Validate.doubleFormat:
      //   return [
      //     hintText == Hints.pinCodeHint
      //         ? LengthLimitingTextInputFormatter(6)
      //         : LengthLimitingTextInputFormatter(10),
      //     NoLeadingSpaceFormatter(),
      //     FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)')),
      //   ];
      // case Validate.URLFormat:
      //   return [
      //     NoLeadingSpaceFormatter(),
      //     FilteringTextInputFormatter.deny(RegExp('[ ]')),
      //     FilteringTextInputFormatter.allow(RegExp("[a-z 0-9.:/]")),
      //   ];
      // case Validate.noteFormat:
      //   return [
      //     NoLeadingSpaceFormatter(),
      //     FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú 0-9 .,-]")),
      //   ];
      case Validate.textFormat:
        return [
          NoLeadingSpaceFormatter(),
          FilteringTextInputFormatter.deny(RegExp('[ ]')),
          FilteringTextInputFormatter.allow(RegExp("[a-z A-Z á-ú Á-Ú 0-9]")),
        ];
      default:
        return [
          NoLeadingSpaceFormatter(),
        ];
    }
  }
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final String trimedText = newValue.text.trimLeft();

      return TextEditingValue(
        text: trimedText,
        selection: TextSelection(
          baseOffset: trimedText.length,
          extentOffset: trimedText.length,
        ),
      );
    }

    return newValue;
  }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(text: newValue.text.toLowerCase(), selection: newValue.selection);
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}
