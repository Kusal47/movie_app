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
  bool isHidden = false;

  final _formKey = GlobalKey<FormState>();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text('Register Page'),
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
                  controller: FirstnameC,
                  hinttext: 'First Name',
                  isFname: true,
                  isLname: false,
                  isPhone: false,
                  isEmail: false,
                  isPassword: false,
                ),
                TextFields(
                  controller: LastnameC,
                  hinttext: 'Last Name',
                  isFname: false,
                  isLname: true,
                  isPhone: false,
                  isEmail: false,
                  isPassword: false,
                ),
                TextFields(
                  controller: PhoneC,
                  hinttext: 'Phone number',
                  isFname: false,
                  isLname: false,
                  isPhone: true,
                  isEmail: false,
                  isPassword: false,
                ),
                TextFields(
                  controller: emailC,
                  hinttext: 'Email',
                  isFname: false,
                  isLname: false,
                  isPhone: false,
                  isEmail: true,
                  isPassword: false,
       
                ),
                TextFields(
                  controller: passC,
                  hinttext: 'Password',
                  isFname: false,
                  isLname: false,
                  isPhone: false,
                  isEmail: false,
                  isPassword: true,
                  
                ),
              
                TextFormField(
                  obscureText: isHidden ? false : true,
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
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isHidden = !isHidden;
                        });
                      },
                      icon: isHidden
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    ),
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
                    size: 20,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (isChecked == true) {
                          await AuthService().Register(emailC.text, passC.text);
                          await FirebaseFirestore.instance
                              .collection('users')
                              .add({
                            'First Name': FirstnameC.text,
                            'Last Name': LastnameC.text,
                            'Email': emailC.text,
                            'Phone Number': int.parse(PhoneC.text),
                            'Password': passC.text.trim(),

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
      ),
    );
  }
}
