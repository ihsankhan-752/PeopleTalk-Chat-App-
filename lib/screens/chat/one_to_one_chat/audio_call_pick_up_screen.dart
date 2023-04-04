import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class AudioCallPickUpScreen extends StatelessWidget {
  final Widget scaffold;
  const AudioCallPickUpScreen({Key? key, required this.scaffold}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("call").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.data() != null) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          if (data['isDialled'] == false) {
            return Scaffold(
              backgroundColor: AppColors.PRIMARY_BLACK,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(data['receiverImage']),
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    data['receiverName'],
                    style: TextStyle(
                      color: AppColors.PRIMARY_WHITE,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.green,
                        child: Icon(Icons.phone),
                      ),
                      SizedBox(width: 50),
                      InkWell(
                        onTap: () async {
                          await FirebaseFirestore.instance.collection("call").doc(FirebaseAuth.instance.currentUser!.uid).delete();
                          await FirebaseFirestore.instance.collection("call").doc(data['senderId']).delete();
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.red,
                          child: Icon(Icons.phone_disabled),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }
        }
        return scaffold;
      },
    );
  }
}
