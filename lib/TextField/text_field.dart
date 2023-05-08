import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  const TextFields({
    super.key, required this.controller, required this.hinttext, required this.isPassword, required this.isEmail, required this.isPhone,
  
  });

  final TextEditingController controller;
  final String hinttext;
  final bool isPassword;
  final bool isEmail, isPhone;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(
            obscureText: isPassword ? true : false,
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
