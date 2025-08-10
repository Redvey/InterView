
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/features/cold_email/cold_dm.dart';
import 'package:interview/features/flash_card/flash_card.dart';
import 'package:interview/features/flash_card/quiz_screen.dart';
import 'package:interview/features/home/screens/home_screen.dart';
import 'package:interview/features/interview/interview.dart';
import 'package:interview/features/interview/screens/interview_completion_screen.dart';
import 'package:interview/features/interview/screens/interviewer.dart';
import 'package:interview/features/onboarding/screens/auth/auth_screen.dart';
import 'package:interview/features/resume/screens/contact_form/contact_form.dart';
import 'package:interview/features/resume/screens/resume_builder_final.dart';
import 'package:interview/features/resume/screens/resume_builder_home.dart';
import 'package:interview/features/review/screens/resume_review_screen.dart';
import '../../features/onboarding/screens/error_screen/error_screen.dart';
import '../../features/onboarding/screens/onboarding/onboarding_screen.dart';
import '../../features/onboarding/screens/profile_setup/profile_setup.dart';

import 'route_names.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Onboarding Route
    GoRoute(
      path: '/',
      name: RouteNames.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),

    // Home Route
    GoRoute(
      path: '/home',
      name: RouteNames.home,
      builder: (context, state) => const HomeScreen(),
    ),

    // Auth Routes

    GoRoute(
      path: '/auth',
      builder: (context, state) {
        final isLogin = state.uri.queryParameters['mode'] != 'signup';
        return AuthScreen(isLogin: isLogin);
      },
    ),

    GoRoute(
      path: '/profile-setup',
      name: RouteNames.profileSetup,
      builder: (context, state) {
        final signupData = state.extra as Map<String, dynamic>?;
        return ProfileSetupScreen(signupData: signupData);
      },
    ),

    // Resume Routes
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
      path: '/final_resume',
      name: RouteNames.finalResume,
      builder: (context, state) => const ResumeBuilderFinalScreen(),
    ),

    GoRoute(
      path: '/review',
      name: RouteNames.resumeReview,
      builder: (context, state) => const ResumeReviewScreen(),
    ),

    // Interview Routes
    GoRoute(
      path: '/interview',
      name: RouteNames.interview,
      builder: (context, state) => const MockInterviewScreen(),
    ),

    GoRoute(
      path: '/interviewer',
      name: RouteNames.interviewer,
      builder: (context, state) => InterviewerScreen(),
    ),

    GoRoute(
      path: '/finish_interview',
      name: RouteNames.finishInterview,
      builder: (context, state) => const FinishInterview(),
    ),

    // Flash Card Routes
    GoRoute(
      path: '/flash-card',
      name: RouteNames.flashcards,
      builder: (context, state) => const FlashCard(),
    ),

    GoRoute(
      path: '/quiz/:topic',
      name: RouteNames.quiz,
      pageBuilder: (context, state) {
        final topic = state.pathParameters['topic']!;
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: QuizScreen(topic: topic),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.95, end: 1.0)
                    .animate(CurveTween(curve: Curves.easeOut).animate(animation)),
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 400),
        );
      },
    ),

    // Development Routes
    GoRoute(
      path: '/in_progress',
      name: RouteNames.underDevelopment,
      builder: (context, state) => const ColdMail(),
    ),

    // Error Route
    GoRoute(
      path: '/error',
      builder: (context, state) => const ErrorScreen(),
    ),
  ],

  // Error handling
  errorBuilder: (context, state) => ErrorScreen(error: state.error.toString()),

  // Redirect logic (optional)
  redirect: (context, state) {
    // Add authentication logic here if needed
    // For example:
    // if (!isAuthenticated && protectedRoutes.contains(state.location)) {
    //   return '/sign-in';
    // }
    return null; // No redirect
  },
);
