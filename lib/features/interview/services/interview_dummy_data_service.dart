import 'package:interview/core/constants/app_durations.dart';
import 'package:interview/features/interview/models/interview_item.dart';



class InterviewDataService {
  static const InterviewDataService _instance = InterviewDataService._internal();
  factory InterviewDataService() => _instance;
  const InterviewDataService._internal();

  // This will be replaced with actual API calls
  Future<List<InterviewItem>> getInterviewItems({
    String? category, // This will no longer be used for filtering the dummy data, but kept for potential future API use
    String? searchQuery,
  }) async {
    // Simulate API delay
    await Future.delayed(Duration(milliseconds: AppDurations.apiDelayMilliseconds));

    List<InterviewItem> items = _getDummyInterviewItems();



    // Filter by search query if provided
    if (searchQuery != null && searchQuery.isNotEmpty) {
      items = items.where((item) =>
      item.jobTitle.toLowerCase().contains(searchQuery.toLowerCase()) ||
          item.jobDescription.toLowerCase().contains(searchQuery.toLowerCase()) ||
          item.topics.any((topic) =>
              topic.toLowerCase().contains(searchQuery.toLowerCase()))).toList();
    }

    return items;
  }

  Future<InterviewItem?> getInterviewItemById(String id) async {
    await Future.delayed(const Duration(milliseconds: AppDurations.apiDelaySmallMilliseconds));

    try {
      return _getDummyInterviewItems().firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  List<InterviewItem> _getDummyInterviewItems() {
    return [
      InterviewItem(
        id: '1',
        jobTitle: 'Flutter Developer',
        company: 'Tech Solutions Inc.',
        jobDescription: 'Mobile app development using Flutter framework with focus on state management and performance optimization.',
        topics: ['Widgets', 'State Management', 'Navigation', 'Animations'],
        difficulty: 'Medium',
        duration: '45 mins',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      InterviewItem(
        id: '2',
        jobTitle: 'Full Stack Developer',
        company: 'Web Innovators LLC', // Added company
        jobDescription: 'End-to-end web development covering frontend, backend, and database management.',
        topics: ['React', 'Node.js', 'MongoDB', 'REST APIs'],
        difficulty: 'Hard',
        duration: '60 mins',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      InterviewItem(
        id: '3',
        jobTitle: 'Machine Learning Engineer',
        company: 'AI Research Group', // Added company
        jobDescription: 'Design and implement ML models for production systems with focus on scalability.',
        topics: ['TensorFlow', 'PyTorch', 'Model Deployment', 'Data Preprocessing'],
        difficulty: 'Hard',
        duration: '75 mins',
        createdAt: DateTime.now().subtract(const Duration(hours: 12)),
      ),
      InterviewItem(
        id: '4',
        jobTitle: 'Python Developer',
        company: 'Data Insights Co.', // Added company
        jobDescription: 'Backend development using Python with emphasis on clean code and testing.',
        topics: ['Django', 'FastAPI', 'Testing', 'Databases'],
        difficulty: 'Easy',
        duration: '40 mins',
        createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      ),
      InterviewItem(
        id: '5',
        jobTitle: 'DevOps Engineer',
        company: 'CloudOps Solutions', // Added company
        jobDescription: 'Infrastructure automation, CI/CD pipelines, and cloud deployment strategies.',
        topics: ['Docker', 'Kubernetes', 'AWS', 'Jenkins'],
        difficulty: 'Medium',
        duration: '50 mins',
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      InterviewItem(
        id: '6',
        jobTitle: 'React Developer',
        company: 'Frontend Masters', // Added company
        jobDescription: 'Frontend development specializing in React ecosystem and modern JavaScript.',
        topics: ['React Hooks', 'Redux', 'TypeScript', 'Testing'],
        difficulty: 'Medium',
        duration: '45 mins',
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      InterviewItem(
        id: '7',
        jobTitle: 'Blockchain Developer',
        company: 'Crypto Innovations', // Added company
        jobDescription: 'Smart contract development and DApp creation on various blockchain platforms.',
        topics: ['Solidity', 'Ethereum', 'Web3', 'DeFi'],
        difficulty: 'Hard',
        duration: '65 mins',
        createdAt: DateTime.now(),
      ),
      InterviewItem(
        id: '8',
        jobTitle: 'Database Administrator',
        company: 'DataGuard Services', // Added company
        jobDescription: 'Database design, optimization, and maintenance for high-performance applications.',
        topics: ['SQL', 'PostgreSQL', 'Performance Tuning', 'Backup'],
        difficulty: 'Medium',
        duration: '55 mins',
        createdAt: DateTime.now(),
      ),
    ];
  }
}