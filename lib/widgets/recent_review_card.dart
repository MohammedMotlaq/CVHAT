import 'package:cvhat/app_router.dart';
import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/models/review_model.dart';
import 'package:cvhat/providers/feedback_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../core/resources/app_icons.dart';

class RecentReviewCard extends StatelessWidget {
  final Review review;

  const RecentReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Consumer<FeedBackProvider>(
        builder: (context, feedBackProvider, child) {
      return InkWell(
        onTap: () {
          feedBackProvider.fetchReviewByID(review.id);
        },
        child: Container(
          height: 120.h,
          margin: EdgeInsets.symmetric(horizontal: 18.w),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.secondary.withValues(alpha: 0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                )
              ]),
          child: Row(
            children: [
              Container(
                width: 66.w,
                height: 87.h,
                decoration: BoxDecoration(
                  color: AppColors.bgWhite,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(
                    review.cv.coverImageUrlLow!,
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child; // Image fully loaded
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                    errorBuilder: (context, child, stackTrace) {
                      return Image.asset(AppIcons.cv);
                    },
                  ),
                ),
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
                        SizedBox(
                          width: 215.w,
                          child: Text(
                            review.cv.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: AppColors.textWhite,
                                fontWeight: FontWeight.normal),
                          ),
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
                        SizedBox(
                          width: 151.w,
                          child: Text(
                            review.cv.fileName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.textWhite,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        Text(
                          review.createdAt,
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
    });
  }
}
