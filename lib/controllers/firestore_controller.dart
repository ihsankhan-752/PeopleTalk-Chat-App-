import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peopletalk/screens/chat/one_to_one_chat/chat_main_screen.dart';

import '../services/notification_services.dart';
import '../services/storage_sevices.dart';
import '../utils/constants.dart';
import '../utils/show_custom_message.dart';

class FireStoreController extends ChangeNotifier {
  sendingAudioFile({
    BuildContext? context,
    String? docId,
    String? myId,
    String? frndUid,
    String? path,
    dynamic data,
    TextEditingController? chatController,
  }) async {
    FirebaseStorage fs = FirebaseStorage.instance;
    Reference ref = await fs.ref().child(DateTime.now().millisecondsSinceEpoch.toString());
    await ref.putFile(File(path!));
    String audioUrl = await ref.getDownloadURL();
    DocumentSnapshot snap = await fireStore.collection("chats").doc(docId).get();
    if (snap.exists) {
      fireStore.collection("chats").doc(docId).update({
        "lastMsg": 'you have received audio',
      });
    } else {
      fireStore.collection("chats").doc(docId).set({
        "uids": [myId, frndUid],
        "lastMsg": 'you have received audio file',
        "createdAt": DateTime.now(),
      });
    }

    await fireStore.collection("chats").doc(docId).collection("messages").add({
      "createdAt": DateTime.now(),
      "msg": '',
      "senderImage": data['image'],
      "senderId": frndUid,
      "username": data['username'],
      "image": "",
      'audioUrl': audioUrl,
    });

    chatController!.clear();
    FocusScope.of(context!).unfocus();
    notifyListeners();
  }

  sendingTextMsg({
    BuildContext? context,
    String? docId,
    String? myId,
    String? frndUid,
    dynamic data,
    TextEditingController? chatController,
    bool? isEmojiTap,
  }) async {
    try {
      DocumentSnapshot snap = await fireStore.collection("chats").doc(docId).get();
      if (snap.exists) {
        fireStore.collection("chats").doc(docId).update({
          "lastMsg": chatController!.text,
          "createdAt": DateTime.now(),
        });
      } else {
        fireStore.collection("chats").doc(docId).set({
          "uids": [myId, frndUid],
          "lastMsg": chatController!.text,
          "createdAt": DateTime.now(),
        });
      }
      await fireStore.collection("chats").doc(docId).collection("messages").add({
        "createdAt": DateTime.now(),
        "msg": chatController.text,
        "senderImage": data['image'],
        "senderId": frndUid,
        "username": data['username'],
        'audioUrl': "",
        "image": "",
      });

      chatController.clear();
      FocusScope.of(context!).unfocus();
      isEmojiTap = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  //===========Sending Notification To Specific User==========//
  sendNotificationToSpecificUser({
    String? msg,
    String? description,
    String? frndUid,
  }) async {
    try {
      DocumentSnapshot snap = await FirebaseFirestore.instance.collection("tokens").doc(frndUid).get();
      NotificationServices().sendPushNotification(
        snap['token'],
        "$msg",
        "You Have Received A New $description",
      );
      print(snap['token']);
    } catch (e) {
      print(e);
    }
  }

  sendingImage({
    BuildContext? context,
    String? docId,
    String? myId,
    String? frndUid,
    dynamic data,
    File? selectedImage,
    bool? isLoading,
  }) async {
    try {
      String imageUrl = await StorageServices().uploadImageToStorage(context!, selectedImage);
      DocumentSnapshot snap = await fireStore.collection("chats").doc(docId).get();
      if (snap.exists) {
        fireStore.collection("chats").doc(docId).update({
          "lastMsg": 'you have received Image',
        });
      } else {
        fireStore.collection("chats").doc(docId).set({
          "uids": [myId, frndUid],
          "lastMsg": "you have Image",
          "createdAt": DateTime.now(),
        });
      }
      await fireStore.collection("chats").doc(docId).collection("messages").add({
        "createdAt": DateTime.now(),
        "msg": "",
        "senderImage": data['image'],
        "senderId": frndUid,
        "username": data['username'],
        'audioUrl': "",
        "image": imageUrl,
      });

      selectedImage = null;
      FocusScope.of(context).unfocus();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ChatMainScreen(
            frndUid: frndUid,
            data: data,
          ),
        ),
      );

      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print(e);
    }
  }

  //==========================Group_Chat============================//
  sendingTextInGroup({
    BuildContext? context,
    TextEditingController? chatController,
    dynamic groupId,
  }) async {
    DocumentSnapshot snap = await fireStore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    try {
      await fireStore.collection("groupChat").doc(groupId).collection("messages").add({
        "msg": chatController!.text,
        "createdAt": DateTime.now(),
        "senderId": FirebaseAuth.instance.currentUser!.uid,
        "senderName": snap['username'],
        "senderImage": snap['image'],
        "imageUrl": "",
        "audioUrl": "",
      });

      FocusScope.of(context!).unfocus();
      chatController.clear();
      notifyListeners();
    } catch (e) {
      showCustomMessage(context!, e.toString());
    }
  }

  sendingImageInGroup({
    BuildContext? context,
    File? selectedImage,
    dynamic groupId,
  }) async {
    DocumentSnapshot snap = await fireStore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    String imageUrl = await StorageServices().uploadImageToStorage(context!, selectedImage);
    try {
      await fireStore.collection("groupChat").doc(groupId).collection("messages").add({
        "msg": "",
        "createdAt": DateTime.now(),
        "senderId": FirebaseAuth.instance.currentUser!.uid,
        "senderName": snap['username'],
        "senderImage": snap['image'],
        "imageUrl": imageUrl,
        "audioUrl": "",
      });

      Navigator.of(context).pop();
      selectedImage = null;

      notifyListeners();
    } catch (e) {
      showCustomMessage(context, e.toString());
    }
  }

  sendingAudioToGroup({
    BuildContext? context,
    String? path,
    dynamic groupId,
  }) async {
    FirebaseStorage fs = FirebaseStorage.instance;
    Reference ref = await fs.ref().child(DateTime.now().millisecondsSinceEpoch.toString());
    await ref.putFile(File(path!));
    String audioUrl = await ref.getDownloadURL();
    DocumentSnapshot snap = await fireStore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    await fireStore.collection("groupChat").doc(groupId).collection("messages").add({
      "msg": "",
      "createdAt": DateTime.now(),
      "senderId": FirebaseAuth.instance.currentUser!.uid,
      "senderName": snap['username'],
      "senderImage": snap['image'],
      "imageUrl": "",
      "audioUrl": audioUrl,
    });
  }
}
