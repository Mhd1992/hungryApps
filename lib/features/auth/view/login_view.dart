import 'package:hungry/core/utils/exported_file.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  AuthRepo authRepo = AuthRepo();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    emailController.text = 'Alhammali@gmail.com';
    passController.text = '123456789';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> login() async {
      if (formKey.currentState!.validate()) {
        try {
          setState(() => _isLoading = true);

          final user = await authRepo.login(
            emailController.text.trim(),
            passController.text.trim(),
          );
          if (user != null) {
            if (!context.mounted) return;
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => Root()));
          }
        } catch (e) {
          String errorMessage = 'unknown Error';
          if (e is ApiError) {
            errorMessage = e.message;
            if (!context.mounted) return;

            context.showSnackBar(errorMessage);
          }
        } finally {
          setState(() => _isLoading = false);
        }
      }
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Gap(150),
                    LogoImage(
                      color: ColorFilter.mode(
                        AppColors.primaryColor, // The color you want
                        BlendMode.modulate, // The blending mode
                      ),
                    ),
                    Gap(10),
                    CustomText(
                      text: 'Welcome back discover fast food',
                      color: Colors.grey.shade600,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    Gap(32),
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 30.0,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,

                          borderRadius: BorderRadius.circular(20),
                        ),

                        child: Column(
                          children: [
                            Gap(16),
                            CustomTextFormField(
                              controller: emailController,
                              hintText: 'Email Address',
                              isPassword: false,
                            ),
                            Gap(20),
                            CustomTextFormField(
                              controller: passController,
                              hintText: 'password',
                              isPassword: true,
                            ),

                            Gap(32),
                            _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : CustomAuthBtn(
                                    textColor: Colors.white,
                                    color: AppColors.primaryColor,
                                    text: 'Login',
                                    onPressed: login,
                                  ),
                            Gap(16),
                            CustomAuthBtn(
                              text: 'SignUp',
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => SignupView(),
                                  ),
                                );
                              },
                            ),
                            Gap(8),
                            TextButton(
                              onPressed: () {
                                authRepo.continueAsGuest();
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => Root(),
                                  ),
                                );
                              },
                              child: CustomText(
                                text: 'Continue as Guest',
                                color: Colors.orangeAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
