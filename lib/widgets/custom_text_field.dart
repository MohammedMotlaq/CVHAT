import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/resources/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.width,
      required this.height,
      required this.textInputAction,
      this.obscure,
      required this.textEditingController,
      required this.hintText,
      required this.inputType});

  final double width;
  final double height;
  final TextInputType inputType;
  final String hintText;
  final TextEditingController textEditingController;
  final bool? obscure;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width.w,
        height: height.h,
        child: TextField(
          controller: textEditingController,
          keyboardType: inputType,
          obscureText: obscure ?? false,
          textInputAction: textInputAction,
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 14.h, horizontal: 18.w),
              label: Text(
                hintText,
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.normal,
                    color: AppColors.textSecondary),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              )),
          style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.normal,
              color: AppColors.textSecondary),
        ));
  }
}
