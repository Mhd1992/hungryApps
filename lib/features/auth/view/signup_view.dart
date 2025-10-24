import 'package:hungry/core/utils/exported_file.dart';
import 'package:hungry/features/auth/data/repository/auth_repo.dart';
import 'package:hungry/shared/extensions/context_extension.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  AuthRepo authRepo = AuthRepo();

  @override
  Widget build(BuildContext context) {
    Future<void> signUp() async {
      if (formKey.currentState!.validate()) {
        try {
          setState(() => _isLoading = true);

          final user = await authRepo.signUp(
            nameController.text.trim(),
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

            ///extensions method for context
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
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Gap(100),
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
                    Gap(50),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 30.0,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Gap(16),
                            CustomTextFormField(
                              controller: nameController,
                              hintText: 'Name',
                              isPassword: false,
                            ),
                            Gap(20),
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
                                ? CircularProgressIndicator(color: Colors.white)
                                : CustomAuthBtn(
                                    color: AppColors.primaryColor,
                                    textColor: Colors.white,
                                    text: 'SignUp',
                                    onPressed: signUp,
                                  ),
                            Gap(16),
                            CustomAuthBtn(
                              text: 'Login',
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => LoginView(),
                                  ),
                                );
                              },
                            ),
                            Gap(8),
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
