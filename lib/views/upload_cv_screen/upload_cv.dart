import 'dart:io';
import 'dart:ui';

import 'package:cvhat/app_router.dart';
import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/providers/file_picker_provider.dart';
import 'package:cvhat/views/upload_cv_screen/widgets/upload_cv_app_bar.dart';
import 'package:cvhat/widgets/custom_button.dart';
import 'package:cvhat/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class UploadCv extends StatelessWidget {
  const UploadCv({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: const UploadCvAppBar(),
        body: SizedBox(
          width: 390.w,
          child: Consumer<FilePickerProvider>(
            builder: (context, filePickerProvider, child) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Material(
                      child: GestureDetector(
                        onTap: () {
                          filePickerProvider
                              .pickFile(allowedExtensions: ["pdf"]);
                        },
                        child: filePickerProvider.selectedFile == null
                            ? CustomPaint(
                                painter: DottedBorderPainter(
                                  color: AppColors.secondary,
                                  strokeWidth: 2,
                                  gap: 6,
                                  borderRadius: 20.r, // Adjust corner radius
                                ),
                                child: Container(
                                  height: 300.h,
                                  width: 300.w,
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors.secondary.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.file_upload_outlined,
                                        color: AppColors.secondary,
                                        size: 48.sp,
                                      ),
                                      Text(
                                        "Click To Upload",
                                        style: TextStyle(
                                            color: AppColors.secondary,
                                            fontSize: 16.sp),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Stack(children: [
                                Container(
                                    height: 300.h,
                                    width: 300.w,
                                    decoration: BoxDecoration(
                                        color: AppColors.secondary
                                            .withOpacity(0.05),
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        border: Border.all()),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.r),
                                      child: SfPdfViewer.file(
                                        File(filePickerProvider
                                            .selectedFile!.path!),
                                        enableTextSelection: false,
                                        maxZoomLevel: 1,
                                        enableDoubleTapZooming: false,
                                      ),
                                    )),
                                Positioned(
                                    bottom: 10.w,
                                    left: 0.w,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppColors.secondary,
                                            shape: const CircleBorder()),
                                        child: Icon(
                                          size: 24.sp,
                                          Icons.clear,
                                          color: AppColors.bgWhite,
                                        ),
                                        onPressed: () {
                                          filePickerProvider.clearFile();
                                        }))
                              ]),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: filePickerProvider.selectedFile != null
                          ? Text(
                              filePickerProvider.selectedFile!.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32.sp,
                                  color: AppColors.secondary),
                            )
                          : const SizedBox(),
                    ),
                    SizedBox(
                      height: 45.h,
                    ),
                    CustomTextField(
                      width: 309,
                      height: 50,
                      textInputAction: TextInputAction.done,
                      hintText: 'Submission Title',
                      inputType: TextInputType.text,
                      textEditingController: controller,
                    ),
                    SizedBox(
                      height: 45.h,
                    ),
                    CustomButton(
                      height: 55,
                      width: 248,
                      title: 'Submit',
                      onTap: () {
                        AppRouter.popWidget();
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double borderRadius;

  DottedBorderPainter({
    required this.color,
    this.strokeWidth = 2.0,
    this.gap = 5.0,
    this.borderRadius = 10.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ));

    drawDottedPath(canvas, path, paint);
  }

  void drawDottedPath(Canvas canvas, Path path, Paint paint) {
    PathMetrics pathMetrics = path.computeMetrics();
    for (PathMetric pathMetric in pathMetrics) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        Path extractPath = pathMetric.extractPath(distance, distance + gap);
        canvas.drawPath(extractPath, paint);
        distance += gap * 2; // Adjust space between dots
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
