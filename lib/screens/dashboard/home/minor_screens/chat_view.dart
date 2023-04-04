import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:peopletalk/screens/chat/one_to_one_chat/chat_main_screen.dart';
import 'package:peopletalk/utils/constants.dart';
import 'package:peopletalk/widgets/navigations.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../utils/colors.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: MediaQuery.of(context).size.height * 0.58,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("chats").where("uids", arrayContains: FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var data = snapshot.data!.docs[index]['uids'];
              getUsersId() {
                if (data[0] == FirebaseAuth.instance.currentUser!.uid) {
                  return data[1];
                } else {
                  return data[0];
                }
              }

              return Container(
                child: StreamBuilder(
                  stream: fireStore.collection("users").doc(getUsersId()).snapshots(),
                  builder: (context, snap2) {
                    if (!snap2.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    Map<String, dynamic> userData = snap2.data!.data() as Map<String, dynamic>;
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            navigateWithPush(
                                context,
                                ChatMainScreen(
                                  frndUid: userData['uid'],
                                  data: userData,
                                ));
                          },
                          leading: CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(userData['image']),
                          ),
                          title: Text(
                            userData['username'],
                            style: TextStyle(
                              color: AppColors.PRIMARY_BLACK,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(snapshot.data!.docs[index]['lastMsg']),
                          trailing: Text(
                            timeago.format(snapshot.data!.docs[index]['createdAt'].toDate()),
                            style: TextStyle(
                              color: Colors.teal,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Divider(thickness: 0.5, color: Colors.blueGrey, endIndent: 20, indent: 20),
                      ],
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
