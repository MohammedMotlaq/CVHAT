import 'package:cvhat/providers/ui_provider.dart';
import 'package:provider/provider.dart';
class Providers {
  Providers._();
  static final providers= [
    ChangeNotifierProvider<UiProvider>(
      create: (_) =>  UiProvider(),
    ),
  ].toList();
}