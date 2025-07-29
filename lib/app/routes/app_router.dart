import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/features/cold_email/cold_dm.dart';
import 'package:interview/features/flash_card/flash_card.dart';
import 'package:interview/features/interview/interview.dart';
import 'package:interview/features/interview/screens/interview_completion_screen.dart';
import 'package:interview/features/interview/screens/interviewer.dart';

import '../../features/flash_card/quiz_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/interview/screens/take_mock_interview.dart';
import '../../features/resume/screens/contact_form/contact_form.dart';
import '../../features/resume/screens/resume_builder_final.dart';
import '../../features/resume/screens/resume_builder_home.dart';
import '../../features/review/screens/resume_review_screen.dart';
import 'route_names.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/in_progress',
      name: RouteNames.underDevelopment,
      builder: (context, state) => const ColdMail(),
    ),



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
      path: '/final_resume',
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
    GoRoute(
      path: '/interviewer',
      name: RouteNames.interviewer,
      builder: (context, state) =>  InterviewerScreen(),
    ),
    GoRoute(
      path: '/finish_interview',
      name: RouteNames.finishInterview,
      builder: (context, state) => const FinishInterview(),
    ),
    GoRoute(
      path: '/take-interview',
      name: RouteNames.takeInterview,
      builder: (context, state) {
        final title = state.extra != null && state.extra is Map
            ? (state.extra as Map)['title'] ?? 'Interview'
            : 'Interview';

        final topics = state.extra != null && state.extra is Map
            ? (state.extra as Map)['topics'] ?? <String>[]
            : <String>[];

        return TakeMockInterview(title: title, topics: List<String>.from(topics));
      },
    ),

    GoRoute(
      path: '/quiz/:topic',
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
  ],
);