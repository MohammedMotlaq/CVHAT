import 'package:cvhat/models/review_model.dart';
import 'package:cvhat/widgets/recent_review_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentReviewsList extends StatelessWidget {
  final List<Review> recentReviews;
  final double height;
  final bool scrollable;

  const RecentReviewsList(
      {super.key,
      required this.recentReviews,
      this.height = 499,
      this.scrollable = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      child: ListView.separated(
        padding: EdgeInsets.only(top: 28.h),
        physics: scrollable
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => SizedBox(height: 25.h),
        itemCount: recentReviews.length,
        itemBuilder: (context, index) {
          return RecentReviewCard(review: recentReviews[index]);
        },
      ),
    );
  }
}
