import 'package:flutter/material.dart';

// import '../Display Page/home_page.dart';

class Buttons extends StatelessWidget {
  const Buttons({super.key, this.btnname, this.onPressed});
  final String? btnname;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
       child: Text(btnname!));
  }
}
