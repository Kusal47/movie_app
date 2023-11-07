// ignore_for_file: use_build_context_synchronously

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
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(children: [
                TextFields(
                  text: AppStrings.fName,
                  controller: firstnameC,
                  hinttext: AppStrings.fNamehint,
                  isFname: true,
                ),
                TextFields(
                  text: AppStrings.lName,
                  controller: lastnameC,
                  hinttext: AppStrings.lNamehint,
                  isLname: true,
                ),
                TextFields(
                  text: AppStrings.phone,
                  controller: phoneC,
                  hinttext: AppStrings.phonehint,
                  isPhone: true,
                ),
                TextFields(
                  text: AppStrings.email,
                  controller: emailC,
                  hinttext: AppStrings.emailhint,
                  isEmail: true,
                ),
                TextFields(
                  text: AppStrings.password,
                  controller: passC,
                  hinttext: AppStrings.passwordhint,
                  isPassword: true,
                ),
                TextFields(
                  text: AppStrings.confirmPassword,
                  controller: passConfirm,
                  hinttext: AppStrings.confirmPasswordhint,
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
                    const TextFont(
                        text: AppStrings.TOC, size: 18, color: Colors.white),
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
