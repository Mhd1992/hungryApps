import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/auth/view/login_view.dart';
import 'package:hungry/features/auth/widgets/custom_auth_btn.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:hungry/shared/custom_text_form_field.dart';
import 'package:hungry/shared/logo_image.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    TextEditingController confirmPassController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return GestureDetector(
      // onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Form(
            key: formKey,
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
                Gap(150),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 30.0,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),

                    child: SingleChildScrollView(
                      child: Column(
                        children: [
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
                          Gap(50),

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
    );
  }
}
