import 'package:hungry/core/utils/exported_file.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
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
                            onPressed: () {
                              if (formKey.currentState!.validate()) {}
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
                                MaterialPageRoute(builder: (context) => Root()),
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
    );
  }
}
