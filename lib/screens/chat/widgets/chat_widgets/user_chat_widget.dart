import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class UserChatWidget extends StatelessWidget {
  final String? docId;
  final Function(dynamic data) getData;
  const UserChatWidget({Key? key, this.docId, required this.getData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.78,
      child: StreamBuilder(
        stream: fireStore.collection("chats").doc(docId).collection("messages").orderBy("createdAt", descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No Chat Found!!!"),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.only(bottom: 15, top: 8),
            reverse: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var data = snapshot.data!.docs[index];

              return Align(
                alignment: data['senderId'] == FirebaseAuth.instance.currentUser!.uid ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: data['senderId'] == FirebaseAuth.instance.currentUser!.uid ? Colors.brown[100] : Colors.blueGrey[500],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        bottomLeft: Radius.circular(18),
                        bottomRight: Radius.circular(18),
                      ),
                    ),
                    child: getData(data)),
              );
            },
          );
        },
      ),
    );
  }
}
