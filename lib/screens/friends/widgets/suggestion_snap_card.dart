import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/user_model.dart';
import '../../../services/firestore_services.dart';
import '../../../utils/colors.dart';

class SuggestionSnapCard extends StatefulWidget {
  final dynamic data;
  const SuggestionSnapCard({Key? key, this.data}) : super(key: key);

  @override
  State<SuggestionSnapCard> createState() => _SuggestionSnapCardState();
}

class _SuggestionSnapCardState extends State<SuggestionSnapCard> {
  List requestStatus = [];
  List frndList = [];

  @override
  void initState() {
    getRequestStatus();
    super.initState();
  }

  getRequestStatus() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();

    setState(() {
      requestStatus = snap['invitations'];
      frndList = snap['friendsList'];
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = UserModel.fromDocument(widget.data);
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(userModel.image!),
          ),
          title: Text(
            userModel.username!,
            // snapshot.data!.docs[index]['username'],
            style: TextStyle(
              color: AppColors.PRIMARY_BLACK,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: InkWell(
              onTap: () async {
                await FireStoreServices().sendingFriendRequest(context, userModel.uid!);
              },
              child: requestStatus.contains(userModel.uid)
                  ? Text(
                      "Invited",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : frndList.contains(userModel.uid)
                      ? Text("Friend")
                      : Text(
                          "Invite",
                          style: TextStyle(
                            color: AppColors.PRIMARY_BLACK,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
            ),
          ),
        ),
        Divider(thickness: 0.5, color: Colors.blueGrey, endIndent: 30, indent: 30),
      ],
    );
  }
}
