import 'package:flutter/material.dart';

import '../FontStyle/text_style.dart';

class Outlinebuttons extends StatelessWidget {
  const Outlinebuttons({super.key, this.text, this.price, this.movieName, this.onPressed});
  final String? text;
  final String? price;
  final String? movieName;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8, top: 8),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFont(
              text: text!,
            ),
            TextFont(
              text: price!,
            ),
          ],
        ),
      ),
    );
  }
}
