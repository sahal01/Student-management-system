import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms/Services/api_urls.dart';
import 'package:sms/const/colors.dart';
import 'package:sms/const/styles.dart';
import 'package:sms/providers/onBoardingProvider.dart';
import 'package:sms/widgets/utility_widget.dart';
class MarkViewScreen extends StatelessWidget {
  const MarkViewScreen({Key? key});
  static String routeName = "/mark_view_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false, // Disable the back button
        leading: IconButton(
          icon: Icon(Icons.lock),
          onPressed: () {
            UtilityWidget().logout(context);
          },
        ),
        title: Text('Mark List'),
      ),
      body: Consumer<OnBoardingProvider>(
        builder: (context, provider, child) {
          if (provider.studentMarks.isEmpty) {
            return Center(
              child: Text('No data available'),
            );
          } else {
            return RefreshIndicator(onRefresh: ()async{
              Provider.of<OnBoardingProvider>(context, listen: false). fetchUserMarks(
                admissionNo: ApiUrls.userData!.admissionNo,
                firstName: ApiUrls.userData!.firstName,
                lastName: ApiUrls.userData!.lastName,
              );
            },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      ListView.builder(
                        itemCount: provider.studentMarks.length,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {

                            },
                            child: Card(
                              elevation: 5,
                              color: Colors.white.withOpacity(0.8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    SizedBox(height: 10),
                                    Text(
                                      "Exam Name: ${provider.studentMarks[index].examName}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: 'GothamLight',
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Attendance Percentage of ${provider.getMonthText(provider.studentMarks[index].attendanceMonth)} : ${provider.studentMarks[index].attendance}% ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: 'GothamLight',
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    // Display marks and subjects
                                    Column(
                                      children: provider.studentMarks[index].marks.entries.map((entry) {
                                        return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(entry.key),

                                                Text('${entry.value}'), // Marks
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Divider(thickness: 0.3,color: grey,) ,
                                          ],
                                        );
                                      }).toList(),

                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
