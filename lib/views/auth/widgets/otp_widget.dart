import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/providers/ui_provider.dart';
import 'package:cvhat/widgets/custom_back_button.dart';
import 'package:cvhat/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'custom_otp_textfield.dart';

class OtpWidget extends StatelessWidget {
  const OtpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    TextEditingController controller1 = TextEditingController();
    TextEditingController controller2 = TextEditingController();
    TextEditingController controller3 = TextEditingController();
    return Consumer<UiProvider>(builder: (context, uiProvider, child) {
      return Container(
        color: AppColors.bgWhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Verification Code:",
              style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomOtpTextField(
                  textInputAction: TextInputAction.next,
                  textEditingController: controller,
                ),
                CustomOtpTextField(
                  textInputAction: TextInputAction.next,
                  textEditingController: controller1,
                ),
                CustomOtpTextField(
                  textInputAction: TextInputAction.next,
                  textEditingController: controller2,
                ),
                CustomOtpTextField(
                  textInputAction: TextInputAction.next,
                  textEditingController: controller3,
                ),
              ],
            ),
            SizedBox(
              height: 33.h,
            ),
            Row(
              children: [
                Text("Didn’t Receive Code?",
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.normal)),
                SizedBox(width: 3.w),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Resend",
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.textAccent,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 82.h,
            ),
            Center(child: CustomBackButton(
              onTap: () {
                uiProvider.setAuthState(AuthState.forgetPassword);
              },
            )),
            SizedBox(
              height: 60.h,
            ),
            CustomButton(
              height: 55,
              width: 248,
              title: 'Confirm',
              onTap: () {
                uiProvider.setAuthState(AuthState.confirmPassword);
              },
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      );
    });
  }
}
