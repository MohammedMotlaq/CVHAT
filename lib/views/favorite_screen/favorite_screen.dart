import 'package:cvhat/app_router.dart';
import 'package:cvhat/core/resources/app_animations.dart';
import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/widgets/custom_app_bar.dart';
import 'package:cvhat/widgets/empty_list_widget.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: const EmptyListWidget(
        jsonFile: AppAnimations.favorite,
        title: "No Favorites!",
        showArrow: false,
        width: 280,
        height: 280,
      ),
    );
  }
}
