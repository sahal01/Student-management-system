


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms/const/colors.dart';
import 'package:sms/model/class_data_model.dart';
import 'package:sms/model/subject_data_model.dart';
import 'package:sms/providers/tutorProvider.dart';
import 'package:sms/widgets/buttons.dart';
import 'package:sms/widgets/utility_widget.dart';


class AddClassAndSubjectsForm extends StatelessWidget {
  static const String routeName = "/add_class_and_subject_screen";

  const AddClassAndSubjectsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AddClassAndSubjectsFormBody();
  }
}

class AddClassAndSubjectsFormBody extends StatefulWidget {
  const AddClassAndSubjectsFormBody({Key? key}) : super(key: key);

  @override
  _AddClassAndSubjectsFormBodyState createState() => _AddClassAndSubjectsFormBodyState();
}

class _AddClassAndSubjectsFormBodyState extends State<AddClassAndSubjectsFormBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController subjectNameController = TextEditingController();
  TextEditingController teacherController = TextEditingController();
  List<SubjectData> subjects = [];
  String selectedGrade = '1'; // Default grade selection

  @override
  Widget build(BuildContext context) {
    List<String> gradeList = List.generate(10, (index) => (index + 1).toString());
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Class and Subjects'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.lock),
          onPressed: () {
            UtilityWidget().logout(context);
          },
        ),
        // Disable the back button
backgroundColor: black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                value: selectedGrade,
                items: gradeList.map((grade) {
                  return DropdownMenuItem<String>(
                    value: grade,
                    child: Text('Grade $grade'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGrade = value!;
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelText: "Select Grade",
                  labelStyle: TextStyle(color: Colors.black, fontSize: 16),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                ),


              ),
              SizedBox(height: 16),
              TextFormField(
                controller: subjectNameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelText: "Subject Name",
                  labelStyle: TextStyle(color: Colors.black, fontSize: 16),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                ),


                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter subject name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: teacherController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelText: "Teacher",
                  labelStyle: TextStyle(color: Colors.black, fontSize: 16),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter teacher name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),


              Buttons().primaryB(
                  w: w,
                  title: "Add Subject",
                  onT: () async {
                    if (_formKey.currentState!.validate()) {
                      subjects.add(
                        SubjectData(
                          subjectName: subjectNameController.text.trim(),
                          teacher: teacherController.text.trim(),
                          marks: {}, // Initialize with empty marks
                        ),
                      );
                      subjectNameController.clear();
                      teacherController.clear();
                    }

                  }),



              SizedBox(height: 16),
              Buttons().primaryB(
                  w: w,
                  title: "Add Class and Subjects",
                  onT: () async {
                    if (_formKey.currentState!.validate()) {
                      subjects.add(
                        SubjectData(
                          subjectName: subjectNameController.text.trim(),
                          teacher: teacherController.text.trim(),
                          marks: {}, // Initialize with empty marks
                        ),
                      );
                      subjectNameController.clear();
                      teacherController.clear();

                      // Check if the class already exists before adding
                      bool classExists = await Provider.of<TutorProvider>(context, listen: false).checkClassExistsInFirestore(selectedGrade);
                      if (classExists) {
                        // Show a dialog to update details
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Class Already Exists'),
                              content: Text('Do you want to update the details for this class?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    String existingClassId =  Provider.of<TutorProvider>(context, listen: false).fetchExistingClassId(selectedGrade).toString();

                                    // Use the existing ID for updating
                                    String classId = existingClassId;

                                    // Create a new ClassData instance with the existing ID and updated data
                                    ClassData updatedClass = ClassData(
                                      id: classId,
                                      grade: selectedGrade,
                                      subjects: subjects,
                                    );

                                    // Update the existing class with new details
                                    await Provider.of<TutorProvider>(context, listen: false).updateClassAndSubjectsInFirestore(updatedClass);

                                    // Clear form fields and subjects list
                                    subjectNameController.clear();
                                    teacherController.clear();
                                    subjects.clear();

                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: Text('Update'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // Add logic to add new class here
                        // Generate a unique ID for the new class
                        String classId = FirebaseFirestore.instance.collection('your_collection').doc().id;

                        // Create a new ClassData instance with the generated ID
                        ClassData newClass = ClassData(
                          id: classId,
                          grade: selectedGrade,
                          subjects: subjects,
                        );

                        // Add the new class and subjects to Firestore
                        await Provider.of<TutorProvider>(context, listen: false).addClassAndSubjectToFirestore(newClass);

                        // Clear form fields and subjects list
                        subjectNameController.clear();
                        teacherController.clear();
                        subjects.clear();
                      }
                    }

                  }),


            ],
          ),
        ),
      ),
    );
  }
}


