import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class AudioCallScreen extends StatelessWidget {
  final dynamic data;
  final dynamic frndUid;
  const AudioCallScreen({Key? key, this.data, this.frndUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height: 80),
          Center(
            child: CircleAvatar(
              radius: 65,
              backgroundColor: Colors.red,
              backgroundImage: NetworkImage(data['image']),
            ),
          ),
          SizedBox(height: 30),
          Text(
            "${data['username']}",
            style: TextStyle(
              color: AppColors.PRIMARY_WHITE,
              fontSize: 25,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Calling",
            style: TextStyle(
              color: AppColors.PRIMARY_WHITE,
            ),
          ),
          SizedBox(height: 40),
          InkWell(
            onTap: () async {
              await FirebaseFirestore.instance.collection("call").doc(FirebaseAuth.instance.currentUser!.uid).delete();
              await FirebaseFirestore.instance.collection("call").doc(frndUid).delete();
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.red,
              child: Icon(Icons.phone_disabled),
            ),
          )
        ],
      ),
    );
  }
}
