import 'package:cvhat/providers/auth_form_provider.dart';
import 'package:cvhat/providers/auth_provider.dart';
import 'package:cvhat/providers/file_picker_provider.dart';
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
  ].toList();
}
