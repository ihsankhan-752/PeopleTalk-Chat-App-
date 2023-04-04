import 'package:flutter/material.dart';
import 'package:peopletalk/screens/chat/widgets/photo_view.dart';
import 'package:peopletalk/widgets/navigations.dart';

class DisplayImageInChat extends StatelessWidget {
  final dynamic data;
  const DisplayImageInChat({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateWithPush(context, PhotoView(image: data['image']));
      },
      child: Container(
        height: 100,
        width: 100,
        child: Image.network(data['image'], fit: BoxFit.cover),
      ),
    );
    ;
  }
}
