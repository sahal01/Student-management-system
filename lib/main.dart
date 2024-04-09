import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sms/providers/providers.dart';
import 'package:sms/routes/routes.dart';
import 'package:sms/screens/onboarding/splash_screen.dart';

import 'Services/push_notification_service/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const MyApp());
  });

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers:providers(),
      child: MaterialApp(
        title: 'Student management System',
        debugShowCheckedModeBanner: false,
        routes: routes(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: false,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
