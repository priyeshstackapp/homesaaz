import 'package:flutter/material.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/common_route.dart';

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
    Future.delayed(Duration(seconds: 4))
        .then((value) => replaceWithLoginScreen(context));
  }

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");

    return Scaffold(
      body:Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          App.splashImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
