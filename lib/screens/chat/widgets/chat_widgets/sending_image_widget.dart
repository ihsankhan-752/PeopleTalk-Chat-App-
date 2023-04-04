import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class SendingImageWidget extends StatelessWidget {
  final Function()? onPressed;
  final dynamic data;
  final File? selectedImage;
  const SendingImageWidget({Key? key, this.onPressed, this.data, this.selectedImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.95,
      color: AppColors.PRIMARY_BLACK,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(File(selectedImage!.path)),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  AppColors.PRIMARY_BLACK.withOpacity(0.5),
                  BlendMode.srcATop,
                ),
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blueGrey,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(data['username']),
                      ),
                    ),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor: Colors.teal,
                      child: IconButton(
                        onPressed: onPressed!,
                        icon: Icon(Icons.send, color: AppColors.PRIMARY_WHITE, size: 15),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
