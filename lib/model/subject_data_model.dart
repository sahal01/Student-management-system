import 'dart:convert';

class SubjectData {
  final String subjectName;
  final String teacher;
  final Map<String, int> marks;

  SubjectData({
    required this.subjectName,
    required this.teacher,
    required this.marks,
  });

  factory SubjectData.fromJson(Map<String, dynamic> json) {
    return SubjectData(
      subjectName: json['subjectName'],
      teacher: json['teacher'],
      marks: Map<String, int>.from(json['marks'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subjectName': subjectName,
      'teacher': teacher,
      'marks': marks,
    };
  }
}
