import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFont extends StatelessWidget {
  const TextFont({
    super.key,
    required this.text,
    this.size,
    this.color,
    this.overflow, this.fontweight,
  });
  final String text;
  final double? size;
  final Color? color;
  final TextOverflow? overflow;
  final FontWeight? fontweight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.breeSerif(
        fontSize: size,
        color: color,
      ),
      overflow: overflow,
    );
  }
}
