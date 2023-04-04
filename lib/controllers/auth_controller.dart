import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:peopletalk/screens/auth/login_screen.dart';
import 'package:peopletalk/screens/dashboard/home/home_screen.dart';
import 'package:peopletalk/utils/show_custom_message.dart';
import 'package:peopletalk/widgets/navigations.dart';

import '../models/user_model.dart';
import '../services/storage_sevices.dart';
import '../utils/constants.dart';

class AuthController extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  setLoading(newValue) {
    _isLoading = newValue;
    notifyListeners();
  }

  Future<UserModel> getUserDetail() async {
    User currentUser = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection("users").doc(currentUser.uid).get();
    return UserModel.fromDocument(snap);
  }

  signUp(BuildContext context, String email, String pass, String username, String bio, var contactNum, File image) async {
    EasyLoading.show(status: 'Please Wait');
    if (email.isEmpty || pass.isEmpty || username.isEmpty || bio.isEmpty || contactNum.toString().isEmpty || image.path.isEmpty) {
      EasyLoading.dismiss();
      showCustomMessage(context, 'Some Filled are Missing');
    } else {
      try {
        String imageUrl = await StorageServices().uploadImageToStorage(context, image);
        await auth.createUserWithEmailAndPassword(email: email, password: pass);
        await fireStore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
          'uid': FirebaseAuth.instance.currentUser!.uid,
          'username': username,
          'email': email,
          'bio': bio,
          'contact': contactNum,
          'image': imageUrl,
          "invitations": [],
          'blockUsers': [],
          'friendsList': [],
        });
        EasyLoading.dismiss();
        navigateWithPush(context, HomeScreen());
      } catch (e) {
        EasyLoading.dismiss();
      }
    }
  }

  signIn(BuildContext context, String email, String pass) async {
    if (email.isNotEmpty && pass.isNotEmpty) {
      EasyLoading.show(status: 'Please Wait');
      try {
        await auth.signInWithEmailAndPassword(email: email, password: pass);
        EasyLoading.dismiss();
        navigateWithPush(context, HomeScreen());
      } catch (e) {
        EasyLoading.dismiss();
        showCustomMessage(context, e.toString());
      }
    } else {
      EasyLoading.dismiss();
      showCustomMessage(context, "Please Fill the Missing Field");
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginScreen()));
      // navigateWithName(context, LoginScreen.routeName);
    } catch (e) {
      print(e);
    }
  }
}
