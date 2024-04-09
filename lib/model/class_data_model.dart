import 'package:sms/model/subject_data_model.dart';

class ClassData {
  late final String id;
  final String grade;
  final List<SubjectData> subjects;

  ClassData({
    required this.id,
    required this.grade,
    required this.subjects,
  });

  factory ClassData.fromJson(Map<String, dynamic> json) {
    return ClassData(
      id: json['id'],
      grade: json['grade'],
      subjects: List<SubjectData>.from(
        json['subjects'].map((subjectJson) => SubjectData.fromJson(subjectJson)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'grade': grade,
      'subjects': subjects.map((subject) => subject.toJson()).toList(),
    };
  }
}
