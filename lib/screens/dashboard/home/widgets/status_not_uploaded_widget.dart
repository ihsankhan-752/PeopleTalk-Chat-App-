import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../services/storage_sevices.dart';
import '../../../../utils/colors.dart';

class StatusNotUpload extends StatefulWidget {
  File? selectedImage;
  final String? imageUrl;
  final Function()? onTapped;
  StatusNotUpload({Key? key, this.selectedImage, this.imageUrl, this.onTapped}) : super(key: key);

  @override
  State<StatusNotUpload> createState() => _StatusNotUploadState();
}

class _StatusNotUploadState extends State<StatusNotUpload> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.selectedImage == null
            ? ListTile(
                leading: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(widget.imageUrl!),
                    ),
                    Positioned(
                      bottom: 0,
                      right: -05,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.teal[500],
                        ),
                        child: InkWell(onTap: widget.onTapped, child: Icon(Icons.add, size: 15, color: AppColors.PRIMARY_WHITE)),
                      ),
                    )
                  ],
                ),
                title: Text("My Status"),
                subtitle: Text("Tap to Add status update"),
              )
            : Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(widget.selectedImage!.path)),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10, bottom: 10),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.teal,
                      ),
                      child: InkWell(
                        onTap: () async {
                          try {
                            setState(() {
                              isLoading = true;
                            });
                            String url = await StorageServices().uploadImageToStorage(context, widget.selectedImage);
                            DocumentSnapshot snap =
                                await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
                            await FirebaseFirestore.instance.collection("status").doc(FirebaseAuth.instance.currentUser!.uid).set({
                              "status": url,
                              "createdAt": DateTime.now(),
                              "username": snap['username'],
                            });
                            setState(() {
                              isLoading = false;
                              widget.selectedImage = null;
                            });
                          } catch (e) {
                            setState(() {
                              isLoading = false;
                            });
                            print(e);
                          }
                        },
                        child: isLoading
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              )
                            : Icon(Icons.send, size: 15, color: AppColors.PRIMARY_WHITE),
                      ),
                    )
                  ],
                ),
              ),
      ],
    );
  }
}
