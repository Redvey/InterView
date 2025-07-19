import '../models/question.dart';

class QuestionService {
  // Sample data
  static final List<Question> _allQuestions = [
    // Python Questions
    Question(
      id: 'py_001',
      topic: 'Python',
      question: 'What is the difference between list and tuple in Python?',
      answer: 'Lists are mutable (can be changed after creation) and use square brackets [], while tuples are immutable (cannot be changed) and use parentheses (). Lists have methods like append(), remove(), while tuples don\'t have such methods.',
      type: QuestionType.openEnded,
    ),
    Question(
      id: 'py_002',
      topic: 'Python',
      question: 'Which of these is used for exception handling in Python?',
      options: ['try-catch', 'try-except', 'catch-throw', 'handle-error'],
      answer: 'try-except is used for exception handling in Python. The try block contains code that might raise an exception, and the except block handles the exception.',
      type: QuestionType.multipleChoice,
    ),
    Question(
      id: 'py_003',
      topic: 'Python',
      question: 'What is a lambda function in Python?',
      answer: 'Lambda functions are anonymous functions in Python that can have any number of arguments but can only have one expression. Syntax: lambda arguments: expression. Example: square = lambda x: x**2',
      type: QuestionType.openEnded,
    ),

    // Flutter Questions
    Question(
      id: 'fl_001',
      topic: 'Flutter',
      question: 'How do you implement animation in Flutter applications?',
      answer: 'You can implement animations in Flutter using AnimationController, Tween, and AnimatedBuilder widgets. AnimationController controls the animation duration and playback, Tween defines the range of values, and AnimatedBuilder rebuilds widgets during animation.',
      type: QuestionType.openEnded,
    ),
    Question(
      id: 'fl_002',
      topic: 'Flutter',
      question: 'What is the difference between StatefulWidget and StatelessWidget?',
      answer: 'StatelessWidget is immutable and doesn\'t change during the lifetime of the widget. StatefulWidget can change its state during runtime using setState() method and can rebuild the UI when state changes.',
      type: QuestionType.openEnded,
    ),
    Question(
      id: 'fl_003',
      topic: 'Flutter',
      question: 'Which method is called when a StatefulWidget is disposed?',
      options: ['initState()', 'dispose()', 'build()', 'createState()'],
      answer: 'dispose() method is called when a StatefulWidget is removed from the widget tree permanently. It\'s used to clean up resources like controllers, subscriptions, etc.',
      type: QuestionType.multipleChoice,
    ),

    // Java Questions
    Question(
      id: 'java_001',
      topic: 'Java',
      question: 'What is the difference between JDK, JRE, and JVM?',
      answer: 'JVM (Java Virtual Machine) executes Java bytecode. JRE (Java Runtime Environment) includes JVM + libraries needed to run Java apps. JDK (Java Development Kit) includes JRE + development tools like compiler, debugger.',
      type: QuestionType.openEnded,
    ),
    Question(
      id: 'java_002',
      topic: 'Java',
      question: 'Which keyword is used to inherit a class in Java?',
      options: ['inherits', 'extends', 'implements', 'super'],
      answer: 'extends keyword is used for class inheritance in Java. Example: class Child extends Parent { }',
      type: QuestionType.multipleChoice,
    ),

    // Add more questions for other topics...
    // JavaScript
    Question(
      id: 'js_001',
      topic: 'Javascript',
      question: 'What is the difference between let, const, and var?',
      answer: 'var has function scope and is hoisted. let has block scope and is not hoisted. const has block scope, is not hoisted, and cannot be reassigned after declaration.',
      type: QuestionType.openEnded,
    ),

    // React
    Question(
      id: 'react_001',
      topic: 'React',
      question: 'What is the purpose of useEffect hook?',
      answer: 'useEffect hook is used to perform side effects in functional components. It can handle componentDidMount, componentDidUpdate, and componentWillUnmount lifecycle methods. It runs after every render by default.',
      type: QuestionType.openEnded,
    ),
  ];

  static List<Question> getQuestionsForTopic(String topic) {
    return _allQuestions
        .where((q) => q.topic.toLowerCase() == topic.toLowerCase())
        .toList();
  }

  static List<String> getAllTopics() {
    return _allQuestions.map((q) => q.topic).toSet().toList();
  }

  static int getTotalQuestionsForTopic(String topic) {
    return getQuestionsForTopic(topic).length;
  }

  /// Validates and adds a question to the collection.
  ///
  /// Throws [ArgumentError] if the question fails validation.
  /// Validation checks include:
  /// - Non-null and non-empty required fields
  /// - Unique question ID
  /// - Valid options for multiple choice questions
  /// - Proper question format
  static void addQuestion(Question question) {
    _validateQuestion(question);
    _allQuestions.add(question);
  }

  /// Validates a question object for data integrity.
  ///
  /// Throws [ArgumentError] if validation fails.
  static void _validateQuestion(Question question) {
    // Check for null question
    if (question.id.trim().isEmpty) {
      throw ArgumentError('Question ID cannot be null or empty');
    }

    // Check for duplicate ID
    if (_allQuestions.any((q) => q.id == question.id)) {
      throw ArgumentError('Question with ID "${question.id}" already exists');
    }

    // Validate topic
    if (question.topic.trim().isEmpty) {
      throw ArgumentError('Question topic cannot be null or empty');
    }

    // Validate question text
    if (question.question.trim().isEmpty) {
      throw ArgumentError('Question text cannot be null or empty');
    }

    // Question text should be reasonable length
    if (question.question.trim().length < 5) {
      throw ArgumentError('Question text must be at least 5 characters long');
    }

    // Validate answer
    if (question.answer.trim().isEmpty) {
      throw ArgumentError('Question answer cannot be null or empty');
    }

    // Answer should be reasonable length
    if (question.answer.trim().length < 3) {
      throw ArgumentError('Answer must be at least 3 characters long');
    }

    // Validate multiple choice specific requirements
    if (question.type == QuestionType.multipleChoice) {
      if (question.options == null || question.options!.isEmpty) {
        throw ArgumentError('Multiple choice questions must have options');
      }

      if (question.options!.length < 2) {
        throw ArgumentError('Multiple choice questions must have at least 2 options');
      }

      if (question.options!.length > 6) {
        throw ArgumentError('Multiple choice questions cannot have more than 6 options');
      }

      // Check for duplicate options
      final uniqueOptions = question.options!.toSet();
      if (uniqueOptions.length != question.options!.length) {
        throw ArgumentError('Multiple choice options must be unique');
      }

      // Check for empty options
      if (question.options!.any((option) => option.trim().isEmpty)) {
        throw ArgumentError('All multiple choice options must be non-empty');
      }
    } else {
      // For non-multiple choice questions, options should be null or empty
      if (question.options != null && question.options!.isNotEmpty) {
        throw ArgumentError('Non-multiple choice questions should not have options');
      }
    }

    // Validate ID format (should contain only alphanumeric characters, underscores, and hyphens)
    final idRegex = RegExp(r'^[a-zA-Z0-9_-]+$');
    if (!idRegex.hasMatch(question.id)) {
      throw ArgumentError('Question ID can only contain letters, numbers, underscores, and hyphens');
    }

    // Validate topic format (should not contain special characters except spaces)
    final topicRegex = RegExp(r'^[a-zA-Z0-9\s]+$');
    if (!topicRegex.hasMatch(question.topic.trim())) {
      throw ArgumentError('Topic can only contain letters, numbers, and spaces');
    }
  }

  /// Safely adds a question with validation, returning success status.
  ///
  /// Returns [true] if the question was successfully added, [false] otherwise.
  /// This method catches validation errors and handles them gracefully.
  static bool tryAddQuestion(Question question) {
    try {
      addQuestion(question);
      return true;
    } catch (e) {
      // Log error or handle as needed
      print('Failed to add question: $e');
      return false;
    }
  }

  // Method to load questions from JSON (for future use)
  static Future<List<Question>> loadQuestionsFromJson(String jsonString) async {
    // Implementation to load from JSON file or API
    // This is where you'd parse JSON and return List<Question>
    return [];
  }
}