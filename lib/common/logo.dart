import '../common/export.dart';

class LogoText extends StatelessWidget {
  final String text;
  final double? size;

  const LogoText(this.text, {super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(text,
        maxLines: 1,
        softWrap: false,
        textAlign: TextAlign.center,
        overflow: TextOverflow.fade,
        style: TextStyle(
            fontFamily: GoogleFonts.getFont('Baumans').fontFamily,
            fontSize: size ?? 6.sp,
            color: iosDefaultIndigo,
            fontWeight: FontWeight.w600));
  }
}
