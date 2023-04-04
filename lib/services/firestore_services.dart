import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:peopletalk/services/storage_sevices.dart';
import 'package:uuid/uuid.dart';

import '../utils/constants.dart';
import '../utils/show_custom_message.dart';

class FireStoreServices {
  String requestId = Uuid().v1();

  sendingFriendRequest(BuildContext context, String idOfUser) async {
    try {
      await fireStore.collection("requests").doc(requestId).set({
        "senderId": FirebaseAuth.instance.currentUser!.uid,
        "receiverUid": idOfUser,
        "status": "",
        "invited": true,
        "createdAt": DateTime.now(),
      });
      await fireStore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
        "invitations": FieldValue.arrayUnion([idOfUser]),
      });
    } catch (e) {
      showCustomMessage(context, e.toString());
    }
  }

  creatingGroupInformationCollection({
    BuildContext? context,
    String? titleController,
    String? descController,
    List? userIdList,
    File? selectedImage,
  }) async {
    String groupId = Uuid().v1();
    String url = await StorageServices().uploadImageToStorage(context!, File(selectedImage!.path));

    DocumentSnapshot snap = await fireStore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    await fireStore.collection("groupChat").doc(groupId).set({
      "groupId": groupId,
      "image": url,
      "groupTitle": titleController,
      "groupDescription": descController,
      "uids": FieldValue.arrayUnion(userIdList!),
      "createdAt": DateTime.now(),
      "admin": snap['username'],
      "adminId": snap['uid'],
    });
  }
}
