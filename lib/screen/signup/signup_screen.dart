import 'package:flutter/material.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/screen/signup/signup_view_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  SignUpViewModel model;

  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController userIdCont = TextEditingController();
  TextEditingController userNameCont = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isLoading = false;
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");
    model ?? (model = SignUpViewModel(this));

    return WillPopScope(
      onWillPop: () async {
        if (!isLoading) {
          Navigator.pop(context);
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorRes.primaryColor,
        key: scaffoldKey,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: loginAndSignupbackButton(context),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30, left: 30),
                  child: Text(
                    "Signup",
                    style: TextStyle(
                        fontSize: 30,
                        color: ColorRes.nightRider,
                        fontFamily: 'NeueFrutigerWorld',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'NeueFrutigerWorld',
                            color: ColorRes.dimGray.withOpacity(0.7)),
                      ),
                      TextFormField(
                        style: TextStyle(
                            fontSize: 14, color: ColorRes.textColor),
                        cursorColor: ColorRes.textColor,
                        controller: userNameCont,
                        decoration: InputDecoration(
                          hintText: "Majedul Islam Khan",
                          hintStyle: TextStyle(
                              color: ColorRes.textColor, fontSize: 14),
                          focusColor: ColorRes.textColor,
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: ColorRes.textColor)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: ColorRes.textColor)),
                        ),
                      ),
                    ],
                  ),
                ),
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
                            fontSize: 14,
                            fontFamily: 'NeueFrutigerWorld',
                            color: ColorRes.dimGray.withOpacity(0.7)),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                            fontSize: 14, color: ColorRes.textColor),
                        cursorColor: ColorRes.textColor,
                        controller: emailCont,
                        decoration: InputDecoration(
                          hintText: "Helloistiak@gmail.com",
                          hintStyle: TextStyle(
                              color: ColorRes.textColor, fontSize: 14),
                          focusColor: ColorRes.textColor,
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: ColorRes.textColor)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: ColorRes.textColor)),
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
                            fontSize: 14,
                            fontFamily: 'NeueFrutigerWorld',
                            color: ColorRes.dimGray.withOpacity(0.7)),

                      ),
                      TextFormField(
                        style: TextStyle(
                            fontSize: 14, color: ColorRes.textColor),
                        cursorColor: ColorRes.textColor,
                        controller: passwordCont,
                        obscureText: _passwordVisible,
                        decoration: InputDecoration(
                          hintText: "••••••",
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
                              color: ColorRes.textColor, fontSize: 14,fontWeight: FontWeight.bold),
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
                  height: 15
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
                            gotoHomeScreen(context);
                          });
                          model.signUp();
                        }
                      }
                    },
                    child: gradientButton(context,title: "Sign Up",isLoading: isLoading),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 30),
                  child: GestureDetector(
                    onTap: () {
                      if (!isLoading) {
                        replaceWithLoginScreen(context);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ColorRes.dimGray,
                              fontFamily: 'NeueFrutigerWorld',
                              fontSize: 14),
                        ),
                        Text(
                          " Sign in",
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
        ),
      ),
    );
  }
}
