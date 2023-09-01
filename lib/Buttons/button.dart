import 'package:flutter/material.dart';

import '../FontStyle/text_style.dart';

// import '../Display Page/home_page.dart';

class Buttons extends StatelessWidget {
  const Buttons(
      {super.key,
      this.btnname,
      this.onPressed,
      this.size,
      this.isDetail = false, this.color});
  final String? btnname;
  final double? size;
  final void Function()? onPressed;
  final bool isDetail;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return isDetail
        ? ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
                elevation: 20,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  side: BorderSide(
                    width: 1,
                    color: Colors.white,
                  )
                )),
            child: TextFont(
              text: btnname!,
              size: size,
            ),
          )
        : OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: onPressed,
            child: Text(btnname!,
                style: TextStyle(
                  fontSize: size,
                  color: Colors.white,
                )),
          );
  }
}
