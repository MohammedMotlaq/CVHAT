import 'package:cvhat/app_router.dart';
import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/views/auth/widgets/forget_password_widget.dart';
import 'package:cvhat/views/auth/widgets/login_widget.dart';
import 'package:cvhat/views/auth/widgets/signup_widget.dart';
import 'package:cvhat/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/ui_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 75.h,
            ),
            const LogoWidget(width: 135, height: 142),
            SizedBox(
              height: 40.h,
            ),
            Container(
              width: 345.w,
              height: 540.h,
              padding: EdgeInsets.fromLTRB(18.w, 32.h, 18.w, 0),
              decoration: BoxDecoration(
                color: AppColors.bgWhite,
                borderRadius: BorderRadius.circular(14.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.bgBlack.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 3,
                    offset: const Offset(4, 4),
                  ),
                ],
              ),
              child: Consumer<UiProvider>(
                builder: (context, uiProvider, child) {
                  return AppRouter.animatedSwitcher(
                    _getAuthWidget(uiProvider.authState),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _getAuthWidget(AuthState state) {
  switch (state) {
    case AuthState.login:
      return const LoginWidget();
    case AuthState.signup:
      return const SignupWidget();
    case AuthState.forgetPassword:
      return const ForgetPasswordWidget();
  // case AuthState.otp:
  //   return const OtpWidget();
  // case AuthState.confirmPassword:
  //   return const ConfirmPasswordWidget();
    default:
      return const LoginWidget();
  }
}

