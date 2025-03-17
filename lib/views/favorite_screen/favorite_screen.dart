import 'package:cvhat/app_router.dart';
import 'package:cvhat/core/resources/app_animations.dart';
import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/providers/reviews_provider.dart';
import 'package:cvhat/views/home_screen/widgets/recent_reviews_list.dart';
import 'package:cvhat/widgets/custom_app_bar.dart';
import 'package:cvhat/widgets/empty_list_widget.dart';
import 'package:cvhat/widgets/loader_blur_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ReviewsProvider>(
        builder: (context, reviewsProvider, child) {
      return Scaffold(
          backgroundColor: AppColors.bgWhite,
          appBar: CustomAppBar(
            title: 'Favorite',
            bgColor: AppColors.bgWhite,
            textColor: AppColors.textSecondary,
            onTap: () {
              AppRouter.popWidget();
            },
          ),
          body: reviewsProvider.isLoading
              ? LoaderBlurScreen()
              : reviewsProvider.favoriteReviews.isEmpty
                  ? const EmptyListWidget(
                      jsonFile: AppAnimations.favorite,
                      title: "No Favorites!",
                      showArrow: false,
                      width: 280,
                      height: 280,
                    )
                  : RecentReviewsList(
                      recentReviews: reviewsProvider.favoriteReviews,
                      height: 900,
                    ));
    });
  }
}
