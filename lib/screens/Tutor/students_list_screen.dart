import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms/const/colors.dart';
import 'package:sms/providers/tutorProvider.dart';

class StudentsListScreen extends StatelessWidget {
  const StudentsListScreen({super.key});
  static String routeName = "/students_list_screen";

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return  Scaffold(backgroundColor: white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Students List'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body:       Consumer<TutorProvider>(builder: (
            context,
            provider,
            child,
            ) {
          return   provider.students.isNotEmpty?   Center(
            child:



            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: provider.students.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0), // Adjust padding as needed
                    child: InkWell(
                      onTap: () {
                        provider.selectedStudents(index, context);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/student.png",
                            height: w > 600 ? 35 : 30,
                            width: w > 600 ? 35 : 30,
                          ),
                          const SizedBox(height: 8),
                          Flexible(
                            child: Text(
                              "${provider.students[index].firstName} ${provider.students[index].lastName}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: w > 600 ? 19 : 16,
                                color: Colors.black87,
                                fontFamily: 'GothamMedium',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Flexible(
                            child: Text(
                              provider.students[index].admissionNo,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: w > 600 ? 21 : 16,
                                color: Colors.green,
                                fontFamily: 'GothamMedium',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )





          ):const Center(
            child: Text("No Students Found"),
          );
        })
    );
  }
}