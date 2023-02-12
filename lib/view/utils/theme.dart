import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shuttleservice/plugins/sizer.dart';
import 'package:shuttleservice/view/utils/strings.dart';

import 'color.dart';

ThemeData theme() {
  Map<int, Color> colorCodes = {
    50: Color(0xFF0056A7),
    100: Color(0xFF0056A7),
    200: Color(0xFF0056A7),
    300: Color(0xFF0056A7),
    400: Color(0xFF0056A7),
    500: Color(0xFF0056A7),
    600: Color(0xFF0056A7),
    700: Color(0xFF0056A7),
    800: Color(0xFF0056A7),
    900: Color(0xFF0056A7),
  };
  return ThemeData(
    fontFamily: Str.fontFamily,
    scaffoldBackgroundColor: Clr.bgColor,
    // brightness: Brightness.dark,
    // primaryColorBrightness: Brightness.dark,
    // accentColorBrightness: Brightness.dark,
    // primarySwatch: MaterialColor(0xFF0056A7, colorCodes),
    // primaryColor: Clr.primaryColor,
    // canvasColor:  Colors.transparent,
    // indicatorColor: Clr.indicatorColor,
    // dialogBackgroundColor: Clr.dialogBackgroundColor,
    hintColor: Clr.textFieldHintClr,
    // errorColor: Clr.errorColor,
    // inputDecorationTheme: inputDecorationTheme(),

    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        // systemNavigationBarDividerColor: Clr.bottomDividerClr,
      ),
      iconTheme: IconThemeData(color: Clr.primaryClr),
      centerTitle: false,
      titleTextStyle: TextStyle(color: Clr.textFieldTextClr, fontWeight: FontWeight.w600, fontSize: 13.sp, fontFamily: Str.fontFamily),
    ),
    textSelectionTheme: TextSelectionThemeData(cursorColor: Clr.textFieldHintClr),
  );
}

// InputDecorationTheme inputDecorationTheme() {
//   OutlineInputBorder enabledBorder = OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(1.3.w)),
//   );
//   OutlineInputBorder focusedBorder = OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(1.3.w)),
//   );
//   OutlineInputBorder errorBorder = OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(1.3.w)),
//   );
//   OutlineInputBorder focusedErrorBorder = OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(1.3.w)),
//   );
//   return InputDecorationTheme(
//     enabledBorder: enabledBorder,
//     focusedBorder: focusedBorder,
//     errorBorder: errorBorder,
//     focusedErrorBorder: focusedErrorBorder,
//     contentPadding: EdgeInsets.symmetric(vertical: 3.2.w, horizontal: 3.5.w),
//     border: InputBorder.none,
//     hintStyle: TS.textFieldHintStyle1,
//     errorStyle: TS.textFieldErrorStyle,
//     labelStyle: TS.textFieldLabelStyle,
//     helperStyle: TS.textFieldHelperStyle,
//     prefixStyle: TS.bodyText1,
//     suffixStyle: TS.bodyText1,
//     counterStyle: TS.bodyText1,
//   );
// }
