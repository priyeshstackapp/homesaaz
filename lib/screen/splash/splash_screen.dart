import 'package:flutter/material.dart';
import 'file:///E:/Priyesh/HomeSaaz/homesaaz/lib/app.dart';
import 'package:homesaaz/common/common_route.dart';

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
        .then((value) => replaceWithHomeScreen(context));
  }

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");

    return SafeArea(
      child: Scaffold(
        body: Image.asset(App.splashImage),
      ),
    );
  }
}
