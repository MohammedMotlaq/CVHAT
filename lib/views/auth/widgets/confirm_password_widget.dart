import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/providers/otp_provider.dart';
import 'package:cvhat/providers/ui_provider.dart';
import 'package:cvhat/widgets/custom_back_button.dart';
import 'package:cvhat/widgets/custom_button.dart';
import 'package:cvhat/widgets/custom_text_field.dart';
import 'package:cvhat/widgets/loader_blur_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ConfirmPasswordWidget extends StatelessWidget {
  const ConfirmPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<UiProvider, OTPProvider>(
        builder: (context, uiProvider, otpProvider, child) {
      return Stack(
        children: [
          Container(
            color: AppColors.bgWhite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter your New Password:",
                  style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextField(
                  width: 309,
                  height: 50,
                  textInputAction: TextInputAction.next,
                  textEditingController: otpProvider.newPassword,
                  hintText: 'New Password',
                  inputType: TextInputType.visiblePassword,
                  obscure: true,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextField(
                  width: 309,
                  height: 50,
                  textInputAction: TextInputAction.done,
                  textEditingController: otpProvider.confirmNewPassword,
                  hintText: 'Confirm New Password',
                  inputType: TextInputType.visiblePassword,
                  obscure: true,
                ),
                SizedBox(
                  height: 82.h,
                ),
                Center(child: CustomBackButton(
                  onTap: () {
                    uiProvider.setAuthState(AuthState.otp);
                  },
                )),
                SizedBox(
                  height: 60.h,
                ),
                CustomButton(
                  height: 55,
                  width: 248,
                  title: 'Send',
                  onTap: () async {
                    await otpProvider.resetPassword();
                    if (otpProvider.nextStep) {
                      otpProvider.clearControllers();
                      uiProvider.setAuthState(AuthState.login);
                    }
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
          if (otpProvider.isLoading) const LoaderBlurScreen()
        ],
      );
    });
  }
}
