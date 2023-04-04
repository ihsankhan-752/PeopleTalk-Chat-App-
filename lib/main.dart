import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:peopletalk/controllers/auth_controller.dart';
import 'package:peopletalk/controllers/image_pick_controller.dart';
import 'package:peopletalk/controllers/user_controller.dart';
import 'package:peopletalk/screens/auth/forgot_pass_screen.dart';
import 'package:peopletalk/screens/auth/login_screen.dart';
import 'package:peopletalk/screens/auth/sign_up_screen.dart';
import 'package:peopletalk/screens/dashboard/home/home_screen.dart';
import 'package:peopletalk/screens/splash.dart';
import 'package:provider/provider.dart';

import 'controllers/firestore_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => ImagePickingController()),
        ChangeNotifierProvider(create: (_) => UserController()),
        ChangeNotifierProvider(create: (_) => FireStoreController()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              appBarTheme: AppBarTheme(
            backgroundColor: Colors.deepOrange.withOpacity(0.2),
          )
              // scaffoldBackgroundColor: AppColors.PRIMARY_BLACK,
              ),
          home: SplashScreen(),
          builder: EasyLoading.init(),
          routes: {
            LoginScreen.routeName: (_) => LoginScreen(),
            SignUpScreen.routeName: (_) => SignUpScreen(),
            ForgotPassScreen.routeName: (_) => ForgotPassScreen(),
            HomeScreen.routeName: (_) => HomeScreen(),
          }),
    );
  }
}
