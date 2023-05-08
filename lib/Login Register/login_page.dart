import 'package:flutter/material.dart';

import '../Authentication/auth.dart';
import '../Buttons/button.dart';
import '../Home Page/home.dart';
import '../TextField/text_field.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFields(
                  controller: emailController,
                  isPassword: false,
                  hinttext: 'Email',
                  isEmail: true,
                  isPhone: false,
                ),
                TextFields(
                  controller: passController,
                  isPassword: true,
                  hinttext: 'Password',
                  isEmail: false,
                  isPhone: false,
                ),
                Buttons(
                    btnname: 'Login',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await AuthService()
                            .Login(emailController.text, passController.text);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      }
                      emailController.clear();
                      passController.clear();
                    }),
                SizedBox(height: 30),
                InkWell(
                  child: Text(
                    'Register Now',
                    style: TextStyle(
                        color: Colors.blue[900], fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
