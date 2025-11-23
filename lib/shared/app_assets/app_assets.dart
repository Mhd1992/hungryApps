import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppAsset extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final Color? color;

  const AppAsset({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isSvg = path.toLowerCase().endsWith('.svg');

    if (isSvg) {
      return SvgPicture.asset(
        path,
        width: width,
        height: height,
        colorFilter: (color != null)
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
      );
    }

    return Image.asset(
      path,
      width: width,
      height: height,
      color: color,
      fit: BoxFit.contain,
    );
  }
}
