import 'package:cvhat/app_router.dart';
import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/data/dummy_data.dart';
import 'package:cvhat/models/review_details.dart';
import 'package:cvhat/views/home_screen/widgets/recent_reviews_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewsHistory extends StatelessWidget {
  const ReviewsHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ReviewDetails> AllHistory = DummyData.aiReviews
        .map((json) => ReviewDetails.fromJson(json))
        .toList();
    return Scaffold(
      appBar: const HistoryAppBar(),
      body: RecentReviewsList(
        recentReviews: AllHistory,
        height: 900,
      ),
    );
  }
}

class HistoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HistoryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
          onPressed: () {
            AppRouter.popWidget();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            size: 32.sp,
            color: AppColors.secondary,
          )),
      title: Text(
        "History",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.secondary,
            fontSize: 32.sp),
      ),
      centerTitle: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
