import 'package:flutter/foundation.dart';
import 'package:interview/core/constants/image_strings.dart';

import '../../../core/services/resume_services.dart';
import '../screens/widgets/model/resume_data.dart';


class ResumeController extends ChangeNotifier {
  final ResumeService _resumeService = ResumeService();

  int _selectedTemplateIndex = 0;
  List<ResumeData> _recentResumes = [];
  bool _isLoading = false;

  // Getters
  int get selectedTemplateIndex => _selectedTemplateIndex;
  List<ResumeData> get recentResumes => _recentResumes;
  bool get isLoading => _isLoading;

  List<String> get templateThumbnails => [
    AppImage.temp2,
    AppImage.temp3,
  ];

  ResumeController() {
    _loadRecentResumes();
  }

  void selectTemplate(int index) {
    _selectedTemplateIndex = index;
    notifyListeners();
  }

  Future<void> buildResume() async {
    try {
      _isLoading = true;
      notifyListeners();

      await _resumeService.buildResume(
        templateIndex: _selectedTemplateIndex,
        // Add other required data here
      );

      // Refresh recent resumes after building
      await _loadRecentResumes();
    } catch (e) {
      // Handle error
      debugPrint('Error building resume: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadRecentResumes() async {
    try {
      _recentResumes = await _resumeService.getRecentResumes();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading recent resumes: $e');
    }
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }
}
