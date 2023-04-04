import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:peopletalk/models/user_model.dart';
import 'package:peopletalk/screens/chat/group_chat/saving_group_info_screen.dart';
import 'package:peopletalk/utils/constants.dart';
import 'package:peopletalk/utils/show_custom_message.dart';
import 'package:peopletalk/widgets/navigations.dart';

import '../../../utils/colors.dart';
import '../../../widgets/buttons.dart';

class InviteUserForGroupChat extends StatefulWidget {
  final List<dynamic> frndList;

  const InviteUserForGroupChat({super.key, required this.frndList});

  @override
  State<InviteUserForGroupChat> createState() => _InviteUserForGroupChatState();
}

class _InviteUserForGroupChatState extends State<InviteUserForGroupChat> {
  List<dynamic> usersIdList = [FirebaseAuth.instance.currentUser!.uid];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invite User "),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.builder(
              itemCount: widget.frndList.length,
              itemBuilder: (context, index) {
                return StreamBuilder(
                  stream: fireStore.collection("users").doc(widget.frndList[index]).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    UserModel userModel = UserModel.fromDocument(snapshot.data!);
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(userModel.image!),
                            ),
                            title: Text(
                              userModel.username!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(userModel.contact!),
                            trailing: Checkbox(
                              value: usersIdList.contains(userModel.uid!) ? true : false,
                              onChanged: (v) {
                                setState(() {
                                  if (usersIdList.contains(userModel.uid!)) {
                                    showCustomMessage(context, "Id Is Already Present!!!");
                                  } else {
                                    usersIdList.add(userModel.uid!);
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        Divider(endIndent: 30, thickness: 0.7, color: AppColors.PRIMARY_GREY, indent: 30),
                        // Text(usersIdList.toString()),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Spacer(),
          PrimaryButton(
            onPressed: () {
              print("Hello");
              navigateWithPush(
                  context,
                  SavingGroupInformationScreen(
                    userIdList: usersIdList,
                  ));
            },
            title: "Make Group",
          ),
        ],
      ),
    );
  }
}
