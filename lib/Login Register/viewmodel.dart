// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';

import '../Authentication/auth.dart';
import '../Home Page/home.dart';

class LoginViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
    try {
      await AuthService().Login(emailController.text, passController.text);

      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
      emailController.clear();
      passController.clear();
    } catch (e) {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text("Login Error"),
              content: const Text(
                  'Something went wrong!!. Please check your email and password'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
      emailController.clear();
      passController.clear();
      print('$e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }
}
