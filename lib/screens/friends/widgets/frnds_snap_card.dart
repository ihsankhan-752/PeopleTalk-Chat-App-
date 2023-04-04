import 'package:flutter/material.dart';
import 'package:peopletalk/widgets/navigations.dart';

import '../../../utils/colors.dart';
import '../../chat/one_to_one_chat/chat_main_screen.dart';

class FriendSnapCard extends StatelessWidget {
  final dynamic data;
  const FriendSnapCard({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            navigateWithPush(
                context,
                ChatMainScreen(
                  frndUid: data['uid'],
                  data: data,
                ));
          },
          leading: CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(data['image']),
          ),
          title: Text(
            data['username'],
            style: TextStyle(
              fontSize: 16,
              color: AppColors.PRIMARY_BLACK,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            data['contact'],
            style: TextStyle(
              color: AppColors.PRIMARY_GREY,
              fontSize: 14,
            ),
          ),
        ),
        Divider(thickness: 0.7, color: AppColors.PRIMARY_GREY),
      ],
    );
  }
}
