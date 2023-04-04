import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peopletalk/controllers/auth_controller.dart';
import 'package:peopletalk/controllers/image_pick_controller.dart';
import 'package:peopletalk/screens/auth/widgets/footer.dart';
import 'package:peopletalk/screens/auth/widgets/header.dart';
import 'package:peopletalk/widgets/navigations.dart';
import 'package:provider/provider.dart';

import '../../screens/auth/login_screen.dart';
import '../../screens/auth/widgets/positioned_widget_for_pic_uploading.dart';
import '../../utils/colors.dart';
import '../../widgets/buttons.dart';
import '../../widgets/text_input.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/sign-up';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  Future<void> signUp() async {
    await AuthController().signUp(
      context,
      emailController.text,
      passwordController.text,
      usernameController.text,
      bioController.text,
      contactController.text,
      Provider.of<ImagePickingController>(context, listen: false).selectedImage!,
    );
  }

  @override
  void dispose() {
    Provider.of<ImagePickingController>(context, listen: false).selectedImage!;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImagePickingController>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            AuthHeader(title: "Create Your Account"),
            SizedBox(height: 10),
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
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          imageProvider.selectedImage == null
                              ? CircleAvatar(
                                  radius: 35,
                                  child: Center(
                                    child: Icon(Icons.person),
                                  ),
                                  backgroundColor: AppColors.PRIMARY_GREY,
                                )
                              : CircleAvatar(
                                  radius: 35,
                                  backgroundColor: AppColors.PRIMARY_GREY,
                                  backgroundImage: FileImage(File(imageProvider.selectedImage!.path)),
                                ),
                          PositionedWidgetForPicUploading(
                            onPressed: () {
                              imageProvider.uploadImage(ImageSource.gallery);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    AppTextInput(controller: usernameController, hint: 'username'),
                    AppTextInput(controller: contactController, hint: 'contact', inputType: TextInputType.number),
                    AppTextInput(controller: emailController, hint: 'email'),
                    AppTextInput(
                      controller: passwordController,
                      hint: 'password',
                      isSuffixReq: true,
                    ),
                    AppTextInput(controller: bioController, hint: 'bio'),
                    SizedBox(height: 20),
                    PrimaryButton(
                        onPressed: () {
                          signUp();
                        },
                        title: 'SignUp'),
                    SizedBox(height: 10),
                    AuthFooter(
                      title: "Already have an Account?",
                      screenName: " Login",
                      onPressed: () {
                        navigateWithName(context, LoginScreen.routeName);
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
