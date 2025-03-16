import 'package:cvhat/app_router.dart';
import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/data/dummy_data.dart';
import 'package:cvhat/models/review_details.dart';
import 'package:cvhat/models/review_model.dart';
import 'package:cvhat/providers/reviews_provider.dart';
import 'package:cvhat/views/home_screen/widgets/recent_reviews_list.dart';
import 'package:cvhat/views/home_screen/widgets/review_card.dart';
import 'package:cvhat/views/reviews_history/reviews_history.dart';
import 'package:cvhat/views/upload_cv_screen/upload_cv.dart';
import 'package:cvhat/views/drawer/app_drawer_widget.dart';
import 'package:cvhat/widgets/custom_appbar.dart';
import 'package:cvhat/widgets/loader_blur_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key}) {
    Provider.of<ReviewsProvider>(AppRouter.navKey.currentContext!,
            listen: false)
        .fetchRecentReviews();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReviewsProvider>(
        builder: (context, reviewsProvider, child) {
      return Scaffold(
        backgroundColor: AppColors.secondary,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.h),
            child: const CustomAppbar(userName: "Mohammed")),
        drawer: const AppDrawerWidget(),
        body: Stack(
          children: [
            Container(
                width: 390.w,
                decoration: BoxDecoration(
                    color: AppColors.bgWhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReviewCard(label: "AI Reviews", value: "7"),
                          ReviewCard(label: "Recruiter Feedback", value: "7"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recents",
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: AppColors.textSecondary),
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: AppColors.textSecondary,
                                  padding: EdgeInsets.zero),
                              onPressed: () {
                                AppRouter.pushWidget(ReviewsHistory());
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "View All",
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.normal,
                                        color: AppColors.textSecondary),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 24.w,
                                    color: AppColors.secondary,
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                    reviewsProvider.isLoading
                        ? const Expanded(child: LoaderBlurScreen())
                        : reviewsProvider.recentReviews.isNotEmpty
                            ? RecentReviewsList(
                                recentReviews: reviewsProvider.recentReviews,
                                scrollable: false)
                            : Expanded(
                                child: Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  child: Text(
                                    "No Reviews Found, Start uploading now!",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32.sp,
                                        color: AppColors.textPrimary),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ))
                  ],
                )),
            Positioned(
                bottom: 20.h,
                right: 14.w,
                child: ElevatedButton(
                  onPressed: () {
                    reviewsProvider.fetchRecentReviews();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: AppColors.secondary_3,
                    elevation: 9,
                    shadowColor: Colors.black,
                    minimumSize:
                        Size(60.w, 60.h), // Circular button with 60 radius
                  ),
                  child: Icon(
                    Icons.add_rounded, // Or any icon you want to use
                    size: 32.sp,
                    color: Colors.white,
                  ),
                )),
          ],
        ),
      );
    });
  }
}
