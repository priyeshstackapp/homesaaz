import 'package:flutter/material.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/dependency_injection.dart';

import '../../app.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 4)).then((onValue) => replaceWithHomeScreen(context));

    // if(Injector.loginResponse == null) {
    //   Future.delayed(Duration(seconds: 4)).then((onValue) => replaceWithLoginScreen(context));
    // } else {
    //   Future.delayed(Duration(seconds: 4)).then((onValue) => replaceWithHomeScreen(context));
    // }
  }

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");

    return Scaffold(
      body:Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          App.splash,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
