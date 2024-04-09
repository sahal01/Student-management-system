import 'package:flutter/material.dart';
import 'package:sms/Services/api_urls.dart';
import 'package:sms/const/colors.dart';
import 'package:sms/const/styles.dart';
import 'package:sms/widgets/decoration.dart';
import 'package:sms/widgets/utility_widget.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static String routeName = "/profile_screen";

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false, // Disable the back button
        title: Text('My Profile'),
      ),      body: Container(
        decoration: DecorationWidget().gradientDecoration(),
        child:
          SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  color: white,
                  width: w,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 240, left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child:


                          Column(
                            children: [
                              Text(
                                "${ApiUrls.userData!.firstName.toString()} ${ApiUrls.userData!.lastName.toString()}",
                                style: Styles().normalS(
                                    fontW: FontWeight.w600,
                                    fontS: 22,
                                    color: black,
                                    fontFamily: "GothamMedium"),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/about.png",
                                    height: 20,
                                    width: 20,
                                    color: grey,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text("Admission Number : ${ApiUrls.userData!.admissionNo}",
                                      style: Styles().normalS(
                                          fontW: FontWeight.w500,
                                          fontS: 14,
                                          color: black,
                                          fontFamily: "GothamLight")),
                                ],
                              ),
                              Icon(
                                Icons.keyboard_arrow_right_outlined,
                                color: grey,
                              )
                            ],
                          ),
                        ),

                        Divider(
                          color: dropDownGrey,
                          thickness: 0.5,
                        ),
                        SizedBox(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/about.png",
                                    height: 20,
                                    width: 20,
                                    color: grey,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text("Class : ${ApiUrls.userData!.division}",
                                      style: Styles().normalS(
                                          fontW: FontWeight.w500,
                                          fontS: 14,
                                          color: black,
                                          fontFamily: "GothamLight")),
                                ],
                              ),
                              Icon(
                                Icons.keyboard_arrow_right_outlined,
                                color: grey,
                              )
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),


                        Divider(
                          color: dropDownGrey,
                          thickness: 0.5,
                        ),


                        const SizedBox(
                          height: 10,
                        ),



                        InkWell(
                          onTap: () {
                            UtilityWidget().logout(context);
                          },
                          child: SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/sign-out.png",
                                  height: 20,
                                  width: 20,
                                  color: grey,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text("Logout",
                                    style: Styles().normalS(
                                        fontW: FontWeight.w500,
                                        fontS: 14,
                                        color: black,
                                        fontFamily: "GothamLight")),
                              ],
                            ),
                          ),
                        ),

                        Divider(
                          color: dropDownGrey,
                          thickness: 0.5,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text("Version - 1.0.0",
                            style: Styles().normalS(
                                fontW: FontWeight.normal,
                                fontS: 15,
                                color: g3.withOpacity(0.6),
                                fontFamily: "GothamLight")),
                        const SizedBox(
                          height: 25,
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 0.0,
                    child: Container(
                      height: 160,
                      width: w,
                      decoration: BoxDecoration(
                          color: black,
                          border: Border.all(
                            color: background,
                            width: 0,
                          )),
                    )),
                Positioned(
                  top: 105,
                  left: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: white,
                    child: CircleAvatar(
                      backgroundColor: gold,
                      radius: 58,
                      child: Center(
                        child:
                           Text(
                            ApiUrls.userData!.firstName![0],
                            style: Styles().normalS(
                                fontW: FontWeight.w500,
                                fontS: 25,
                                color: white,
                                fontFamily: "GothamMedium"),
                          )

                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
