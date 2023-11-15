import 'package:job_search_app_frontend/common/export.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final double? height;
  final double? width;
  final Color? backGroundColor;

  const CustomButton(
      {super.key,
      this.text,
      this.child,
      this.height,
      this.width,
      this.backGroundColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Card(
      elevation: 3,
      child: Container(
        padding: EdgeInsets.all(2.5.w),
        decoration: BoxDecoration(
            color: backGroundColor ?? Colors.white,
            borderRadius: BorderRadius.circular(5)),
        child: child ??
            ReusableText(
              text ?? "",
              style: appStyle(fw: FontWeight.w500),
            ),
      ),
    ));
  }
}
