import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class textWidget extends StatelessWidget {
  textWidget(
    String this.text, {
    Key? key,
  }) : super(key: key);
  String? text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: TextAlign.center,
      style: GoogleFonts.lora(
          textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      )),
    );
  }
}
