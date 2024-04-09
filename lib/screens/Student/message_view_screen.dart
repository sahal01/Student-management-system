import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms/providers/onBoardingProvider.dart';


class MessageViewScreen extends StatelessWidget {
  const MessageViewScreen({Key? key}) : super(key: key);
  static String routeName = "/message_view_screen";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OnBoardingProvider>(context);
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false, // Disable the back button
        title: Text('Messages'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:  provider.messages!=null?provider.messages.isNotEmpty?Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: ()async{
                  Provider.of<OnBoardingProvider>(context, listen: false).fetchMessages();

                },
                child: ListView.builder(
                  itemCount: provider.messages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 8),
                          Expanded(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(

                                  children: [
                                    Icon(Icons.notifications), // Notification icon
                                    SizedBox(width: 8),

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(width:w/1.7,
                                          child: Text(
                                            provider.messages[index].text,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        SizedBox(width:w/1.7,
                                          child: Text(
                                            'Sent at ${ provider.messages[index].timestamp}',
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
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
            ),
          ],
        ):Center(child: const Text("No Messages Found")):Center(child: const Text("Fetching Messages")),
      ),
    );
  }
}
