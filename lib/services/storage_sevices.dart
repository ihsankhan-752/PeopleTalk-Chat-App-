import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:peopletalk/utils/show_custom_message.dart';

class StorageServices {
  Future<String> uploadImageToStorage(BuildContext context, File? image) async {
    String? imageUrl;
    try {
      FirebaseStorage fs = FirebaseStorage.instance;
      Reference ref = await fs.ref().child(DateTime.now().millisecondsSinceEpoch.toString());
      await ref.putFile(File(image!.path));
      imageUrl = await ref.getDownloadURL();
    } catch (e) {
      showCustomMessage(context, e.toString());
    }
    return imageUrl!;
  }
}
