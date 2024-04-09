import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms/Services/shared_pref_service.dart';
import 'package:sms/const/colors.dart';
import 'package:sms/const/styles.dart';
import 'package:sms/screens/onboarding/login_screen.dart';
import 'package:sms/widgets/buttons.dart';


class UtilityWidget {
  showSnack({required String msg}) {
    try {


      return Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black.withOpacity(0.7),
          textColor: Colors.white,
          fontSize: 14.0
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }





  logout(BuildContext context) {
    return showDialog(
        context: context,
        builder: (dialogContext) {

            return Dialog(
                backgroundColor: Colors.white,
                insetPadding: const EdgeInsets.symmetric(horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 35, right: 20, top: 35, bottom: 25),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/warning.png", height: 55),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Do You Want To Logout",
                              style: Styles().lineGapS(
                                  fontW: FontWeight.w500,
                                  fontS: 18,
                                  color: black,
                                  fontFamily: 'GothamMedium',
                                  height: 1.3),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.of(dialogContext).pop();
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: Styles().normalS(
                                          fontW: FontWeight.w500,
                                          fontS: 18,
                                          color: black,
                                          fontFamily: 'GothamMedium'),
                                    )),
                                Buttons().primaryB(
                                    w: 120,
                                    title: "Logout",
                                    onT: () {
                                      SharedPrefService prefs = SharedPrefService();
                                      prefs.clear(context);
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        LoginScreen.routeName,
                                            (route) => false,
                                      );
                                    },
                                ),
                              ],
                            ),
                          ])),
                ));
          });

  }



  showLoader() {
    return Center(
      child: Image.asset(
        "assets/loader.gif",
        height: 50,
        color: primary,
      ),
    );
  }
}
