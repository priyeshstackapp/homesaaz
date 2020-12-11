import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homesaaz/screen/login/login_screen.dart';
import 'package:homesaaz/screen/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((_) {
    SharedPreferences.getInstance().then((pref) {
      prefs = pref;
      runApp(MyApp());
    });
  });
}

SharedPreferences prefs;

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Saaz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
