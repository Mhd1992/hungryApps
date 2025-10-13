import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/auth/widgets/custom_auth_btn.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:hungry/shared/custom_text_form_field.dart';
import 'package:hungry/shared/logo_image.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    TextEditingController confirmPassController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Gap(200),
                  LogoImage(),
                  Gap(10),
                  CustomText(
                    text: 'Welcome back discover fast food',
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  Gap(50),
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
                  Gap(20),
                  CustomTextFormField(
                    controller: confirmPassController,
                    hintText: 'confirm Password',
                    isPassword: true,
                  ),
                  Gap(50),
                  CustomAuthBtn(
                    text: 'SignUp',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {}
                    },
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
