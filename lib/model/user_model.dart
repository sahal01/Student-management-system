class UserData {
  final String admissionNo;
  final String firstName;
  final String lastName;
  final String division;

  UserData({
    required this.admissionNo,
    required this.firstName,
    required this.lastName,
    required this.division,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      admissionNo: json['admissionNo'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      division: json['division'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'admissionNo': admissionNo,
      'firstName': firstName,
      'lastName': lastName,
      'division': division,
    };
  }
}