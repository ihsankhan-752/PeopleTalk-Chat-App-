import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class AudioCallServices {
  makeAudioCall({
    dynamic frndUid,
    dynamic data,
  }) async {
    String callId = Uuid().v1();
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    FirebaseFirestore.instance.collection("call").doc(FirebaseAuth.instance.currentUser!.uid).set(
      {
        "callId": callId,
        "isDialled": true,
        "senderName": snap['username'],
        "senderImage": snap['image'],
        "senderId": snap['uid'],
        "receiverName": data['username'],
        "receiverImage": data['image'],
        "receiverId": data['uid'],
      },
    );
    await FirebaseFirestore.instance.collection("call").doc(frndUid).set(
      {
        "callId": callId,
        "isDialled": false,
        "senderName": snap['username'],
        "senderImage": snap['image'],
        "senderId": snap['uid'],
        "receiverName": data['username'],
        "receiverImage": data['image'],
        "receiverId": data['uid'],
      },
    );
  }
}
