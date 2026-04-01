import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/utils/exported_file.dart';
import 'package:hungry/features/auth/data/repository/v1/auth_repo_v1.dart';
import 'package:hungry/update_features/auth/controller/auth_controller.dart'
    show guestProvider, authControllerProvider;

class SignupView extends ConsumerStatefulWidget {
  const SignupView({super.key});

  @override
  ConsumerState<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends ConsumerState<SignupView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                            Consumer(
                              builder: (context, ref, _) {
                                final control = ref.watch(
                                  authControllerProvider,
                                );
                                final isLoading = control.isLoading;
                                return isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : CustomAuthBtn(
                                        textColor: Colors.white,
                                        color: AppColors.primaryColor,
                                        text: 'SignUp',
                                        onPressed: () {
                                          ref
                                              .read(
                                                authControllerProvider.notifier,
                                              )
                                              .register(
                                                nameController.text,
                                                emailController.text,
                                                passController.text,

                                                onSuccess: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Root(),
                                                    ),
                                                  );
                                                },
                                              );
                                        },
                                      );
                              },
                            ),
                            Gap(16),
                            CustomAuthBtn(
                              text: 'Login',
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => LoginView(),
                                  ),
                                );
                              },
                            ),
                            Gap(8),
                            TextButton(
                              onPressed: () {
                                ref
                                    .read(authControllerProvider.notifier)
                                    .continueAsGuest(
                                      () =>
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) => Root(),
                                            ),
                                          ),
                                    );
                                // authRepo.continueAsGuest();
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
