import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms/const/colors.dart';
import 'package:sms/providers/tutorProvider.dart';
import 'package:sms/screens/Student/dashboard/widgets/bottom_navigation.dart';
import 'package:sms/screens/Student/mark_view_screen.dart';
import 'package:sms/screens/Student/message_view_screen.dart';
import 'package:sms/screens/Student/profile_screen.dart';


class StudentDashBoardScreen extends StatelessWidget {
  StudentDashBoardScreen({super.key});

  static String routeName = "/student_dashboard_screen";

  final _pages = [
    const MarkViewScreen(),
    const MessageViewScreen(),
    const ProfileScreen(),

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
      bottomNavigationBar: BottomNavs().bottomBarUI(context, w),
    );
  }
}
