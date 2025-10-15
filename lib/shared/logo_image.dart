import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({super.key, this.color, this.height});

  final ColorFilter? color;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/logo/logo.svg',
      colorFilter: color,
      height: height,
    );
  }
}
