

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms/providers/tutorProvider.dart';
import 'package:sms/widgets/buttons.dart';

import 'package:sms/widgets/utility_widget.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);
  static String routeName = "/message_screen";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TutorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.lock),
          onPressed: () {
            UtilityWidget().logout(context);
          },
        ),
        title: Text('Message Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: provider.formKeys2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter your message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                maxLines: 3, // Allow multiline input
                onChanged: (value) => provider.setMessage(value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a message';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Buttons().primaryB(
                w: MediaQuery.of(context).size.width,
                title: 'Send Message',
                onT: () {
                  if (provider.formKeys2.currentState!.validate()) {
                    provider.sendMessage(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


