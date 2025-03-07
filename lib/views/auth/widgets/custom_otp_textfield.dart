import 'package:cvhat/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOtpTextField extends StatelessWidget {
  const CustomOtpTextField(
      {super.key,
      required this.textInputAction,
      required this.textEditingController});

  final TextEditingController textEditingController;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 44.w,
        height: 45.h,
        child: TextField(
          controller: textEditingController,
          keyboardType: TextInputType.number,
          textInputAction: textInputAction,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 5.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              )),
          style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.normal,
              color: AppColors.textSecondary),
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly
          ],
          cursorWidth: 1,
          cursorHeight: 20.h,
        ));
  }
}
