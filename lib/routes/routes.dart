import 'package:flutter/material.dart';
import 'package:sms/screens/Student/dashboard/main_screen.dart';
import 'package:sms/screens/Student/mark_view_screen.dart';
import 'package:sms/screens/Tutor/add_class_and%20_subject_screen.dart';
import 'package:sms/screens/Tutor/class_list_screen.dart';
import 'package:sms/screens/Tutor/dashboard/main_screen.dart';
import 'package:sms/screens/Tutor/mark_upload_screen.dart';
import 'package:sms/screens/Tutor/students_list_screen.dart';
import 'package:sms/screens/Tutor/message_screen.dart';
import 'package:sms/screens/onboarding/login_screen.dart';
import 'package:sms/screens/onboarding/register_screen.dart';
import 'package:sms/screens/onboarding/splash_screen.dart';



Map<String, WidgetBuilder> routes() {
  return {
    SplashScreen.routeName: (ctx) => const SplashScreen(),
    LoginScreen.routeName: (ctx) => const LoginScreen(),
    RegisterScreen.routeName: (ctx) => const RegisterScreen(),
    MessageScreen.routeName: (ctx) => const MessageScreen(),
    StudentDashBoardScreen.routeName: (ctx) =>  StudentDashBoardScreen(),
    AddClassAndSubjectsForm.routeName: (ctx) => const AddClassAndSubjectsForm(),
    StudentsListScreen.routeName: (ctx) => const StudentsListScreen(),
    ClassListScreen.routeName: (ctx) => const ClassListScreen(),
    MarkUploadScreen.routeName: (ctx) => const MarkUploadScreen(),
    TutorDashBoardScreen.routeName: (ctx) =>  TutorDashBoardScreen(),
    MarkViewScreen.routeName: (ctx) =>  const MarkViewScreen(),


  };
}
