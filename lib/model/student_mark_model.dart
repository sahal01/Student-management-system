class StudentMark {
  final String admissionNo;
  final String firstName;
  final String lastName;
  final String examName;
  final String attendance;
  final int attendanceMonth;
  final String date;
  final Map<String, int> marks;

  StudentMark({
    required this.admissionNo,
    required this.firstName,
    required this.lastName,
    required this.examName,
    required this.attendance,
    required this.attendanceMonth,
    required this.date,
    required this.marks,
  });

  factory StudentMark.fromJson(Map<String, dynamic> json) {
    return StudentMark(
      admissionNo: json['admissionNo'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      examName: json['examName'] ?? '',
      attendance: json['attendance'] ?? '',
      attendanceMonth: json['attendance_month'] ?? 0,
      date: json['date'] ?? '',
      marks: Map<String, int>.from(json['marks'] ?? {}),
    );
  }
}
