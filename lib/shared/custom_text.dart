import 'package:hungry/core/utils/exported_file.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
  });

  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaler: TextScaler.linear(1.0),
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize ?? 16,
        color: color,
      ),
    );
  }
}
