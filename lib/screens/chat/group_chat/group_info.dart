import 'package:flutter/material.dart';
import 'package:peopletalk/utils/colors.dart';
import 'package:timeago/timeago.dart' as timeago;

class GroupInfo extends StatelessWidget {
  final dynamic data;
  final dynamic groupMemberLength;
  const GroupInfo({Key? key, this.data, this.groupMemberLength}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Information"),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Center(child: CircleAvatar(radius: 45, backgroundImage: NetworkImage(data['image']))),
          SizedBox(height: 05),
          Text(
            data['groupTitle'],
            style: TextStyle(
              fontSize: 18,
              color: AppColors.PRIMARY_BLACK,
            ),
          ),
          SizedBox(height: 05),
          Text("Group" + " " + groupMemberLength.toString() + " " + "participants"),
          SizedBox(height: 20),
          Text(data['groupDescription']),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text("Created By ${data['admin']}, ${timeago.format(data['createdAt'].toDate())}"),
          )
        ],
      ),
    );
  }
}
