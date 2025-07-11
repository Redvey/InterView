
import 'package:flutter/material.dart';
import 'package:interview/routes/app_router.dart';

class InterView extends StatelessWidget {
  const InterView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Interview App',
      routerConfig: appRouter,
    );
  }
}
