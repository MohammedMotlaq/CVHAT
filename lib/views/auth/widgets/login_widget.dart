import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/providers/auth_form_provider.dart';
import 'package:cvhat/providers/auth_provider.dart';
import 'package:cvhat/providers/ui_provider.dart';
import 'package:cvhat/widgets/custom_button.dart';
import 'package:cvhat/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<UiProvider, AuthFormProvider, AuthProvider>(
        builder: (context, uiProvider, authFormProvider, authProvider, child) {
      return Container(
        color: AppColors.bgWhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back",
              style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Sign in to continue to our app",
              style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 20.h),
            CustomTextField(
              width: 309,
              height: 50,
              textInputAction: TextInputAction.next,
              hintText: 'Email',
              inputType: TextInputType.emailAddress,
              textEditingController: authFormProvider.emailController,
            ),
            SizedBox(height: 20.h),
            CustomTextField(
              width: 309,
              height: 50,
              textInputAction: TextInputAction.done,
              hintText: 'Password',
              inputType: TextInputType.visiblePassword,
              obscure: authFormProvider.isPasswordObscure,
              textEditingController: authFormProvider.passwordController,
              suffixIcon: IconButton(
                  onPressed: () {
                    authFormProvider.togglePasswordVisibility();
                  },
                  icon: Icon(
                    authFormProvider.isPasswordObscure
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.secondary,
                  )),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Text("Forgot your password?",
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.normal)),
                TextButton(
                  onPressed: () async {
                    uiProvider.setAuthState(AuthState.forgetPassword);
                  },
                  child: Text(
                    "Reset here",
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.textAccent,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
            SizedBox(height: 93.h),
            CustomButton(
              height: 55,
              width: 248,
              title: 'Login',
              onTap: () {
                authProvider.login();
              },
            ),
            SizedBox(height: 20.h),
            Center(
              child: TextButton(
                onPressed: () {
                  uiProvider.setAuthState(AuthState.signup);
                  authFormProvider.clearControllers();
                },
                child: SizedBox(
                  width: 170.w,
                  height: 25.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Create new account",
                          style: TextStyle(
                              fontSize: 13.sp, color: AppColors.textSecondary)),
                      SizedBox(width: 5.w),
                      Icon(Icons.arrow_forward,
                          color: AppColors.textSecondary, size: 20.w),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
