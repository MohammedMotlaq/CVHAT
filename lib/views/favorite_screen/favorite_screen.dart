import 'package:cvhat/app_router.dart';
import 'package:cvhat/core/resources/app_animations.dart';
import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/providers/reviews_provider.dart';
import 'package:cvhat/providers/ui_provider.dart';
import 'package:cvhat/views/home_screen/widgets/recent_reviews_list.dart';
import 'package:cvhat/widgets/custom_app_bar.dart';
import 'package:cvhat/widgets/empty_list_widget.dart';
import 'package:cvhat/widgets/loader_blur_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key}) {
    Provider.of<ReviewsProvider>(AppRouter.navKey.currentContext!,
            listen: false)
        .fetchFavoriteReviews();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.bgWhite,
        appBar: CustomAppBar(
          title: 'Favorite',
          bgColor: AppColors.bgWhite,
          textColor: AppColors.textSecondary,
          onTap: () {
            AppRouter.popWidget();
            Provider.of<UiProvider>(context, listen: false).index = 0;
          },
        ),
        body: Consumer<ReviewsProvider>(
            builder: (context, reviewsProvider, child) {
          return reviewsProvider.isLoading
              ? const Expanded(child: LoaderBlurScreen())
              : reviewsProvider.favoriteReviews.isNotEmpty
                  ? SizedBox(
                      width: 390.w,
                      height: double.infinity,
                      child: RecentReviewsList(
                          recentReviews: reviewsProvider.favoriteReviews,
                          scrollable: true),
                    )
                  : const Expanded(
                      child: EmptyListWidget(
                        jsonFile: AppAnimations.favorite,
                        title: "No Favorites!",
                        showArrow: false,
                        width: 280,
                        height: 280,
                      ),
                    );
        }),
      ),
    );
  }
}
