import 'package:go_router/go_router.dart';
import '../features/home/screens/home_screen.dart';
import '../features/resume/screens/contact_form/contact_form.dart';
import '../features/resume/screens/resume_builder.dart';
import '../features/resume/screens/resume_builder_home.dart';
import '../features/review/screens/resume_review_screen.dart';
import '../features/under_dev.dart';
import 'route_names.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: RouteNames.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/form',
      name: RouteNames.resumeForm,
      builder: (context, state) => const ResumeFormScreen(),
    ),
    GoRoute(
      path: '/contact',
      name: RouteNames.contactForm,
      builder: (context, state) => const ContactForm(),
    ),
    GoRoute(
      path: '/final',
      name: RouteNames.finalResume,
      builder: (context, state) => const ResumeBuilderFinalScreen(),
    ),
    GoRoute(
      path: '/unfinished',
      name: RouteNames.underDevelopment,
      builder: (context, state) => const UnderDev(),
    ),
    GoRoute(
      path: '/review',
      name: RouteNames.resumeReview,
      builder: (context, state) => const ResumeReviewScreen(),
    ),
  ],
);
