import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

class ModifiedText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight weight;
  const ModifiedText(
      {Key? key,
      required this.text,
      required this.color,
      required this.size,
      required this.weight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.lato(
          color: color,
          fontSize: size,
          fontWeight: weight,
        ));
  }
}
