import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms/const/colors.dart';
import 'package:sms/const/styles.dart';
import 'package:sms/providers/onBoardingProvider.dart';
import 'package:sms/screens/onboarding/register_screen.dart';
import 'package:sms/widgets/buttons.dart';
import 'package:sms/widgets/decoration.dart';
import 'package:sms/widgets/textfield.dart';



class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static String routeName = "/login_screen";

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Consumer<OnBoardingProvider>(
          builder: (
            context2,
            provider,
            child,
          ) {
            return Container(
              height: h,
              width: w,
              decoration: DecorationWidget().gradientDecoration(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 20,
                ),
                child: Form(
                  key: provider.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFieldWidget().emailTF(
                        validator: (val) {
                          if (val!.isEmpty ) {
                            return "Valid Email required!";
                          }
                          else if(RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(val.toString())){
                            return null;
                          }
                          else{
                            return "Valid Email required!";
                          }
                        },
                        controller: provider.loginEmail,
                        label: "Email",
                        icon: Icons.person_rounded,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Password required!";
                          }
                          return null;
                        },
                        obscureText: provider.showPassword,
                        controller: provider.loginPass,
                        style: Styles().normalS(
                            fontW: FontWeight.w400, fontS: 14, color: white, fontFamily: ''),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(8), // Adjust the radius as needed
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25), // Adjust the radius as needed
                          ),
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0),
                          prefixIcon: Icon(
                            Icons.key_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 40,
                      ),
                      Buttons().primaryB(
                          w: w,
                          title: "Login",
                          onT: () async {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            if (provider.formKey.currentState!.validate()) {
                              // ApiUrls().getUserType();
                               provider.loginUser(context);
                            }
                            //print(provider.testUser);

                          }),

                      const SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () {
                          provider.testUserCheck();
                        },
                        child: Row(mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              provider.testUser
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank_outlined,
                              color: white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Tutor",
                              style: Styles().normalS(
                                  fontW: FontWeight.w400,
                                  fontS: 15,
                                  color: white, fontFamily: ''),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 40,
                      ),
                      InkWell(
                          onTap: ()async {
                            provider.resetForm();
                            Navigator.pushNamed(
                                context, RegisterScreen.routeName);
                          },
                          child: Text(
                            "Not a member? Get registered",
                            style: Styles().normalS(
                                fontW: FontWeight.w400,
                                fontS: 15,
                                color: white, fontFamily: ''),
                          )),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
