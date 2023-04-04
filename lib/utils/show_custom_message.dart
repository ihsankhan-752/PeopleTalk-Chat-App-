import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showCustomMessage(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
    ),
  );
}
