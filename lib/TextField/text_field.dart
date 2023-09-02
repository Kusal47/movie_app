import 'package:flutter/material.dart';
import '../const/export.dart';
class TextFields extends StatefulWidget {
  const TextFields({
    Key? key,
    required this.controller,
    required this.hinttext,
    this.isEmail = false,
    this.isPhone = false,
    this.isPassword = false,
    this.isFname = false,
    this.isLname = false,
    this.isConfirm = false,
    this.confirmPasswordController,
  }) : super(key: key);

  final TextEditingController controller;
  final TextEditingController? confirmPasswordController;
  final String hinttext;
  final bool isEmail;
  final bool isPhone;
  final bool isFname;
  final bool isLname;
  final bool isPassword;
  final bool isConfirm;
  void dispose() {
    controller.dispose();
  }

  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.isConfirm
            ? TextFormField(
                obscureText: isHidden ? false : true,
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
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: widget.hinttext,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isHidden = !isHidden;
                      });
                    },
                    icon: isHidden
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.remove_red_eye_outlined),
                  ),
                ),
              )
            : TextFormField(
                obscureText:
                    widget.isPassword || widget.isConfirm ? isHidden : false,
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
                  if (widget.isPassword) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.required_Password;
                    } else if (value.length < 8) {
                      return AppStrings.validate_Password;
                    }
                    return null;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  fillColor: Colors.grey[900],
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
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
                ),
              ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
