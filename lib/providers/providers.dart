
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sms/providers/tutorProvider.dart';

import 'onBoardingProvider.dart';

List<SingleChildWidget> providers() {
  return [
    ChangeNotifierProvider.value(value: OnBoardingProvider()),
    ChangeNotifierProvider.value(value: TutorProvider()),


  ];
}
