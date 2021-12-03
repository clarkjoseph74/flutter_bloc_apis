import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Txt extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight weight;
  final double size;
  final TextAlign textAlign;
  final int maxLine;
  // ignore: use_key_in_widget_constructors
  const Txt(this.text,
      {this.color = Colors.black,
      this.weight = FontWeight.normal,
      this.size = 20,
      this.textAlign = TextAlign.center,
      this.maxLine = 1});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      textAlign: textAlign,
      maxLines: maxLine,
      style: GoogleFonts.nunito(
        color: color,
        fontWeight: weight,
        fontSize: size,
      ),
    );
  }
}
