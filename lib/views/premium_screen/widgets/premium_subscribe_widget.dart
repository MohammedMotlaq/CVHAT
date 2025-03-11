import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/models/premium_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PremiumSubscribeWidget extends StatelessWidget {
  const PremiumSubscribeWidget({super.key, required this.premiumDetails});

  final PremiumDetails premiumDetails;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 350.w,
        height: 90.h,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: AppColors.secondary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: premiumDetails.isBest
              ? Border.all(width: 2.w, color: AppColors.secondary)
              : Border.all(style: BorderStyle.none),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 220.w,
                  child: Text(
                    premiumDetails.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary),
                  ),
                ),
                premiumDetails.isBest
                    ? Container(
                        width: 75.w,
                        height: 22.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.secondary_3,
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Text(
                          'Best Value',
                          style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w300,
                              color: AppColors.textWhite),
                        ),
                      )
                    : const SizedBox()
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            SizedBox(
              width: 310.w,
              child: Text(
                premiumDetails.offer,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                    color: AppColors.secondary),
              ),
            )
          ],
        ),
      ),
    );
  }
}
