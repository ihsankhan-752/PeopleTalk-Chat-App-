import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:peopletalk/screens/auth/login_screen.dart';
import 'package:peopletalk/screens/dashboard/home/home_screen.dart';

import '../widgets/navigations.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var auth=FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
     if(auth==null){
       navigateWithName(context, LoginScreen.routeName);
     }else{
       navigateWithPush(context, HomeScreen());
     }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Image.asset('images/logo.png'),
            ),
          ),
          SizedBox(height: 20),
          SpinKitSpinningLines(color: Colors.orange),
        ],
      ),
    );
  }
}
