class Question {
  final String id;
  final String topic;
  final String question;
  final String answer;
  final List<String>? options;
  final QuestionType type;

  Question({
    required this.id,
    required this.topic,
    required this.question,
    required this.answer,
    this.options,
    required this.type,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      topic: json['topic'],
      question: json['question'],
      answer: json['answer'],
      options: json['options'] != null ? List<String>.from(json['options']) : null,
      type: QuestionType.values.firstWhere(
            (e) => e.toString().split('.').last == json['type'],
        orElse: () => QuestionType.openEnded,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'topic': topic,
      'question': question,
      'answer': answer,
      'options': options,
      'type': type.toString().split('.').last,
    };
  }
}

enum QuestionType {
  openEnded,
  multipleChoice,
  trueFalse,
}