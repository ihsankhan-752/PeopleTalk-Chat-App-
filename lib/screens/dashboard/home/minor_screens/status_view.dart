import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peopletalk/screens/chat/widgets/photo_view.dart';
import 'package:peopletalk/widgets/navigations.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../widgets/status_not_uploaded_widget.dart';

class StatusView extends StatefulWidget {
  const StatusView({Key? key}) : super(key: key);

  @override
  State<StatusView> createState() => _StatusViewState();
}

class _StatusViewState extends State<StatusView> {
  String imageUrl = '';
  String statusUrl = '';

  DateTime? statusTime;
  List frndIds = [];
  File? selectedImage;
  getImageFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      selectedImage = File(pickedFile!.path);
    });
  }

  getCurrentUserData() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    imageUrl = snap['image'];
    frndIds = snap['friendsList'];
    setState(() {});
  }

  @override
  void initState() {
    getCurrentUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          StatusNotUpload(
            selectedImage: selectedImage,
            imageUrl: imageUrl,
            onTapped: () {
              getImageFromCamera();
            },
          ),
          Divider(thickness: 0.7, color: Colors.blueGrey),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("status")
                  .where("createdAt", isGreaterThan: DateTime.now().subtract(Duration(days: 1)))
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    if (frndIds.contains(snapshot.data!.docs[index].id)) {
                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(snapshot.data!.docs[index]['status']),
                            ),
                            title: Text(snapshot.data!.docs[index]['username']),
                            subtitle: Text(timeago.format(snapshot.data!.docs[index]['createdAt'].toDate())),
                            onTap: () {
                              navigateWithPush(
                                  context,
                                  PhotoView(
                                    image: snapshot.data!.docs[index]['status'],
                                  ));
                            },
                          ),
                          Divider(thickness: 0.8, color: Colors.blueGrey, endIndent: 30, indent: 30),
                        ],
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
