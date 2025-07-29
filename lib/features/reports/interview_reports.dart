import 'package:flutter/material.dart';
import 'package:interview/core/constants/image_strings.dart';
import 'package:interview/features/reports/service/interview_report_dummy.dart';
import 'package:intl/intl.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../app/themes/text_styles.dart';
import '../../core/constants/strings.dart';
import 'model/interview_report_model.dart';

class InterviewReportsScreen extends StatefulWidget {
  const InterviewReportsScreen({super.key});

  @override
  State<InterviewReportsScreen> createState() => _InterviewReportsScreenState();
}

class _InterviewReportsScreenState extends State<InterviewReportsScreen> {
  late Future<List<InterviewReport>> futureReports;

  @override
  void initState() {
    super.initState();
    futureReports = fetchInterviewReports();
  }

  String getDateLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final reportDate = DateTime(date.year, date.month, date.day);

    if (reportDate == today) {
      return AppStrings.today;
    } else if (reportDate == today.subtract(const Duration(days: 1))) {
      return AppStrings.yesterday;
    } else {
      return DateFormat('EEEE, MMM d').format(date);
    }
  }

  String getTimeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);

    if (diff.inMinutes < 60) {
      return "${diff.inMinutes} ${AppStrings.minutesAgo}";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} ${AppStrings.hoursAgo}";
    } else if (diff.inDays == 1) {
      return AppStrings.dayAgo;
    } else {
      return DateFormat.yMMMd().format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<InterviewReport>>(
      future: futureReports,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text(AppStrings.noReports));
        }

        final reports = snapshot.data!;
        final grouped = <String, List<InterviewReport>>{};
        for (var report in reports) {
          final label = getDateLabel(report.submittedAt);
          grouped.putIfAbsent(label, () => []).add(report);
        }

        return SingleChildScrollView(
          padding: context.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.interviewReports,
                style: AppTextStyles.roleTitle(context),
              ),
              SizedBox(height: context.spaceBtwSections),
              for (var entry in grouped.entries) ...[
                Text(
                  entry.key.toUpperCase(),
                  style: AppTextStyles.dateHeader(context),
                ),
                const SizedBox(height: 8),
                for (var report in entry.value)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(AppImage.temp),
                    ),
                    title: Text(
                      report.role,
                      style: AppTextStyles.roleTitle(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // report.topics.map((e) => '• $e').join('\n'),
                          report.topics.join(', '),

                          // or use bullets / line breaks if preferred
                          style: AppTextStyles.topicSummary(context),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          getTimeAgo(report.submittedAt),
                          style: AppTextStyles.timestamp(context),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 16),
              ],
              SizedBox(height: context.bottomNavHeight + 20),
            ],
          ),
        );
      },
    );
  }
}
