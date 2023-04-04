import 'package:flutter/material.dart';

import '../../utils/text_styles.dart';
import '../../widgets/buttons.dart';
import '../../widgets/text_input.dart';

class ForgotPassScreen extends StatelessWidget {
  static const routeName = '/forgot-pass';
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 80),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Image.asset('images/logo.png', fit: BoxFit.cover),
          ),
          Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text("Reset Your\nPassword", textAlign: TextAlign.center, style: AppTextStyle().BASIC_STYLE),
                  ),
                  SizedBox(height: 20),
                  AppTextInput(hint: 'email'),
                  SizedBox(height: 20),
                  PrimaryButton(onPressed: () {}, title: "Submit"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
