import 'package:cvhat/providers/auth_form_provider.dart';
import 'package:cvhat/providers/auth_provider.dart';
import 'package:cvhat/providers/feedback_provider.dart';
import 'package:cvhat/providers/file_picker_provider.dart';
import 'package:cvhat/providers/otp_provider.dart';
import 'package:cvhat/providers/profile_provider.dart';
import 'package:cvhat/providers/reviews_provider.dart';
import 'package:cvhat/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class Providers {
  Providers._();

  static final providers = [
    ChangeNotifierProvider<UiProvider>(
      create: (_) => UiProvider(),
    ),
    ChangeNotifierProvider<FilePickerProvider>(
      create: (_) => FilePickerProvider(),
    ),
    ChangeNotifierProvider<AuthFormProvider>(
      create: (_) => AuthFormProvider.authFormProvider,
    ),
    ChangeNotifierProvider<AuthProvider>(
      create: (_) => AuthProvider(),
    ),
    ChangeNotifierProvider<ReviewsProvider>(
      create: (_) => ReviewsProvider(),
    ),
    ChangeNotifierProvider<FeedBackProvider>(
      create: (_) => FeedBackProvider(),
    ),
    ChangeNotifierProvider<ProfileProvider>(
      create: (_) => ProfileProvider(),
    ),
    ChangeNotifierProvider<OTPProvider>(
      create: (_) => OTPProvider(),
    ),
  ].toList();
}
