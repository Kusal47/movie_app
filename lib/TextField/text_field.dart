import 'package:flutter/material.dart';
import '../FontStyle/text_style.dart';
import '../const/export.dart';

class TextFields extends StatefulWidget {
  const TextFields({
    Key? key,
    required this.controller,
    required this.hinttext,
    this.isEmail = false,
    this.isPassword = false,
    this.isUsername = false,
    this.isConfirm = false,
    this.confirmPasswordController,
    required this.text,
    this.isPhone = false,
    this.isFname = false,
    this.isLname = false, this.isLoginPassword=false,
  }) : super(key: key);

  final TextEditingController controller;
  final TextEditingController? confirmPasswordController;
  final String text;
  final String hinttext;
  final bool isEmail;
  final bool isUsername;
  final bool isPassword;
  final bool isLoginPassword;
  final bool isConfirm;
  final bool isPhone;
  final bool isFname;
  final bool isLname;
  void dispose() {
    controller.dispose();
  }

  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  bool isHidden = true;

  bool hasUppercaseLetter(String password) {
    final pattern = RegExp(r'[A-Z]');
    return pattern.hasMatch(password);
  }

  bool hasLowercaseLetter(String password) {
    final pattern = RegExp(r'[a-z]');
    return pattern.hasMatch(password);
  }

  bool hasDigit(String password) {
    final pattern = RegExp(r'[0-9]');
    return pattern.hasMatch(password);
  }

  bool hasSpecialCharacter(String password) {
    final pattern = RegExp(r'[!@#\$%^&*()_+{}|~<>,.?/:;[\]-]');
    return pattern.hasMatch(password);
  }

  bool hasValidLength(String password) {
    return password.length >= 8 && password.length <= 15;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TextFont(
              text: widget.text,
              fontweight: FontWeight.bold,
            )
          ],
        ),
        widget.isConfirm
            ? TextFormField(
                obscureText: widget.isConfirm ? isHidden : false,
                controller: widget.controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.required_ConfirmPass;
                  }
                  if (value != widget.confirmPasswordController!.text) {
                    return AppStrings.validate_ConfirmPass;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[900],
                  hintText: widget.hinttext,
                  suffixIcon: widget.isPassword || widget.isConfirm
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              isHidden = !isHidden;
                            });
                          },
                          icon: isHidden
                              ? const Icon(Icons.remove_red_eye_outlined)
                              : const Icon(Icons.visibility_off))
                      : null,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            : TextFormField(
                obscureText: widget.isPassword ? isHidden : false,
                controller: widget.controller,
                keyboardType: widget.isEmail
                    ? TextInputType.emailAddress
                    : widget.isPhone
                        ? TextInputType.phone
                        : TextInputType.text,
                validator: (value) {
                  if (widget.isFname) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.required_firstName;
                    }
                    return null;
                  }
                  if (widget.isLname) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.required_lastName;
                    }
                    return null;
                  }
                  if (widget.isPhone) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.required_phone;
                    }
                    if (value.length != 10 && value.length > 10) {
                      return AppStrings.validate_phone;
                    }
                    return null;
                  }
                  if (widget.isEmail) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.required_email;
                    } else if (!RegExp(AppStrings.regExp).hasMatch(value)) {
                      return AppStrings.validate_email;
                    }
                    return null;
                  }
                  if(widget.isLoginPassword){
                         if (value == null || value.isEmpty) {
                      return AppStrings.required_Password;
                    }else if (!hasValidLength(value)) {
                      return AppStrings.validate_Password_Length;
                    }
                    return null;
                  }
                  if (widget.isPassword) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.required_Password;
                    } else if (!hasUppercaseLetter(value)) {
                      return AppStrings.validate_Password_Uppercase;
                    } else if (!hasLowercaseLetter(value)) {
                      return AppStrings.validate_Password_Lowercase;
                    } else if (!hasDigit(value)) {
                      return AppStrings.validate_Password_Number;
                    } else if (!hasSpecialCharacter(value)) {
                      return AppStrings.validate_Password_SpecialCharacter;
                    } else if (!hasValidLength(value)) {
                      return AppStrings.validate_Password_Length;
                    }
                    return null;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  hintText: widget.hinttext,
                  suffixIcon: widget.isPassword 
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              isHidden = !isHidden;
                            });
                          },
                          icon: isHidden
                              ? const Icon(Icons.remove_red_eye_outlined)
                              : const Icon(Icons.visibility_off))
                      : null,
                ),
              ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
