import 'package:hungry/core/utils/exported_file.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.overflow,
  });

  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaler: TextScaler.linear(1.0),
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize ?? 14,
        color: color,
        overflow: overflow,
      ),
    );
  }
}
