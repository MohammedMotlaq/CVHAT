import 'package:cvhat/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.height,
      required this.width,
      required this.title,
      required this.onTap});

  final double width;
  final double height;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r)),
            minimumSize: Size(width.w, height.h),
            elevation: 5.h,
          ),
          onPressed: () => onTap,
          child: Text(
            title,
            style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textWhite),
          )),
    );
  }
}
