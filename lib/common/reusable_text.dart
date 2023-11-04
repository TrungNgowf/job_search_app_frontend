import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableText extends StatelessWidget{
  final String text;
  final TextStyle? style;

  const ReusableText(this.text, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: 1,
        softWrap: false,
        textAlign: TextAlign.left,
        overflow: TextOverflow.fade,
        style: style ?? appStyle(4, Colors.black, FontWeight.normal));
  }
}

TextStyle appStyle(double size, Color color, FontWeight fw) {
  return GoogleFonts.firaSans(fontSize: size.sp, color: color, fontWeight: fw);
}
