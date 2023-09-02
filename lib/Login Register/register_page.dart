import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Authentication/auth.dart';
import '../Buttons/button.dart';
import '../FontStyle/text_style.dart';
import '../TextField/text_field.dart';
import '../const/export.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController firstnameC = TextEditingController();
  TextEditingController lastnameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController passConfirm = TextEditingController();
  bool isChecked = false;

  final _formKey = GlobalKey<FormState>();
  // CollectionReference users = FirebaseFirestore.instance.collection(AppStrings.users);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: const Text(AppStrings.register),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(children: [
                TextFields(
                  controller: firstnameC,
                  hinttext:AppStrings.fName,
                  isFname: true,
                ),
                TextFields(
                  controller: lastnameC,
                  hinttext: AppStrings.lName,
                  isLname: true,
                ),
                TextFields(
                  controller: phoneC,
                  hinttext: AppStrings.phone,
                  isPhone: true,
                ),
                TextFields(
                  controller: emailC,
                  hinttext: AppStrings.email,
                  isEmail: true,
                ),
                TextFields(
                  controller: passC,
                  hinttext: AppStrings.password,
                  isPassword: true,
                ),
                TextFields(
                  controller: passConfirm,
                  hinttext: AppStrings.confirmPassword,
                  isPassword: true,
                  isConfirm: true,
                  confirmPasswordController: passC,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    const TextFont(text:AppStrings.TOC, size: 18, color: Colors.white),
                  ],
                ),
                Buttons(
                    btnname: AppStrings.registerbtn,
                    size: 20,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (isChecked == true) {
                          await AuthService().Register(emailC.text, passC.text);
                          await FirebaseFirestore.instance
                              .collection(AppStrings.users)
                              .add({
                            AppStrings.fName: firstnameC.text,
                            AppStrings.lName: lastnameC.text,
                            AppStrings.email: emailC.text,
                            AppStrings.phone: int.parse(phoneC.text),
                            AppStrings.password: passC.text.trim(),
                          });
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                          firstnameC.clear();
                          emailC.clear();
                          passC.clear();
                          passConfirm.clear();
                        }
                      }
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      AppStrings.hasAccount,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      child: Text(
                        AppStrings.loginNow,
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
                                builder: (context) => const LoginPage()));
                      },
                    ),
                  ],
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
