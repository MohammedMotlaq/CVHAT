import 'package:cvhat/app_router.dart';
import 'package:cvhat/core/resources/app_animations.dart';
import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/providers/ui_provider.dart';
import 'package:cvhat/widgets/custom_app_bar.dart';
import 'package:cvhat/widgets/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

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
        body: const EmptyListWidget(
          jsonFile: AppAnimations.favorite,
          title: "No Favorites!",
          showArrow: false,
          width: 280,
          height: 280,
        ),
      ),
    );
  }
}
