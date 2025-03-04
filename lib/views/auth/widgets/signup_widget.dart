import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/providers/ui_provider.dart';
import 'package:cvhat/widgets/custom_button.dart';
import 'package:cvhat/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget({super.key});

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextField(
                width: 145,
                height: 50,
                textInputAction: TextInputAction.next,
                textEditingController: controller,
                hintText: 'First Name',
                inputType: TextInputType.text,
              ),
              CustomTextField(
                width: 145,
                height: 50,
                textInputAction: TextInputAction.next,
                textEditingController: controller1,
                hintText: 'Last Name',
                inputType: TextInputType.text,
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomTextField(
            width: 309,
            height: 50,
            textInputAction: TextInputAction.next,
            textEditingController: controller2,
            hintText: 'Email',
            inputType: TextInputType.emailAddress,
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomTextField(
            width: 309,
            height: 50,
            textInputAction: TextInputAction.next,
            textEditingController: controller3,
            hintText: 'Password',
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
            textEditingController: controller4,
            hintText: 'Confirm Password',
            inputType: TextInputType.visiblePassword,
            obscure: true,
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomButton(
            height: 55,
            width: 248,
            title: 'Signup',
            onTap: () {},
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
                          "I have Account",
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
