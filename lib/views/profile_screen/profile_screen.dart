import 'package:cvhat/app_router.dart';
import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/models/review_model.dart';
import 'package:cvhat/providers/ui_provider.dart';
import 'package:cvhat/views/home_screen/widgets/recent_reviews_list.dart';
import 'package:cvhat/views/premium_screen/premium_screen.dart';
import 'package:cvhat/widgets/custom_app_bar.dart';
import 'package:cvhat/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../data/dummy_data.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Review> resents = DummyData.aiReviews
        .take(3)
        .map((json) => Review.fromJson(json))
        .toList();
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Profile',
          bgColor: AppColors.secondary,
          textColor: AppColors.textWhite,
          onTap: () {
            AppRouter.popWidget();
            Provider.of<UiProvider>(context, listen: false).index = 0;
          },
        ),
        body: Container(
            color: AppColors.secondary,
            padding: EdgeInsets.only(top: 35.h),
            width: 390.w,
            height: 764.h,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 62.h,
                    ),
                    Container(
                      width: 390.w,
                      height: 657.h,
                      decoration: BoxDecoration(
                          color: AppColors.bgWhite,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.r),
                              topLeft: Radius.circular(20.r))),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 133.h,
                          ),
                          Text(
                            "Oday Mazen",
                            style: TextStyle(
                                fontSize: 36.sp,
                                color: AppColors.textBlack,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "oabumutlak@gmail.com",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.textBlack,
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomButton(
                                  height: 43,
                                  width: 136,
                                  title: "Edit Profile",
                                  fontSize: 16,
                                  onTap: () {}),
                              CustomButton(
                                  height: 43,
                                  width: 136,
                                  title: "Premium",
                                  fontSize: 16,
                                  onTap: () {
                                    AppRouter.pushWidget(const PremiumScreen());
                                  }),
                            ],
                          ),
                          SizedBox(
                            height: 36.h,
                          ),
                          Text(
                            "Saved",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textBlack,
                                fontSize: 24.sp),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          SizedBox(
                            width: 353.w,
                            height: 272.h,
                            child: RecentReviewsList(
                                recentReviews: resents,
                                height: 260,
                                scrollable: true),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundColor: AppColors.secondary_3,
                  radius: 80.r,
                  child: CircleAvatar(
                    backgroundColor: AppColors.primary,
                    radius: 78.r,
                    child: Text(
                      "MM",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 64.sp,
                          color: AppColors.textWhite),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
