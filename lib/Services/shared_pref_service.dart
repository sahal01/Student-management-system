

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms/model/user_model.dart';
import 'package:sms/providers/onBoardingProvider.dart';
import 'package:sms/providers/tutorProvider.dart';

class SharedPrefService {
  static const String emailKey = "email";
  static const String passwordKey = "password";
  static const String userDetailKey = "userdetails";
  String isTutor = "tutor";
  Future<void> setTutor(bool Tutor) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(isTutor, Tutor);
  }

  Future<bool?> getTutor() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(isTutor);
  }

   Future<void> setUserData(UserData userData) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userDataJson = jsonEncode(userData.toJson());
    pref.setString(userDetailKey, userDataJson);
  }

   Future<UserData?> getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userDataJson = pref.getString(userDetailKey);
    if (userDataJson != null) {
      Map<String, dynamic> userDataMap = jsonDecode(userDataJson);
      return UserData.fromJson(userDataMap);
    } else {
      return null;
    }
  }


  Future<void> setLoginCredentials(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(emailKey, email);
    await prefs.setString(passwordKey, password);
  }

  Future<List<String>> getLoginCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerId = prefs.getString(emailKey);
    String? password = prefs.getString(passwordKey);
    List<String> credentials = [];

    if (customerId != null && password != null) {
      credentials.add(customerId);
      credentials.add(password);
    }

    return credentials;
  }

  clear(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Provider.of<OnBoardingProvider>(context, listen: false). resetLoginForm();
    Provider.of<TutorProvider>(context, listen: false).changeBottom(0);


    pref.clear();
  }
}
