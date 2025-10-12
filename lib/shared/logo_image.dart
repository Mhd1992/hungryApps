import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/logo/logo.svg');
  }
}
