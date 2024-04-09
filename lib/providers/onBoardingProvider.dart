import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sms/Services/api_urls.dart';
import 'package:sms/Services/shared_pref_service.dart';
import 'package:sms/model/class_data_model.dart';
import 'package:sms/model/message_model.dart';
import 'package:sms/model/student_mark_model.dart';
import 'package:sms/model/user_model.dart';
import 'package:sms/screens/Student/dashboard/main_screen.dart';
import 'package:sms/screens/Tutor/dashboard/main_screen.dart';

import 'package:sms/widgets/utility_widget.dart';

class OnBoardingProvider extends ChangeNotifier {

  TextEditingController userName = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool showPassword = true;
  bool obscureText = true;
  bool testUser = false;
  final regFormKey = GlobalKey<FormState>();
  final changePassFormKey = GlobalKey<FormState>();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController admissionNo = TextEditingController();
  TextEditingController division = TextEditingController();
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPass = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');
  UserData? userDetails;
  SharedPrefService pref = SharedPrefService();

  showPass() {
    obscureText = !obscureText;
    notifyListeners();
  }
  testUserCheck(){
    testUser = !testUser;
    notifyListeners();
  }
  passwordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }
  reset() {
    userName.text = "";
    password.text = "";
    formKey.currentState!.reset();
    notifyListeners();
  }
  List<String> classDivision=[];
  List<StudentMark> studentMarks=[];



  Future<void> registerUser() async {
    if (regFormKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text,
        );

        UserData userData = UserData(
          admissionNo: admissionNo.text,
          firstName: firstName.text,
          lastName: lastName.text,
          division: division.text,
        );

        await _usersCollection.doc(userCredential.user!.uid).set(userData.toJson());
        UtilityWidget().showSnack(msg: "User Registered Successfully");

        // Clear form fields after successful registration
        resetForm();

        // Handle success (e.g., navigate to another screen)
      } catch (e) {
        UtilityWidget().showSnack(msg: e.toString());

      }
    }
  }


  Future<void> loginUser(BuildContext context) async {
pref.setTutor(testUser);
    if(testUser==false){
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: loginEmail.text.trim(),
          password: loginPass.text,
        );
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          String userUid = user.uid;
          // Now you have the authenticated user's UID
          try {
            DocumentSnapshot userSnapshot = await _firestore
                .collection('users')
                .doc(userUid)
                .get();

            if (userSnapshot.exists) {
              userDetails = UserData.fromJson(
                  userSnapshot.data() as Map<String, dynamic>);
              pref.setUserData(userDetails!);
              ApiUrls.userData = userDetails;
              await fetchUserMarks(
                admissionNo: userDetails!.admissionNo,
                firstName: userDetails!.firstName,
                lastName: userDetails!.lastName,
              );
              Navigator.pushNamedAndRemoveUntil(
                  context,
                  StudentDashBoardScreen.routeName,
                      (route) => false);
              pref.setLoginCredentials(loginEmail.text, loginPass.text);
              UtilityWidget().showSnack(msg: "Successfully Logged In");

              // You can now use userDetails to access the logged-in user's data
            } else {
              UtilityWidget().showSnack(msg: "User not Registered");
            }
          } catch (e) {
            print('Error fetching user data: $e');
          }
        }



        // Handle login success (e.g., navigate to another screen)
      } catch (e) {
        // Handle login error

        UtilityWidget().showSnack(msg: e.toString());

      }
    }else{

      if(loginEmail.text=="admin@gmail.com"&&loginPass.text=="admin"){
        UtilityWidget().showSnack(msg: "Successfully Logged In");
        pref.setLoginCredentials(loginEmail.text, loginPass.text);
        Navigator.pushNamedAndRemoveUntil(
            context,
            TutorDashBoardScreen.routeName,
                (route) => false);
      }else{
        UtilityWidget().showSnack(msg: "Wrong Admin Credentials");
      }
    }

  }

  void resetForm() {
    email.clear();
    password.clear();
    confirmPassword.clear();
    admissionNo.clear();
    firstName.clear();
    lastName.clear();
    division.clear();
    formKey.currentState!.reset();
  }
  void resetLoginForm() {
    loginEmail.text="";
    loginPass.text="";
    testUser=false;
    notifyListeners();
  }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ClassData>> fetchClasses() async {
    List<ClassData> classes = [];

    try {
      QuerySnapshot querySnapshot = await _firestore.collection('classes').get();
      classDivision=[];
      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        String grade = data['grade']; // Get the 'grade' field from the document
        classDivision.add(grade);
      }
      notifyListeners();
    } catch (e) {
      print('Error fetching classes: $e');
      throw e;
    }

    return classes;
  }


  Future<List<StudentMark>> fetchUserMarks({
    required String admissionNo,
    required String firstName,
    required String lastName,
  }) async {

    try {
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('user_mark')
          .where('admissionNo', isEqualTo: admissionNo)
          .where('firstName', isEqualTo: firstName)
          .where('lastName', isEqualTo: lastName)
          .get();
      studentMarks = [];

      print('Query Snapshot Size: ${userSnapshot.size}');

      for (QueryDocumentSnapshot docSnapshot in userSnapshot.docs) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        StudentMark userMark = StudentMark.fromJson(data);
        studentMarks.add(userMark);
      }
notifyListeners();
      return studentMarks;
    } catch (e) {
      print('Error fetching user marks: $e');
      return []; // Return an empty list in case of an error
    }
  }

  String getMonthText(int monthNumber) {
    switch (monthNumber) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return 'Invalid Month';
    }
  }
  List<Message> messages = [];

  Future<void> fetchMessages() async {
    try {
      // Fetch messages from Firestore
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('messages').get();

      messages.clear(); // Clear existing messages
      // Add fetched messages to the list
      querySnapshot.docs.forEach((doc) {
        messages.add(
          Message(text: doc['message'], timestamp: doc['date']

          ),
        );
      });

      notifyListeners();
    } catch (e) {
      print('Error fetching messages: $e');
    }
  }
}