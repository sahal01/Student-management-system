import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms/model/user_model.dart';
import 'package:sms/providers/tutorProvider.dart';
import 'package:intl/intl.dart';
import 'package:sms/widgets/buttons.dart';


class MarkUploadScreen extends StatelessWidget {
  const MarkUploadScreen({Key? key}) : super(key: key);
  static String routeName = "/mark_upload_screen";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TutorProvider>(context, listen: false);
    UserData userData = provider.selectedStudent!; // Get user details

    int selectedMonth = DateTime.now().month; // Default to current month
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Mark Upload'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0.0),
          child: Form(
            key: provider.formKeys, // Add the form key from your provider
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "${userData.firstName} ${userData.lastName}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Admission No: ${userData.admissionNo}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    labelText: "Enter Name of Exam",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 16),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  ),
                  onChanged: (value) {
                    provider.examName = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name of the exam';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    labelText: "Enter Attendance Percentage",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 16),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  ),
                  onChanged: (value) {
                    provider.attendance = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the attendance percentage';
                    }
                    // You can add more specific validation rules here if needed
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.black),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Select the Month",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: DropdownButtonFormField<int>(
                          value: selectedMonth,
                          onChanged: (value) {
                            selectedMonth = value!;
                          },
                          items: List.generate(12, (index) {
                            return DropdownMenuItem<int>(
                              value: index + 1,
                              child: Text(
                                DateFormat('MMMM yyyy').format(DateTime(2024, index + 1)),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Enter Marks for Subjects",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.classDetails!.subjects.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                provider.classDetails!.subjects[index].subjectName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  labelText: "Enter Marks",
                                  labelStyle: TextStyle(color: Colors.black, fontSize: 16),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                                ),
                                onChanged: (value) {
                                  int? marks = int.tryParse(value);
                                  if (marks != null) {
                                    provider.marksData[provider.classDetails!.subjects[index].subjectName] = marks;
                                  } else {
                                    provider.marksData.remove(provider.classDetails!.subjects[index].subjectName);
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter marks';
                                  }
                                  int? marks = int.tryParse(value);
                                  if (marks == null || marks < 0 || marks > 100) {
                                    return 'Please enter a valid mark between 0 and 100';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Buttons().primaryB(
                  w: w,
                  title: "Upload Marks",
                  onT: () async {
                    if (provider.formKeys.currentState!.validate()) {
                      provider.uploadUserMarks(
                        admissionNo: userData.admissionNo.toString(),
                        firstName: userData.firstName.toString(),
                        lastName: userData.lastName.toString(),
                        marksData: provider.marksData,
                        context: context,
                        examName: provider.examName,
                        attendance: provider.attendance,
                        month: selectedMonth,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


