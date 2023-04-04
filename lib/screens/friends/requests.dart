import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:peopletalk/screens/friends/widgets/frnd_request_snap_card.dart';
import 'package:peopletalk/utils/colors.dart';
import 'package:peopletalk/utils/constants.dart';

import '../../../../utils/text_styles.dart';

class FriendRequestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Friend Requests", style: AppTextStyle().BASIC_STYLE.copyWith(color: AppColors.PRIMARY_WHITE)),
      ),
      body: StreamBuilder(
        stream: fireStore
            .collection('requests')
            .where("receiverUid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where("status", isEqualTo: "")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "Sorry No Requests Found",
                style: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return StreamBuilder(
                stream: fireStore.collection('users').doc(snapshot.data!.docs[index]['senderId']).snapshots(),
                builder: (context, userSnap) {
                  if (!userSnap.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  Map<String, dynamic> userData = userSnap.data!.data() as Map<String, dynamic>;
                  return FriendRequestSnapCard(
                    data: userData,
                    docId: snapshot.data!.docs[index].id,
                    createdAt: snapshot.data!.docs[index]['createdAt'].toDate(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
