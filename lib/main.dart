import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'app/myapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //needed to load translations

  await translator.init(
    localeType: LocalizationDefaultType.device,
    languagesList: <String>['en', 'es'],
    assetsDirectory: 'assets/lang/',
  );

  runApp(
    LocalizedApp(
      child: const MyApp(),
    ),
  );
}
