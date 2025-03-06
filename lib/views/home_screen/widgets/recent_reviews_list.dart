import 'package:cvhat/models/review_details.dart';
import 'package:cvhat/widgets/recent_review_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentReviewsList extends StatelessWidget {
  final List<ReviewDetails> recentReviews;

  const RecentReviewsList({Key? key, required this.recentReviews})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450.h,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => SizedBox(height: 25.h),
        itemCount: recentReviews.length,
        itemBuilder: (context, index) {
          return RecentReviewCard(review: recentReviews[index]);
        },
      ),
    );
  }
}
