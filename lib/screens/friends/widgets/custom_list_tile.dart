import 'package:flutter/material.dart';
import 'package:peopletalk/utils/text_styles.dart';

class CustomListTile extends StatelessWidget {
  final String? title;
  final Widget widget;
  final Function()? onPressed;
  const CustomListTile({Key? key, this.title, required this.widget, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onPressed,
          title: Text(title!, style: AppTextStyle().BASIC_STYLE),
          trailing: widget,
        ),
        Divider(thickness: 0.7, color: Colors.blueGrey),
      ],
    );
  }
}
