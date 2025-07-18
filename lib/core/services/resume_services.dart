
import '../../features/resume/screens/widgets/model/resume_data.dart';

class ResumeService {
  // Mock data for demonstration
  Future<List<ResumeData>> getRecentResumes() async {
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      ResumeData(
        id: '1',
        name: 'Roopam',
        fileName: 'Roopam.pdf',
        createdAt: DateTime.now().subtract(const Duration(minutes: 1)),
        templateIndex: 0,
      ),
      ResumeData(
        id: '2',
        name: 'Roopam',
        fileName: 'Roopam.pdf',
        createdAt: DateTime.now().subtract(const Duration(minutes: 4)),
        templateIndex: 1,
      ),
    ];
  }

  Future<void> buildResume({
    required int templateIndex,
    // Add other parameters as needed
  }) async {
    // TODO: Implement actual resume building logic
    await Future.delayed(const Duration(seconds: 2));

    // Send selectedTemplate and form data to backend or PDF generator
    print('Building resume with template index: $templateIndex');
  }

  Future<void> downloadResume(String resumeId) async {
    // TODO: Implement download logic
    await Future.delayed(const Duration(seconds: 1));
    print('Downloading resume: $resumeId');
  }
}
