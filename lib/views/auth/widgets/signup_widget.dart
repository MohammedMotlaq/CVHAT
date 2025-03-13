import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/providers/auth_form_provider.dart';
import 'package:cvhat/providers/auth_provider.dart';
import 'package:cvhat/providers/ui_provider.dart';
import 'package:cvhat/widgets/custom_button.dart';
import 'package:cvhat/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignupWidget extends StatelessWidget {
  const SignupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<AuthFormProvider, UiProvider, AuthProvider>(
      builder: (context, authFormProvider, uiProvider, authProvider, child) {
        return Container(
          color: AppColors.bgWhite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome",
                style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Sign up to continue to our app",
                style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 20.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextField(
                    width: 145,
                    height: 50,
                    textInputAction: TextInputAction.next,
                    textEditingController: authFormProvider.firstNameController,
                    hintText: 'First Name',
                    inputType: TextInputType.text,
                  ),
                  CustomTextField(
                    width: 145,
                    height: 50,
                    textInputAction: TextInputAction.next,
                    textEditingController: authFormProvider.lastNameController,
                    hintText: 'Last Name',
                    inputType: TextInputType.text,
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              /// Email Field
              CustomTextField(
                width: 309,
                height: 50,
                textInputAction: TextInputAction.next,
                textEditingController: authFormProvider.emailController,
                hintText: 'Email',
                inputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20.h),

              /// Password Field
              CustomTextField(
                width: 309,
                height: 50,
                textInputAction: TextInputAction.next,
                textEditingController: authFormProvider.passwordController,
                hintText: 'Password',
                inputType: TextInputType.visiblePassword,
                obscure: authFormProvider.isPasswordObscure,
                suffixIcon: IconButton(
                  icon: Icon(authFormProvider.isPasswordObscure
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: authFormProvider.togglePasswordVisibility,
                ),
              ),
              SizedBox(height: 20.h),

              /// Confirm Password Field
              CustomTextField(
                width: 309,
                height: 50,
                textInputAction: TextInputAction.done,
                textEditingController:
                    authFormProvider.confirmPasswordController,
                hintText: 'Confirm Password',
                inputType: TextInputType.visiblePassword,
                obscure: authFormProvider.isConfirmPasswordObscure,
                suffixIcon: IconButton(
                  icon: Icon(authFormProvider.isConfirmPasswordObscure
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: authFormProvider.toggleConfirmPasswordVisibility,
                ),
              ),
              SizedBox(height: 20.h),

              CustomButton(
                height: 55,
                width: 248,
                title: 'Signup',
                onTap: () async {
                  if (await authProvider.signUp()) {
                    uiProvider.setAuthState(AuthState.login);
                  }
                },
              ),
              SizedBox(height: 20.h),

              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size(70.w, 12.h),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    authFormProvider.clearControllers();
                    uiProvider.setAuthState(AuthState.login);
                  },
                  child: SizedBox(
                    width: 144.w,
                    height: 25.h,
                    child: Row(
                      children: [
                        Text(
                          "I have an Account",
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(width: 5.w),
                        Icon(
                          Icons.arrow_forward,
                          color: AppColors.textSecondary,
                          size: 20.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
