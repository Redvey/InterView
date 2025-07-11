import 'package:go_router/go_router.dart';
import 'package:interview/features/resume_form/contact_form/contact_form.dart';
import 'package:interview/features/resume_form/resume_builder.dart';
import 'package:interview/features/resume_form/resume_builder_home.dart';
import 'package:interview/under_dev.dart';
import '../features/home/home.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/form',
      name: 'form',
      builder: (context, state) => const ResumeFormScreen(),
    ),
    GoRoute(
      path: '/contact',
      name: 'contact',
      builder: (context, state) => const ContactForm(),
    ),
    GoRoute(
      path: '/final',
      name: 'final resume',
      builder: (context, state) => const ResumeBuilderFinalScreen(),
    ),
    GoRoute(
      path: '/unfinished',
      name: 'under dev',
      builder: (context, state) => const UnderDev(),
    ),


  ],
);
