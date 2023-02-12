import 'package:flutter/material.dart';
import 'package:shuttleservice/plugins/sizer.dart';

showCustomBottomSheet(BuildContext context, {required Widget child}) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(7.63.w), topRight: Radius.circular(7.63.w)),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setSta) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: child,
          ),
        );
      });
    },
  );
}
