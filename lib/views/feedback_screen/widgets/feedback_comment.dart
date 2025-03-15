import 'package:cvhat/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedbackComment extends StatelessWidget {
  final String title;
  final String comment;

  const FeedbackComment(
      {super.key, required this.title, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
      width: 355.w,
      decoration: BoxDecoration(
          //border: Border.all(width: 2.w),
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.bgWhite,
          boxShadow: const [
            BoxShadow(
              color: AppColors.secondaryWithOpacity,
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 3),
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            decoration: BoxDecoration(
              color: AppColors.bgGray.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            child: Text(
              comment,
              style: TextStyle(fontSize: 15.sp, color: AppColors.textPrimary),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
