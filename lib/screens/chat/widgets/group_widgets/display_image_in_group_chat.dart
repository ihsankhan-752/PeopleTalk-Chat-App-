import 'package:flutter/material.dart';
import 'package:peopletalk/utils/colors.dart';
import 'package:peopletalk/widgets/navigations.dart';

import '../photo_view.dart';

class DisplayImageInGroupChat extends StatelessWidget {
  final dynamic data;
  const DisplayImageInGroupChat({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            navigateWithPush(
                context,
                PhotoView(
                  image: data['imageUrl'],
                ));
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            height: 100,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(AppColors.PRIMARY_BLACK.withOpacity(0.3), BlendMode.srcATop),
                    child: Image.network(
                      data['imageUrl'],
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 08, top: 05),
                  child: Text(
                    data['senderName'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.pink,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
