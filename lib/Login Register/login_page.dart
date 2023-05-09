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
      backgroundColor: Colors.grey[800],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
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
                  isFname: false,
                  isLname: false,
                  
                ),
                TextFields(
                  controller: passController,
                  isPassword: true,
                  hinttext: 'Password',
                  isEmail: false,
                  isPhone: false,
                  isFname: false,
                  isLname: false,
                ),
                Buttons(
                    btnname: 'Login',
                    size: 20,
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
                SizedBox(height: 20),
               
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    SizedBox(width: 5),
                    InkWell(
                      child: Text(
                        'Register Now',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue[200],
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
       
        ),
      ),
    );
  }
}
