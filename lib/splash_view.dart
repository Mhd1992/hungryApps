import 'package:hungry/core/utils/exported_file.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,

      body: Column(
        children: [
          Gap(250),
          SvgPicture.asset('assets/logo/logo.svg'),
          Spacer(),
          Image.asset('assets/splash/hungry.png'),
        ],
      ),
    );
  }
}
