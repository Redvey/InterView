import 'package:flutter/material.dart';
import 'package:interview/app/routes/app_router.dart';
import 'package:interview/app/themes/themes.dart';
import 'package:interview/core/constants/strings.dart';


class InterView extends StatelessWidget {
  const InterView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      theme: AppTheme.lightTheme(context),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
