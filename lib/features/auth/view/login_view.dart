import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:hungry/shared/custom_text_form_field.dart';
import 'package:hungry/shared/logo_image.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
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
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ///this block will executed only if filling  all fields
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                        double.infinity,
                        48,
                      ), // Make the button full width
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.white, // Background color
                      elevation: 0, // No shadow
                    ),
                    child: Center(
                      child: CustomText(
                        text: 'Login',
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  /*
                  above is equavelent to below
                   GestureDetector(
              child: Container(
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              ),
              child: Center(
              child: CustomText(
              text: 'Login',
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w800,
              fontSize: 16,
              ),
              ),
              ),
              ),
                  *
                  * */
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
