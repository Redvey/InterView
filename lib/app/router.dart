import 'package:go_router/go_router.dart';
import 'package:interview/features/resume_form/contact_form.dart';
import 'package:interview/features/resume_form/resume_builder.dart';
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

  ],
);
