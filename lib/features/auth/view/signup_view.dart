import 'package:hungry/core/utils/exported_file.dart';

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

                            CustomAuthBtn(
                              color: AppColors.primaryColor,
                              textColor: Colors.white,
                              text: 'SignUp',
                              onPressed: () {
                                if (formKey.currentState!.validate()) {}
                              },
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
