import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupAudioWidget extends StatelessWidget {
  final Widget widget;
  final dynamic data;
  const GroupAudioWidget({Key? key, required this.widget, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: data['senderId'] == FirebaseAuth.instance.currentUser!.uid ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 10),
        width: MediaQuery.of(context).size.width * 0.45,
        decoration: BoxDecoration(
          color:
              data['senderId'] == FirebaseAuth.instance.currentUser!.uid ? Colors.blueGrey.withOpacity(0.6) : Colors.brown.withOpacity(0.3),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget,
        ),
      ),
    );
  }
}
