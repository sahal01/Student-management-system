import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:sms/model/class_data_model.dart';
import 'package:sms/model/user_model.dart';
import 'package:sms/screens/Tutor/mark_upload_screen.dart';
import 'package:sms/screens/Tutor/students_list_screen.dart';
import 'package:sms/widgets/utility_widget.dart';

class TutorProvider extends ChangeNotifier {

  int bottomIndex = 0;
  Map<String, int> marksData = {};
  String examName = "";
  String attendance = "";

  GlobalKey<FormState> formKeys = GlobalKey<FormState>();
  GlobalKey<FormState> formKeys2 = GlobalKey<FormState>();


  void changeBottom(int index) {
    bottomIndex = index;
    notifyListeners();
  }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addClassAndSubjectToFirestore(ClassData classData, {bool isEditMode = false}) async {
    try {
      if (!isEditMode) {
        // Add new class
        await _firestore.collection('classes').add(classData.toJson());
        UtilityWidget().showSnack(msg: "Class Added successfully");

      } else {
        // Update existing class
        await _firestore.collection('classes').doc(classData.id).set(classData.toJson());
      }
      notifyListeners();
    } catch (e) {
      UtilityWidget().showSnack(msg: "Failed to add Class");

      print('Error adding class and subject: $e');
      throw e; // Rethrow the error for handling in UI if needed
    }
  }

  Future<void> updateClassAndSubjectsInFirestore(ClassData classData) async {
    try {
      // Get the reference to the document
      final DocumentReference classRef = _firestore.collection('classes').doc(classData.id);

      // Check if the document exists
      final DocumentSnapshot docSnapshot = await classRef.get();

      if (docSnapshot.exists) {
        // Update the specific fields of the class document
        await classRef.update({
          'grade': classData.grade,
          'subjects': classData.subjects.map((subject) => subject.toJson()).toList(),
        });
        print('Document updated successfully.');
      } else {
        print('Document does not exist.');
        // Handle the case where the document does not exist
      }

      // Notify listeners to update UI
      notifyListeners();
    } catch (e) {
      print('Error updating class and subjects: $e');
      throw e; // Rethrow the error for handling in UI if needed
    }
  }

  Future<bool> checkClassExistsInFirestore(String grade) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('classes').where('grade', isEqualTo: grade).get();
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking class existence: $e');
      throw e; // Rethrow the error for handling in UI if needed
    }
  }

  Future<String?> fetchExistingClassId(String grade) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('classes')
          .where('grade', isEqualTo: grade)
          .limit(1) // Limit to one document
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id; // Return the ID of the first document
      } else {
        return null; // No existing class found
      }
    } catch (e) {
      print('Error fetching existing class ID: $e');
      return null;
    }
  }


  List<UserData> students = [];
  UserData? selectedStudent ;

  Future<List<UserData>> fetchStudentsByDivision(String division,BuildContext context) async {

    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('division', isEqualTo: division)
          .get();

      students = querySnapshot.docs
          .map((doc) => UserData.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      Navigator.pushNamed(
          context, StudentsListScreen.routeName);
    } catch (e) {
      print('Error fetching students: $e');
    }

    return students;
  }

  ClassData? classDetails;
  Future<ClassData?> fetchClassDetails(String grade, BuildContext context, int index) async {
    classDetails = null;
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('classes').where('grade', isEqualTo: grade).get();
      print('Query Snapshot Size: ${querySnapshot.size}');

      if (querySnapshot.size > 0) {
        // Assuming there is only one document with the specified grade
        DocumentSnapshot classSnapshot = querySnapshot.docs.first;
        print('Class Snapshot Data: ${classSnapshot.data()}');

        Map<String, dynamic> classData = classSnapshot.data() as Map<String, dynamic>;
        classDetails = ClassData.fromJson(classData);
        selectedStudent = students[index];

        Navigator.pushNamed(
          context,
          MarkUploadScreen.routeName,
        );
        return classDetails;
      } else {
        print('Class not found for grade: $grade');
        UtilityWidget().showSnack(msg: "Class not found for grade: $grade");

        return null;
      }
    } catch (e) {
      print('Error fetching class details: $e');
      UtilityWidget().showSnack(msg: "Error fetching class details");

      throw e;
    }
  }


  selectedStudents(int index, BuildContext context)async{
   await fetchClassDetails(students[index].division,context,index);

}


  Future<void> uploadUserMarks({
    required String admissionNo,
    required String firstName,
    required String lastName,
    required String examName,
    required String attendance,
    required Map<String, int> marksData,
    required BuildContext context, required int month,
  }) async {
    try {
      // Create a new collection 'user_mark' in Firestore
      CollectionReference userMarksCollection = _firestore.collection('user_mark');

      // Add user details and marks to the collection
      await userMarksCollection.add({
        'admissionNo': admissionNo,
        'firstName': firstName,
        'lastName': lastName,
        'examName': examName,
        'attendance': attendance,
        'attendance_month': month,
        'date':DateFormat("dd MMM , yyyy").format( DateTime.now()),
        'marks': marksData, // Add the marks data to Firestore
      });
      UtilityWidget().showSnack(msg: "User marks uploaded");
      Navigator.pop(context);

    } catch (e) {
      print('Error uploading user marks: $e');
      UtilityWidget().showSnack(msg: "Error uploading user marks");

    }
  }
  String _message = '';

  String get message => _message;

  void setMessage(String value) {
    _message = value;
    notifyListeners();
  }

  void sendMessage(BuildContext context) async {
    // Get the current date and time
    String currentDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    // Create a new document in Firestore with the message and date
    try {
      await FirebaseFirestore.instance.collection('messages').add({
        'message': _message,
        'date': currentDate,
      });
      UtilityWidget().showSnack(msg: "Message sent successfully");
changeBottom(0);
notifyListeners();
    } catch (e) {
      UtilityWidget().showSnack(msg: "error sending message: $e");

      print('Error sending message: $e');
    }
  }
}
