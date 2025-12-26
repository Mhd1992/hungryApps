import 'package:hungry/core/data/repositories/auth/auth_provider.dart';
import 'package:hungry/core/utils/exported_file.dart';

import '../data/repository/v1/auth_repo_v1.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  AuthRepo authRepo = AuthRepo();
  AuthRepoV1 authRepoV1 = AuthRepoV1();
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
    final userController = ref.watch(authControllerProvider.notifier);
    Future<void> login() async {
      if (formKey.currentState!.validate()) {
        try {
          userController
              .handleData(
                () => ref.read(authProvider).loginUser({
                  'email': emailController.text.trim(),
                  'password': passController.text.trim(),
                }, ref: ref),
              )
              .then((val) {
                if (userController.repo.cachedData != null) {
                  //      PrefHelper.saveToken(userController.repo.cachedData!.token!);
                  if (!context.mounted) return;
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => Root()));
                }
              });
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
                                ref
                                    .read(authProvider)
                                    .continueAsGuest(ref: ref);
                                // authRepo.continueAsGuest();
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
