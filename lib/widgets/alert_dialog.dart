import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogs {
  showCustomAlertDialog({
    BuildContext? context,
    String? title,
    String? content,
    Function()? onPositiveTapped,
    Function()? onNegativeTapped,
  }) async {
    return showDialog(
        context: context!,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text(title!),
            content: Text(content!),
            actions: [
              CupertinoActionSheetAction(onPressed: onNegativeTapped ?? () {}, child: Text("No")),
              CupertinoActionSheetAction(onPressed: onPositiveTapped ?? () {}, child: Text("Yes")),
            ],
          );
        });
  }
}
