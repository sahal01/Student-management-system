import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms/const/colors.dart';
import 'package:sms/providers/tutorProvider.dart';
import 'package:sms/screens/Tutor/add_class_and%20_subject_screen.dart';
import 'package:sms/screens/Tutor/class_list_screen.dart';
import 'package:sms/screens/Tutor/dashboard/widgets/bottom_navigation.dart';
import 'package:sms/screens/Tutor/message_screen.dart';
import 'package:sms/screens/Tutor/students_list_screen.dart';

class TutorDashBoardScreen extends StatelessWidget {
  TutorDashBoardScreen({super.key});

  static String routeName = "/tutor_dashboard_screen";

  final _pages = [
    const ClassListScreen(),
    const AddClassAndSubjectsForm(),
    const MessageScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      body: Consumer<TutorProvider>(
        builder: (context, provider, child) {
          return _pages[provider.bottomIndex];
        },
      ),
      bottomNavigationBar: BottomNav().bottomBarUI(context, w),
    );
  }
}
