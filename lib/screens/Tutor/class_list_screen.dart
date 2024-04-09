import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms/providers/onBoardingProvider.dart';
import 'package:sms/providers/tutorProvider.dart';
import 'package:sms/widgets/utility_widget.dart';

class ClassListScreen extends StatelessWidget {
  const ClassListScreen({Key? key});
  static String routeName = "/class_list_screen";

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(Icons.lock),
                onPressed: () {
                  UtilityWidget().logout(context);
                },
              ),
              title: Text('Class List'),
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  "assets/class.png",
                  fit: BoxFit.cover,
                ),
                stretchModes: [StretchMode.zoomBackground],
              ),
              stretch: true,
              onStretchTrigger: () {
                return Future<void>.value();
              },
            ),
          ];
        },
        body: Consumer<OnBoardingProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: RefreshIndicator(onRefresh: ()async{
                Provider.of<OnBoardingProvider>(context, listen: false).fetchClasses();

              },
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 0,
                  ),
                  itemCount: provider.classDivision.length,
                  itemBuilder: (context, index) {
                    List<String> sortedList = List.from(provider.classDivision);
                    sortedList.sort((a, b) => a.compareTo(b));
                    return InkWell(
                      onTap: () {
                        Provider.of<TutorProvider>(context, listen: false)
                            .fetchStudentsByDivision(sortedList[index], context);
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: w / 2.5 - 20,
                            height: w / 2.5 - 20,
                            margin: const EdgeInsets.all(5.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/blackboard.png"),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                          ),
                          Positioned(
                            child: Center(
                              child: Text(
                                "Grade ${sortedList[index]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'GothamLight',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

