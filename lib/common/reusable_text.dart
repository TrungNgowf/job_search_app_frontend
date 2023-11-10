import '../common/export.dart';

class ReusableText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const ReusableText(this.text, {super.key, this.style, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(text,
        softWrap: false,
        textAlign: textAlign ?? TextAlign.left,
        overflow: TextOverflow.fade,
        style: style ??
            appStyle(size: 4, color: Colors.black, fw: FontWeight.normal));
  }
}

TextStyle appStyle({double? size, Color? color, FontWeight? fw}) {
  return GoogleFonts.montserrat(
      fontSize: size == null ? 4.sp : size.sp,
      color: color ?? Colors.black,
      fontWeight: fw ?? FontWeight.normal);
}
