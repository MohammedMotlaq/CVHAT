import 'package:cvhat/providers/ui_provider.dart';
import 'package:cvhat/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/app_colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Consumer<UiProvider>(builder: (context, uiProvider, child) {
      return Container(
        color: AppColors.bgWhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter your Email to Reset your Password:",
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
              textInputAction: TextInputAction.done,
              textEditingController: controller,
              hintText: 'Email',
              inputType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 33.h,
            ),
            Text(
              "*Check your Email for the Code.",
              style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: 82.h,
            ),
            Center(child: CustomBackButton(
              onTap: () {
                uiProvider.setAuthState(AuthState.login);
              },
            )),
            SizedBox(
              height: 60.h,
            ),
            CustomButton(
              height: 55,
              width: 248,
              title: 'Send',
              onTap: () {
                uiProvider.setAuthState(AuthState.otp);
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
