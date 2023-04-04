import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/firestore_controller.dart';
import '../../../../utils/colors.dart';

class SendingImageToGroup extends StatefulWidget {
  final File? selectedImage;
  final dynamic groupId;
  bool isLoading;

  SendingImageToGroup({Key? key, this.selectedImage, required this.isLoading, this.groupId}) : super(key: key);

  @override
  State<SendingImageToGroup> createState() => _SendingImageToGroupState();
}

class _SendingImageToGroupState extends State<SendingImageToGroup> {
  @override
  Widget build(BuildContext context) {
    final groupChatController = Provider.of<FireStoreController>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(
            File(widget.selectedImage!.path),
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(AppColors.PRIMARY_BLACK.withOpacity(0.5), BlendMode.srcATop),
        ),
      ),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () async {
              setState(() {
                widget.isLoading = true;
              });
              await groupChatController.sendingImageInGroup(
                context: context,
                selectedImage: widget.selectedImage,
                groupId: widget.groupId,
              );
              setState(() {
                widget.isLoading = false;
              });
            },
            child: CircleAvatar(
              backgroundColor: Colors.teal,
              radius: 25,
              child: widget.isLoading
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(color: Colors.deepOrangeAccent),
                    )
                  : Text("Send"),
            ),
          ),
        ),
      ),
    );
  }
}
