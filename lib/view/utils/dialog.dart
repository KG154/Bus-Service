import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';

Future<void> showAlertDialog(BuildContext context) async {
  await Future.delayed(Duration(milliseconds: 50));
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text('Update'),
      content: Text(
        'New Version is Available on Store',
        style: TextStyle(color: Colors.grey),
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('No'),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            StoreRedirect.redirect(androidAppId: "com.shuttle.service");
          },
          child: Text('Yes'),
        )
      ],
    ),
  );
}

buildAppUpdateDialog(BuildContext context, String content, bool forceUpdate, String type) async {
  await Future.delayed(Duration(milliseconds: 50));
  showCupertinoModalPopup<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text('Update'),
      content: Text(
        'You need to update your application.',
        style: TextStyle(color: Colors.grey),
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            StoreRedirect.redirect(androidAppId: "com.shuttle.service");
          },
          child: Text('Update'),
        )
      ],
    ),
  );
}
