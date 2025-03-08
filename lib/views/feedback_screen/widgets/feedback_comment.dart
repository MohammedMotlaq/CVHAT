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
      padding: EdgeInsets.all(10.sp),
      width: 355.w,
      decoration: BoxDecoration(
        border: Border.all(width: 2.w),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary),
          ),
          Text(
            comment,
            style: TextStyle(fontSize: 15.sp, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
