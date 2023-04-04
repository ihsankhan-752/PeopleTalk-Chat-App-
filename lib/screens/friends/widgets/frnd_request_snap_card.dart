import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:peopletalk/utils/constants.dart';
import 'package:peopletalk/utils/show_custom_message.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../utils/colors.dart';

class FriendRequestSnapCard extends StatelessWidget {
  final dynamic data;
  final String? docId;
  final DateTime? createdAt;
  const FriendRequestSnapCard({Key? key, this.data, this.docId, this.createdAt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(radius: 35, backgroundImage: NetworkImage(data['image'])),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 2),
                  Text(
                    data['username'].toString().toUpperCase(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.PRIMARY_BLACK,
                    ),
                  ),
                  SizedBox(height: 04),
                  Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          try {
                            await fireStore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
                              "friendsList": FieldValue.arrayUnion([data['uid']]),
                            });
                            await fireStore.collection("users").doc(data['uid']).update({
                              "friendsList": FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
                            });
                            // await fireStore.collection("requests").doc(docId).update({
                            //   "invitations": FieldValue.arrayRemove([data['uid']]),
                            // });
                            await fireStore.collection("requests").doc(docId).update({
                              "status": "confirm",
                            });
                          } catch (e) {
                            showCustomMessage(context, e.toString());
                          }
                        },
                        child: Container(
                          height: 25,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.SKY,
                          ),
                          child: Center(
                            child: Text(
                              "Confirm",
                              style: TextStyle(
                                color: AppColors.PRIMARY_WHITE,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async{
                          await fireStore.collection("requests").doc(docId).delete();
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          height: 25,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.PRIMARY_GREY,
                          ),
                          child: Center(
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                color: AppColors.PRIMARY_BLACK,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Center(
                  child: Text(
                    timeago.format(createdAt!),
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(thickness: 0.7, color: AppColors.PRIMARY_GREY),
        ],
      ),
    );
  }
}
