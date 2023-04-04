import 'package:flutter/material.dart';
import 'package:peopletalk/controllers/auth_controller.dart';
import 'package:peopletalk/screens/auth/sign_up_screen.dart';
import 'package:peopletalk/screens/auth/widgets/footer.dart';
import 'package:peopletalk/screens/auth/widgets/header.dart';
import 'package:peopletalk/widgets/buttons.dart';
import 'package:peopletalk/widgets/navigations.dart';
import 'package:provider/provider.dart';

import '../../utils/text_styles.dart';
import '../../widgets/text_input.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signIn() async {
    await AuthController().signIn(context, emailController.text, passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthController>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            AuthHeader(title: "Login To Your Account"),
            SizedBox(height: 20),
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
                    SizedBox(height: 20),
                    AppTextInput(controller: emailController, hint: 'email'),
                    SizedBox(height: 10),
                    AppTextInput(
                      controller: passwordController,
                      hint: 'password',
                      isSuffixReq: true,
                      isSecureText: true,
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {},
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text("Forgot Password?"),
                      ),
                    ),
                    SizedBox(height: 20),
                    provider.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : PrimaryButton(
                            onPressed: () async {
                              await provider.signIn(context, emailController.text, passwordController.text);
                              emailController.clear();
                              passwordController.clear();
                            },
                            title: "Login"),
                    SizedBox(height: 20),
                    Center(child: Text("Or", style: AppTextStyle().BASIC_STYLE.copyWith(fontSize: 14))),
                    SizedBox(height: 10),
                    AuthFooter(
                      title: "Don't have an Account?",
                      screenName: " SignUp",
                      onPressed: () {
                        navigateWithName(context, SignUpScreen.routeName);
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
