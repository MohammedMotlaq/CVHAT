import 'package:cvhat/app_router.dart';
import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/models/review_details.dart';
import 'package:cvhat/views/feedback_screen/feedback_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentReviewCard extends StatelessWidget {
  final ReviewDetails review;

  const RecentReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppRouter.pushWidget(const FeedbackPage());
      },
      child: Container(
        height: 120.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(20.r)),
        child: Row(
          children: [
            Container(
              width: 66.w,
              height: 87.h,
              color: AppColors.bgWhite,
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        review.title,
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: AppColors.textWhite,
                            fontWeight: FontWeight.bold),
                      ),
                      CircleAvatar(
                        backgroundColor: AppColors.bgWhite,
                        radius: 10.r,
                        child: Text(
                          "AI",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        review.fileName,
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.textWhite,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        review.uploadDate,
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.textWhite,
                            fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
