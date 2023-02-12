import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/utils/assets.dart';
import 'package:shuttleservice/view/utils/color.dart';
import 'package:shuttleservice/view/utils/const.dart';

class MyDropDown extends StatefulWidget {
  TextStyle? style;
  String hintText;
  List itemList;
  String? selectedValue;
  String validatorText;
  void Function(String?)? onChange;
  double? buttonHeight;
  EdgeInsetsGeometry? contentPadding;

  MyDropDown({
    Key? key,
    this.style,
    required this.hintText,
    required this.itemList,
    this.selectedValue,
    required this.onChange,
    required this.validatorText,
    this.buttonHeight,
    this.contentPadding,
  }) : super(key: key);

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      alignment: Alignment.centerLeft,
      decoration: InputDecoration(
        contentPadding: widget.contentPadding ?? EdgeInsets.symmetric(vertical: 1.w),
        border: borderInput,
        focusedBorder: focusBorderInput,
        errorBorder: errorBoarderInput,
        enabledBorder: borderInput,
        hintStyle: hintTextStyle,
        filled: true,
        fillColor: Clr.textFieldBgClr,
      ),
      style: inputTextStyle,
      isExpanded: true,
      hint: Text(
        widget.hintText,
        style: hintTextStyle,
      ),
      icon: Padding(
        padding: EdgeInsets.only(right: 2.w),
        child: SvgPicture.asset(AstSVG.dropDownArrow_ic, color: Clr.textFieldHintClr),
      ),
      iconSize: 8.w,
      buttonHeight: widget.buttonHeight,
      value: widget.selectedValue,
      // dropdownPadding: EdgeInsets.only(left: 2.55.w, right: 2.55.w, top: 1.5.w, bottom: 1.5.w),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(2.5.w),
          bottomRight: Radius.circular(2.5.w),
        ),
      ),
      selectedItemBuilder: (BuildContext context) {
        //<-- SEE HERE
        return widget.itemList.map((item) {
          return Text(
            item,
            style: inputTextStyle,
          );
        }).toList();
      },
      items: widget.itemList
          .map((item) => DropdownMenuItem<String>(
                value: item,
                onTap: () {
                  widget.selectedValue = item;
                  setState(() {});
                },
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: widget.selectedValue == item.toString() ? Clr.primaryClr : Clr.bottomTextClr,
                  ),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return widget.validatorText;
        }
        return null;
      },
      onChanged: widget.onChange,
      onSaved: (value) {
        widget.selectedValue = value.toString();
      },
    );
  }
}
