import 'package:cvhat/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewCard extends StatelessWidget {
  final String label;
  final String value;
  final double width;
  final double height;

  const ReviewCard({
    super.key,
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
          color: AppColors.bgWhite,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: const [
            BoxShadow(
              color: AppColors.secondaryWithOpacity,
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 3),
            )
          ]),
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
