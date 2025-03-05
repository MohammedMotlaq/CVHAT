import 'dart:ui';

import 'package:cvhat/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewCard extends StatelessWidget {
  final String label;
  final String value;
  final double width;
  final double height;

  ReviewCard({
    required this.label,
    required this.value,
    this.width = 165,
    this.height = 139,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        color: AppColors.secondaryWithOpacity,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.secondary,
          width: 2.w,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary),
          ),
          SizedBox(height: 38.h),
          Text(
            value,
            style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
