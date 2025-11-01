import 'package:hungry/core/utils/exported_file.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  double _opacity = 0.0;
  final AuthRepo authRepo = AuthRepo();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _opacity = 1.0);
    });

    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2)); // short delay for splash

    // 🟢 Call autoLogin first
    await authRepo.autoLogin();

    if (!mounted) return;

    // 🟢 Now decide which screen to go to
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => authRepo.isLoggedIn ? Root() : LoginView(),
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          const Gap(250),
          AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            child: SvgPicture.asset('assets/logo/logo.svg'),
          ),
          const Spacer(),
          AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeInOut,
            child: Image.asset('assets/splash/hungry.png'),
          ),
        ],
      ),
    );
  }
}
