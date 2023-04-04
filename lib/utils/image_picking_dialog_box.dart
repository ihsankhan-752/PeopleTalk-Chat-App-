import 'package:flutter/material.dart';

showImagePickingDialogBox({BuildContext? context, Function()? onCameraTapped, Function()? galleryTapped}) async {
  return showDialog(
      context: context!,
      builder: (_) {
        return SimpleDialog(
          title: Text("Select Image From"),
          children: [
            InkWell(
              onTap: onCameraTapped,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Camera"),
              ),
            ),
            Divider(thickness: 0.7),
            InkWell(
              onTap: galleryTapped,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Gallery"),
              ),
            ),
            Divider(thickness: 0.7),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Cancel"),
              ),
            ),
          ],
        );
      });
}
