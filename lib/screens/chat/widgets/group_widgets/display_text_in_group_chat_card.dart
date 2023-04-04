import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DisplayTextInGroupChatCard extends StatelessWidget {
  final dynamic data;
  const DisplayTextInGroupChatCard({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: data['senderId'] == FirebaseAuth.instance.currentUser!.uid ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  data['senderName'],
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(data['msg']),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
