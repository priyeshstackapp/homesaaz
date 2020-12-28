import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/screen/login/login_screen_view_model.dart';


class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  LoginScreenViewModel model;
  final GlobalKey<ScaffoldState> loginKey = new GlobalKey<ScaffoldState>();

  bool isLoading = false;
  bool _passwordVisible = true;
  TextEditingController emailCont = new TextEditingController();
  TextEditingController passwordCont = new TextEditingController();

  _validateInputs() async {
    model.loginApi();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");
    model ?? (model = LoginScreenViewModel(this));
    return Scaffold(
      backgroundColor: ColorRes.whiteColor,
      key: loginKey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: InkWell(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => new AlertDialog(
                    title: new Text('Are you sure?'),
                    content: new Text('Do you want to exit an App'),
                    actions: <Widget>[
                      new FlatButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: new Text('No'),
                      ),
                      new FlatButton(
                        onPressed: () {
                          if (Platform.isAndroid) {
                            SystemNavigator.pop();
                          } else if (Platform.isIOS) {
                            exit(0);
                          }
                        },
                        child: new Text('Yes'),
                      ),
                    ],
                  ),
                ),
                child: Image.asset(
                  App.left_arrow,
                  color: ColorRes.dimGray.withOpacity(0.3),
                  height: 22,width: 22,

                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30, left: 20),
              child:commonTitle('Login'),


            ),
            SizedBox(height: 25),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'NeueFrutigerWorld',
                        color: ColorRes.textColor),
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: 14, color: ColorRes.textColor),
                    cursorColor: ColorRes.textColor,
                    controller: emailCont,
                    decoration: InputDecoration(
                      hintText: "Enter email id",
                      hintStyle: TextStyle(
                          color: ColorRes.textColor.withOpacity(0.4),
                          fontSize: 14),
                      focusColor: ColorRes.textColor,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorRes.textColor.withOpacity(0.5))),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorRes.textColor.withOpacity(0.3))),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Password",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'NeueFrutigerWorld',
                        color: ColorRes.textColor),
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: 14, color: ColorRes.textColor),
                    cursorColor: ColorRes.textColor,
                    controller: passwordCont,
                    obscureText: _passwordVisible,
                    decoration: InputDecoration(
                      hintText: "Enter password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: ColorRes.textColor.withOpacity(0.3),
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      hintStyle: TextStyle(
                        color: ColorRes.textColor.withOpacity(0.4),
                        fontSize: 14,
                      ),
                      focusColor: ColorRes.textColor,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorRes.textColor.withOpacity(0.5))),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorRes.textColor.withOpacity(0.3))),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: GestureDetector(
                onTap: () {
                  _validateInputs();
                  /*if (model.validate()) {
                      setState(() {
                        isLoading = true;
                        gotoHomeScreenUntilRemove(context);
                      });
                      model.login();
                  }
                  if (!isLoading) {
                    if (model.validate()) {
                      setState(() {
                        isLoading = true;
                       gotoHomeScreen(context);
                      });
                      model.login();
                    }
                  }*/
                },
                child: gradientButton(context, title: 'Log in'),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: GestureDetector(
                onTap: () {
                  gotoSignUpScreen(context);
                 /* if (!isLoading) {
                    replaceWithSignUpScreen(context);
                  }*/
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have account? ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: ColorRes.dimGray,
                          fontFamily: 'NeueFrutigerWorld',
                          fontSize: 14),
                    ),
                    Text(
                      " Sign Up",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: ColorRes.textColor,
                          fontFamily: 'NeueFrutigerWorld',
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
