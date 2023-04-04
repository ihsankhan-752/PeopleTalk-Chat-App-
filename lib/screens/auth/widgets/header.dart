import 'package:flutter/material.dart';

import '../../../utils/text_styles.dart';

class AuthHeader extends StatelessWidget {
  final String? title;
  const AuthHeader({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('images/logo.png'),
      )),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text("$title", textAlign: TextAlign.center, style: AppTextStyle().AUTH_HEADER),
        ),
      ),
    );
  }
}
