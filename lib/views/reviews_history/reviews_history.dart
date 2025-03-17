import 'package:cvhat/app_router.dart';
import 'package:cvhat/core/resources/app_animations.dart';
import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/providers/reviews_provider.dart';
import 'package:cvhat/views/home_screen/widgets/recent_reviews_list.dart';
import 'package:cvhat/widgets/empty_list_widget.dart';
import 'package:cvhat/widgets/loader_blur_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ReviewsHistory extends StatelessWidget {
  ReviewsHistory({super.key}) {
    Provider.of<ReviewsProvider>(AppRouter.navKey.currentContext!,
            listen: false)
        .fetchAllReviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgWhite,
        appBar: const HistoryAppBar(),
        body: Consumer<ReviewsProvider>(
            builder: (context, reviewsProvider, child) {
          return reviewsProvider.isLoading
              ? const LoaderBlurScreen()
              : reviewsProvider.reviews.isNotEmpty
                  ? RecentReviewsList(
                      recentReviews: reviewsProvider.reviews,
                      height: 900,
                    )
                  : const EmptyListWidget(
                      jsonFile: AppAnimations.empty,
                      title: "Nothing To Show!",
                      showArrow: false,
                    );
        }));
  }
}

class HistoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HistoryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.bgWhite,
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
