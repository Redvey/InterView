import 'package:go_router/go_router.dart';
import 'package:interview/features/flash_card/flash_card.dart';
import 'package:interview/features/interview/interview.dart';
import '../features/home/screens/home_screen.dart';
import '../features/resume/screens/contact_form/contact_form.dart';
import '../features/resume/screens/resume_builder_final.dart';
import '../features/resume/screens/resume_builder_home.dart';
import '../features/review/screens/resume_review_screen.dart';
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
      path: '/review',
      name: RouteNames.resumeReview,
      builder: (context, state) => const ResumeReviewScreen(),
    ),
    GoRoute(
      path: '/flash-card',
      name: RouteNames.flashcards,
      builder: (context, state) => const FlashCard(),
    ),
    GoRoute(
      path: '/interview',
      name: RouteNames.interview,
      builder: (context, state) => const MockInterviewScreen(),

    ),


  ],
);
