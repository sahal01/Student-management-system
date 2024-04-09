import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms/Services/api_urls.dart';
import 'package:sms/Services/shared_pref_service.dart';
import 'package:sms/const/colors.dart';
import 'package:sms/providers/onBoardingProvider.dart';
import 'package:sms/providers/tutorProvider.dart';
import 'package:sms/screens/Student/dashboard/main_screen.dart';
import 'package:sms/screens/Tutor/dashboard/main_screen.dart';
import 'package:sms/screens/onboarding/login_screen.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static String routeName = "/splash_screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    timer();
  }

  timer() async {
    Timer(const Duration(seconds: 2), () async {

      Provider.of<TutorProvider>(context, listen: false).changeBottom(0);
      await  Provider.of<OnBoardingProvider>(context, listen: false).fetchClasses();


      SharedPrefService prefs = SharedPrefService();
      List<String> credentials = await prefs.getLoginCredentials();

      if (credentials.isNotEmpty) {
        await prefs.getUserData().then((value) {
          ApiUrls.userData = value;
        });
        await prefs.getTutor().then((value) {
        if(value==false){
          Provider.of<OnBoardingProvider>(context, listen: false). fetchUserMarks(
          admissionNo: ApiUrls.userData!.admissionNo,
          firstName: ApiUrls.userData!.firstName,
          lastName: ApiUrls.userData!.lastName,
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            StudentDashBoardScreen.routeName,
                (route) => false,
          );
        }else{
          Navigator.pushNamedAndRemoveUntil(
            context,
            TutorDashBoardScreen.routeName,
                (route) => false,);
        }
        });


      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginScreen.routeName,
              (route) => false,
        );
      }


     // Provider.of<ConnectivityProvider>(context, listen: false).init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      body: Center(
          child: Image.asset(
            "assets/teacher.gif",
        width: w / 3,
      )),
    );
  }
}

