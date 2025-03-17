import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/providers/feedback_provider.dart';
import 'package:cvhat/providers/reviews_provider.dart';
import 'package:cvhat/views/feedback_screen/widgets/feedback_app_bar.dart';
import 'package:cvhat/views/feedback_screen/widgets/feedback_comment.dart';
import 'package:cvhat/widgets/loader_blur_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.bgWhite,
        appBar: const FeedbackAppBar(),
        body: Consumer<FeedBackProvider>(
            builder: (context, feedBackProvider, child) {
          return feedBackProvider.isLoading
              ? const LoaderBlurScreen()
              : SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    width: 390.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: AppColors.secondary,
                            ),
                            width: 232.w,
                            height: 282.h,
                            child: Image.network(
                              feedBackProvider
                                  .singleFeedBack!.cv.coverImageUrlHigh!,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        Text(
                          "Comments on your resume:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textSecondary,
                              fontSize: 22.sp),
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 28.h),
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 25.h),
                          itemCount:
                              feedBackProvider.singleFeedBack!.comments!.length,
                          itemBuilder: (context, index) {
                            return FeedbackComment(
                              title: feedBackProvider
                                  .singleFeedBack!.comments![index].title,
                              comment: feedBackProvider
                                  .singleFeedBack!.comments![index].description,
                            );
                          },
                        ),
                        SizedBox(
                          height: 15.h,
                        )
                      ],
                    ),
                  ),
                );
        }),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: AppColors.secondary_3,
          tooltip: "Save",
          onPressed: () {},
          child: Icon(
            Icons.bookmark_border_rounded,
            size: 24.w,
            color: AppColors.bgWhite,
          ),
        ),
      ),
    );
  }
}
