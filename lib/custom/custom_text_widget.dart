import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/local/color_storage.dart';

class CustomText extends Text {
  const CustomText({
    Key? key,
    required this.value,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 14,
    this.color = ColorStorage.black,
    this.align = TextAlign.start,
    this.lines
  }) : super(key: key, value);

  final String value;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  final TextAlign align;
  final int? lines;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: GoogleFonts.inter(fontWeight: fontWeight, fontSize: fontSize, color: color),
      textAlign: align,
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
    );
  }
}