import 'package:hungry/core/networks/api_error.dart';
import 'package:hungry/core/utils/exported_file.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  AuthRepo authRepo = AuthRepo();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    Future<void> login() async {
      try {
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

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(errorMessage)));
        }
      }
    }

    return GestureDetector(
      // onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Gap(250),
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
                  Gap(75),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 30.0,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,

                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            Gap(30),
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

                            Gap(50),
                            CustomAuthBtn(
                              textColor: Colors.white,
                              color: AppColors.primaryColor,
                              text: 'Login',
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  login();
                                }
                              },
                            ),
                            Gap(16),
                            CustomAuthBtn(
                              text: 'SignUp',
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SignupView(),
                                  ),
                                );
                              },
                            ),
                            Gap(50),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showError(BuildContext context, String? message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message.toString())));
  }
}
