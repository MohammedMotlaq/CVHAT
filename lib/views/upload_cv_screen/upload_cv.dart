import 'package:cvhat/app_router.dart';
import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/providers/file_picker_provider.dart';
import 'package:cvhat/views/home_screen/home_page.dart';
import 'package:cvhat/views/upload_cv_screen/widgets/upload_cv_app_bar.dart';
import 'package:cvhat/widgets/custom_button.dart';
import 'package:cvhat/widgets/custom_text_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Material(
                    child: InkWell(
                      onTap: () {
                        filePickerProvider.pickFile(
                            allowedExtensions: ["pdf", "doc", "docx"]);
                      },
                      child: Container(
                        height: 300.h,
                        width: 300.w,
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                        child: filePickerProvider.selectedFile != null
                            ? filePickerProvider.buildFilePreview()
                            : Icon(
                                Icons.file_upload_outlined,
                                color: AppColors.bgWhite,
                                size: 48.sp,
                              ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      filePickerProvider.selectedFile != null
                          ? filePickerProvider.selectedFile!.name
                          : "Select a file",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary,
                          fontSize: 32.sp),
                    ),
                  ),
                  CustomTextField(
                    width: 309,
                    height: 50,
                    textInputAction: TextInputAction.next,
                    hintText: 'Submission Title',
                    inputType: TextInputType.emailAddress,
                    textEditingController: controller,
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
                    height: 100.h,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
