import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  TextFields({
    Key? key,
    required this.controller,
    required this.hinttext,
    required this.isPassword,
    required this.isEmail,
    required this.isPhone,
  }) : super(key: key);

  final TextEditingController controller;
  final String hinttext;
  final bool isPassword;
  final bool isEmail;
  final bool isPhone;
  bool obscureText = true; // declare obscureText as a class variable

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(
            obscureText: isPassword
                ? obscureText
                : false, // use the obscureText variable to determine if the password field should be obscured
            controller: controller,
            keyboardType: isEmail
                ? TextInputType.emailAddress
                : isPhone
                    ? TextInputType.phone
                    : isPassword
                        ? TextInputType.visiblePassword
                        : TextInputType.text,
            validator: (value) {
              if (isEmail) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Email';
                } else if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                  return 'Please enter valid Email';
                }
                return null;
              }
              if (isPassword) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Password';
                } else if (value.length < 8) {
                  return 'Password must be atleast 8 character';
                }
                return null;
              }
              if (isPhone) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                if (value.length != 10 && value.length > 10) {
                  return 'Phone number is invalid';
                }

                return null;
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
              hintText: hinttext,
              suffixIcon:
                  isPassword // add suffixIcon only if isPassword is true
                      ? IconButton(
                          icon: Icon(
                            obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            // toggle the obscureText variable when the IconButton is pressed
                            obscureText = !obscureText;
                          },
                        )
                      : null,
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
