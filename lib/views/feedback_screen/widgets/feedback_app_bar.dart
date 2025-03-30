import 'package:cvhat/app_router.dart';
import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/providers/feedback_provider.dart';
import 'package:cvhat/providers/file_picker_provider.dart';
import 'package:cvhat/providers/reviews_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart' show Provider;

class FeedbackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FeedbackAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.bgWhite,
      leading: IconButton(
          onPressed: () {
            Provider.of<ReviewsProvider>(AppRouter.navKey.currentContext!,
                    listen: false)
                .fetchRecentReviews();
            Provider.of<ReviewsProvider>(AppRouter.navKey.currentContext!,
                    listen: false)
                .fetchReviewsCounts();
            Provider.of<FilePickerProvider>(AppRouter.navKey.currentContext!,
                    listen: false)
                .clearFile();
            Provider.of<FeedBackProvider>(AppRouter.navKey.currentContext!,
                    listen: false)
                .submitCvController
                .clear();
            AppRouter.popWidget();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            size: 32.sp,
            color: AppColors.secondary,
          )),
      title: Text(
        "Feedback",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'PlayfairDisplay',
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
