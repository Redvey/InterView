import 'package:flutter/material.dart';

class ExperienceEntry {
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;
  bool isCurrent = false;

  void dispose() {
    jobTitleController.dispose();
    companyController.dispose();
    descriptionController.dispose();
  }
}
