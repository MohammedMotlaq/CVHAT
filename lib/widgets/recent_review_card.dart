import 'package:cvhat/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentReviewCard extends StatelessWidget {
  final String title;
  final String fileName;
  final String uploadDate;

  const RecentReviewCard(
      {super.key,
      required this.title,
      required this.fileName,
      required this.uploadDate});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
                        title,
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
                        fileName,
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.textWhite,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        uploadDate,
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
