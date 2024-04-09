import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms/Services/api_urls.dart';
import 'package:sms/const/colors.dart';
import 'package:sms/const/styles.dart';
import 'package:sms/providers/onBoardingProvider.dart';
import 'package:sms/providers/tutorProvider.dart';
class BottomAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double curveHeight = size.height * 0.3; // Adjust the curve height as needed

    // Start from top-left corner
    path.moveTo(0, curveHeight);

    // Top-left curve
    path.quadraticBezierTo(0, 0, curveHeight, 0);

    // Top edge
    path.lineTo(size.width - curveHeight, 0);

    // Top-right curve
    path.quadraticBezierTo(size.width, 0, size.width, curveHeight);

    // Right edge
    path.lineTo(size.width, size.height - curveHeight);

    // Bottom-right curve
    path.quadraticBezierTo(size.width, size.height, size.width - curveHeight, size.height);

    // Bottom edge
    path.lineTo(curveHeight, size.height);

    // Bottom-left curve
    path.quadraticBezierTo(0, size.height, 0, size.height - curveHeight);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class BottomNavs {
  Widget bottomBarUI(BuildContext context2, double w) {
    return Consumer<TutorProvider>(builder: (context, provider, child) {
      return ClipPath(
        clipper: BottomAppBarClipper(), 
        child: BottomAppBar(
          elevation: 6,
          shape: const CircularNotchedRectangle(),
          notchMargin: 4,
          clipBehavior: Clip.antiAlias,
          color: black,
          child: SizedBox(
            height: w > 600 ? 80 : 75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  splashColor: black,
                  highlightColor: black,
                  onTap: () async {
                    Provider.of<OnBoardingProvider>(context, listen: false). fetchUserMarks(
                      admissionNo: ApiUrls.userData!.admissionNo,
                      firstName: ApiUrls.userData!.firstName,
                      lastName: ApiUrls.userData!.lastName,
                    );
                    provider.changeBottom(0);



                  },
                  child: SizedBox(width: w/3,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 6,
                            bottom: 6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              provider.bottomIndex == 0
                                  ? "assets/home_filled.png"
                                  : "assets/home_unfilled.png",
                              height: w > 600 ? 22 : 20,
                              color: provider.bottomIndex == 0 ? white : grey,
                            ),
                            Text(
                              "Home",
                              style: Styles().normalS(
                                  fontW: FontWeight.w300,
                                  fontS: w > 600 ? 11 : 9,
                                  color: provider.bottomIndex == 0 ? white : grey,
                                  fontFamily: 'GothamLight'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: black,
                  highlightColor: black,
                  onTap: () async {
                    Provider.of<OnBoardingProvider>(context, listen: false).fetchMessages();
                    provider.changeBottom(1);

                  },
                  child: SizedBox(width: w/3,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              provider.bottomIndex == 1
                                  ? "assets/ticket_filled.png"
                                  : "assets/ticket_unfilled.png",
                              height: w > 600 ? 22 : 20,
                              color: provider.bottomIndex == 1 ? white : grey,
                            ),
                            Text(
                              "Messages",
                              style: Styles().normalS(
                                  fontW: FontWeight.w300,
                                  fontS: w > 600 ? 11 : 9,
                                  color: provider.bottomIndex == 1 ? white : grey,
                                  fontFamily: 'GothamLight'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: black,
                  highlightColor: black,
                  onTap: () async {
                    provider.changeBottom(2);

                  },
                  child: SizedBox(width: w/3,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              provider.bottomIndex == 2
                                  ? "assets/profile_filled.png"
                                  : "assets/profile_unfilled.png",
                              height: w > 600 ? 22 : 20,
                              color: provider.bottomIndex == 2 ? white : grey,
                            ),
                            Text(
                              "Profile",
                              style: Styles().normalS(
                                  fontW: FontWeight.w300,
                                  fontS: w > 600 ? 11 : 9,
                                  color: provider.bottomIndex == 3 ? white : grey,
                                  fontFamily: 'GothamLight'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
