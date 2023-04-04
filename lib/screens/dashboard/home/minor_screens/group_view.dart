import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:peopletalk/screens/chat/group_chat/group_chat.dart';
import 'package:peopletalk/widgets/navigations.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';

class GroupView extends StatelessWidget {
  const GroupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: StreamBuilder(
        stream: fireStore.collection("groupChat").where("uids", arrayContains: FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("You Have No Group Till Now"),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var groupData = snapshot.data!.docs[index];
              int groupMemberLength = groupData['uids'].length;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        navigateWithPush(
                            context,
                            GroupChatMainScreen(
                              groupId: snapshot.data!.docs[index].id,
                              data: groupData,
                              groupMemberlength: groupMemberLength,
                            ));
                      },
                      leading: CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(groupData['image']),
                      ),
                      title: Text(groupData['groupTitle']),
                      subtitle: Text(groupData['uids'].length.toString() + " members"),
                      trailing: Text(timeago.format(groupData['createdAt'].toDate())),
                    ),
                    Divider(endIndent: 20, color: AppColors.PRIMARY_GREY, thickness: 0.6, indent: 40),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
