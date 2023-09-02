import 'package:flutter/material.dart';

import '../Authentication/auth.dart';


class LoginViewModel extends ChangeNotifier {
  late String email;
  late String password;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  void setEmail(String value) {
    email = value;
    emailController.text = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    passController.text = value;
    notifyListeners();
  }

  Future<bool> performLogin() async {
    await AuthService().Login(emailController.text, passController.text);

    emailController.clear();
    passController.clear();

    return true;
  }
}
