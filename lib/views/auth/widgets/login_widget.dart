import 'package:cvhat/app_router.dart';
import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/providers/ui_provider.dart';
import 'package:cvhat/views/home_screen/home_page.dart';
import 'package:cvhat/widgets/custom_button.dart';
import 'package:cvhat/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          SizedBox(
            height: 20.h,
          ),
          CustomTextField(
            width: 309,
            height: 50,
            textInputAction: TextInputAction.next,
            textEditingController: controller,
            hintText: 'Email',
            inputType: TextInputType.emailAddress,
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomTextField(
            width: 309,
            height: 50,
            textInputAction: TextInputAction.done,
            textEditingController: controller1,
            hintText: 'Password',
            inputType: TextInputType.visiblePassword,
            obscure: true,
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Text(
                "Forgot your password?",
                style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(
                width: 3.w,
              ),
              Consumer<UiProvider>(builder: (context, uiProvider, child) {
                return TextButton(
                    style: TextButton.styleFrom(
                        minimumSize: Size(70.w, 12.h),
                        padding: EdgeInsets.zero),
                    onPressed: () {
                      uiProvider.resetPasswordChange();
                    },
                    child: Text(
                      "Reset here",
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.textAccent,
                          fontWeight: FontWeight.normal),
                    ));
              }),
            ],
          ),
          SizedBox(
            height: 93.h,
          ),
          CustomButton(
            height: 55,
            width: 248,
            title: 'Login',
            onTap: () {
              AppRouter.pushWithReplacement(const HomePage());
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          Consumer<UiProvider>(builder: (context, uiProvider, child) {
            return Center(
              child: TextButton(
                  style: TextButton.styleFrom(
                      minimumSize: Size(70.w, 12.h), padding: EdgeInsets.zero),
                  onPressed: () {
                    uiProvider.haveAccountChange();
                  },
                  child: SizedBox(
                    width: 144.w,
                    height: 25.h,
                    child: Row(
                      children: [
                        Text(
                          "Create new account",
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: AppColors.textSecondary,
                          size: 20.w,
                        )
                      ],
                    ),
                  )),
            );
          }),
        ],
      ),
    );
  }
}
