import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/screen/home/home_screen_view_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  HomeScreenViewModel model;

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");
    model ?? (model = HomeScreenViewModel(this));

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: InkWell(
          child: Image.asset(App.menuIcon),
          onTap: () => scaffoldKey.currentState.openDrawer(),
        ),
        elevation: 0,
        backgroundColor: ColorRes.primaryColor,
        actions: [
          Image.asset(App.userIcon),
          Image.asset(App.cartIcon),
        ],
      ),
      drawer: SafeArea(
        child: Container(
          color: ColorRes.primaryColor,
          width: MediaQuery.of(context).size.width/1.5,
        ),
      ),
      body: Container(),
    );
  }
}
