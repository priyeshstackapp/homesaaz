import 'dart:ui';

import 'package:flutter/material.dart';
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

  TextEditingController usernameCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isLoading = false;

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");
    model ?? (model = LoginScreenViewModel(this));

    return WillPopScope(
      onWillPop: () async {
        if (!isLoading) {
          Navigator.pop(context);
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorRes.whiteColor,
        key: scaffoldKey,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: backButton(context),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30, left: 30),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 34,
                        color: ColorRes.textColor,
                        fontFamily: 'NeueFrutigerWorld',
                        fontWeight: FontWeight.w100),
                  ),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'NeueFrutigerWorld',
                            color: ColorRes.textColor),
                      ),
                      TextFormField(
                        style: TextStyle(
                            fontSize: 16, color: ColorRes.textColor),
                        cursorColor: ColorRes.textColor,
                        controller: usernameCont,
                        decoration: InputDecoration(
                          hintText: "Helloistiak@gmail.com",
                          hintStyle: TextStyle(
                              color: ColorRes.textColor, fontSize: 16),
                          focusColor: ColorRes.textColor,
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: ColorRes.textColor.withOpacity(0.5))),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: ColorRes.textColor.withOpacity(0.3))),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20, horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Password",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'NeueFrutigerWorld',
                            color: ColorRes.textColor),
                      ),
                      TextFormField(
                        style: TextStyle(
                            fontSize: 16, color: ColorRes.textColor),
                        cursorColor: ColorRes.textColor,
                        controller: passwordCont,
                        obscureText: _passwordVisible,
                        decoration: InputDecoration(
                          hintText: "••••••",
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: ColorRes.textColor.withOpacity(0.3),
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          hintStyle: TextStyle(
                              color: ColorRes.textColor, fontSize: 16,fontWeight: FontWeight.bold),
                          focusColor: ColorRes.textColor,
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorRes.textColor.withOpacity(0.5))),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorRes.textColor.withOpacity(0.3))),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 30),
                  child: GestureDetector(
                    onTap: () {
                      if (!isLoading) {
                        if (model.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          model.login();
                        }
                      }
                    },
                    child: gradientButton(context,title: 'Log in',isLoading: isLoading),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 30),
                  child: GestureDetector(
                    onTap: () {
                      if (!isLoading) {
                        replaceWithSignUpScreen(context);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have account? ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ColorRes.textColor,
                              fontFamily: 'NeueFrutigerWorld',
                              fontSize: 15),
                        ),
                        Text(
                          " Sign up",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ColorRes.textColor,
                              fontFamily: 'NeueFrutigerWorld',
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
