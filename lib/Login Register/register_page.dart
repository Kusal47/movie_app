import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Authentication/auth.dart';
import '../Buttons/button.dart';
import '../TextField/text_field.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController FirstnameC = TextEditingController();
  TextEditingController LastnameC = TextEditingController();
  TextEditingController PhoneC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController passConfirm = TextEditingController();
  bool? isChecked = false;

  final _formKey = GlobalKey<FormState>();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Register Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formKey,
            child: Column(children: [
              TextFields(
                controller: FirstnameC,
                hinttext: 'First Name',
                isPassword: false,
                isEmail: false,
                isPhone: false,
              ),
              TextFields(
                controller: LastnameC,
                hinttext: 'Last Name',
                isPassword: false,
                isEmail: false,
                isPhone: false,
              ),
              TextFields(
                controller: PhoneC,
                hinttext: 'Phone number',
                isPassword: false,
                isEmail: false,
                isPhone: true,
              ),
              TextFields(
                controller: emailC,
                hinttext: 'Email',
                isPassword: false,
                isEmail: true,
                isPhone: false,
              ),
              TextFields(
                controller: passC,
                hinttext: 'Password',
                isPassword: true,
                isEmail: false,
                isPhone: false,
              ),
              TextFormField(
                obscureText: true,
                controller: passConfirm,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Confirm your Password';
                  }
                  if (value != passC.text) {
                    return 'Password did not match';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Confirm Your Password',
                ),
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
                  Text('Terms and Conditions'),
                ],
              ),
              Buttons(
                  btnname: 'Register',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (isChecked == true) {
                        await AuthService().Register(emailC.text, passC.text);
                        await FirebaseFirestore.instance
                            .collection('users')
                            .add({
                          'First Name': FirstnameC.text,
                          'Last Name': LastnameC.text,
                          'Phone Number': int.parse(PhoneC.text),
                          'Email': emailC.text,
                        });
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                        FirstnameC.clear();
                        LastnameC.clear();
                        PhoneC.clear();
                        emailC.clear();
                        passC.clear();
                        passConfirm.clear();
                      }
                    }
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}
