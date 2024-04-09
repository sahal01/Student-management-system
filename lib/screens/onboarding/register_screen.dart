import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms/const/colors.dart';
import 'package:sms/const/styles.dart';
import 'package:sms/providers/onBoardingProvider.dart';
import 'package:sms/screens/onboarding/widgets/drop_down.dart';
import 'package:sms/widgets/buttons.dart';
import 'package:sms/widgets/decoration.dart';
import 'package:sms/widgets/textfield.dart';



class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static String routeName = "/register_screen";

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GestureDetector( onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
        child: Consumer<OnBoardingProvider>(
          builder: (
              context,
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
                  key: provider.regFormKey,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFieldWidget().normalTF(
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
                            controller: provider.email,
                            label: "Email",
                            icon: Icons.person_rounded,
                          ),
const SizedBox(height: 20,),
                          TextFieldWidget().numberTF(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Admission Number required!";
                              }
                              return null;
                            },
                            controller: provider.admissionNo,
                            label: "Admission Number",
                            icon: Icons.person_rounded,
                          ),
                          TextFieldWidget().normalTF(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "name required!";
                              }
                              return null;
                            },
                            controller: provider.firstName,
                            label: "First name",
                            icon: Icons.person_rounded,
                          ),
                          const SizedBox(
                            height: 20,
                          ),TextFieldWidget().normalTF(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "name required!";
                              }
                              return null;
                            },
                            controller: provider.lastName,
                            label: "Last name",
                            icon: Icons.person_rounded,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DropDown()
                              .chooseDivision(context: context, w: w),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFieldWidget().passwordTF(
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Password required!";
                                }
                                return null;
                              },
                              controller: provider.password,
                              label: "Password",
                              icon: Icons.vpn_key_rounded,
                              show: provider.showPassword
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFieldWidget().passwordTF(
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Confirm Password required!";
                                }
                                if(val != provider.password.text){
                                  return "Password Mismatch!";
                                }
                                return null;
                              },
                              controller: provider.confirmPassword,
                              label: "Confirm Password",
                              icon: Icons.vpn_key_rounded,
                              show: provider.showPassword
                          ),



                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: (){
                              provider.passwordVisibility();
                            },
                            child: Row(
                              children: [
                                Icon(provider.showPassword == false ? Icons.check_box : Icons.check_box_outline_blank_outlined,color: white,),
                                SizedBox(width: 10,),
                                Text("show password",style: Styles().normalS(fontW: FontWeight.w400, fontS: 15, color: white, fontFamily: ''),)
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Buttons().primaryB(w: w, title: "Register", onT: (){
                            FocusScope.of(context).requestFocus(FocusNode());
                             provider.registerUser();

                          }),
                          const SizedBox(
                            height: 60,
                          ),
                          InkWell(
                              onTap: (){
                                provider.reset();
                                Navigator.pop(context);
                              },
                              child: Text("Already Registered. Login Me!",style: Styles().normalS(fontW: FontWeight.w600, fontS: 15, color: white, fontFamily: ''),)),
                        ],
                      ),
                    ),
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
