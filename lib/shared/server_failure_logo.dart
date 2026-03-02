import 'package:hungry/core/utils/exported_file.dart';

class ServerFailureLogo extends StatelessWidget {
  const ServerFailureLogo({super.key, this.color, this.height});

  final ColorFilter? color;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        SvgPicture.asset(
          'assets/images/server.svg',
          colorFilter: color,
          height: height,
        ),
        CustomText(
          text: 'Internal Server Error',
          color: AppColors.primaryColor,
          fontSize: 24,
        ),
      ],
    );
  }
}
