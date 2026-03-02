import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constants/app_colors.dart';
import 'core/theme/primary_color_provider.dart';
import 'core/utils/exported_file.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final prefs = await SharedPreferences.getInstance();
  final colorValue = prefs.getInt('primary_color') ?? 0xff08431D;
  final initialColor = Color(colorValue);
  AppColors.primaryColor = initialColor;

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWith((ref) => prefs),
        primaryColorProvider.overrideWith(
          (ref) => PrimaryColorNotifier(ref.watch(sharedPreferencesProvider), initialColor),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(primaryColorProvider);

    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        splashColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      title: 'HungryApp',
      home: SplashView(),
    );
  }
}
