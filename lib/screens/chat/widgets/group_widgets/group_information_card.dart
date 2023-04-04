import 'package:flutter/material.dart';

import '../../../../widgets/navigations.dart';
import '../../group_chat/group_info.dart';

class GroupInformationCard extends StatelessWidget {
  final dynamic data;
  final dynamic groupMemberLength;
  const GroupInformationCard({Key? key, this.data, this.groupMemberLength}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          margin: EdgeInsets.all(20),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(data['image']),
          ),
        ),
        InkWell(
          onTap: () {
            navigateWithPush(
              context,
              GroupInfo(
                data: data,
                groupMemberLength: groupMemberLength,
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data['groupTitle'],
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 3),
              Text(
                "Tap Here for group Info",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
