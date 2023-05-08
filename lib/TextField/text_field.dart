import 'package:flutter/material.dart';

class TextFields extends StatefulWidget {
  const TextFields({
    super.key,
    required this.controller,
    required this.hinttext,
    required this.isPassword,
    required this.isEmail,
    required this.isPhone,
  });

  final TextEditingController controller;
  final String hinttext;
  final bool isPassword;
  final bool isEmail, isPhone;

  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  bool passVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(
            obscureText: widget.isPassword ? passVisible : false,
            controller: widget.controller,
            keyboardType: widget.isEmail
                ? TextInputType.emailAddress
                : widget.isPhone
                    ? TextInputType.phone
                    : widget.isPassword
                        ? TextInputType.visiblePassword
                        : TextInputType.text,
            validator: (value) {
              if (widget.isEmail) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Email';
                } else if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                  return 'Please enter valid Email';
                }
                return null;
              }
              if (widget.isPassword) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Password';
                } else if (value.length < 8) {
                  return 'Password must be atleast 8 character';
                }
                return null;
              }
              if (widget.isPhone) {
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
              suffixIcon: IconButton(
                icon: Icon(
                  passVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    passVisible = passVisible;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: widget.hinttext,
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
