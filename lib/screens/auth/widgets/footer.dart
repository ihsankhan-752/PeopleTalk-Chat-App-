import 'package:flutter/material.dart';

import '../../../utils/text_styles.dart';

class AuthFooter extends StatelessWidget {
  final String? title, screenName;
  final Function()? onPressed;
  const AuthFooter({Key? key, this.title, this.screenName, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Center(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: "$title", style: AppTextStyle().BASIC_STYLE),
              TextSpan(text: " $screenName", style: AppTextStyle().BASIC_STYLE.copyWith(color: Colors.pink)),
            ],
          ),
        ),
      ),
    );
  }
}
