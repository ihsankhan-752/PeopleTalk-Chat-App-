import 'package:flutter/cupertino.dart';
import 'package:peopletalk/controllers/auth_controller.dart';
import 'package:peopletalk/models/user_model.dart';

class UserController extends ChangeNotifier {
  UserModel? _user;
  UserModel get user => _user!;

  final AuthController authController = AuthController();
  Future<void> refreshUser() async {
    UserModel user = await authController.getUserDetail();
    _user = user;
    notifyListeners();
  }
}
