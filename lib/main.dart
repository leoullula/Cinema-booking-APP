import 'package:flutter/material.dart';
import 'package:cinema_appp/pages/preloadContent.dart';
import 'package:cinema_appp/services/cinema_api.dart';
import 'package:cinema_appp/repositories/cinema_api_impl.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void setupLocator() {
  //settingup service locator
  GetIt.I.registerLazySingleton<CinemaAPI>(() => CinemaApiImplimentation());
}

void main() {
  //initializing setvice locator
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinema Booking',
      debugShowCheckedModeBanner: false,
      home: PreloadContent(),
    );
  }
}
