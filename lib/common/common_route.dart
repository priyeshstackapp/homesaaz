import 'package:flutter/material.dart';
import 'package:homesaaz/screen/forgot/forgot_password_screen.dart';
import 'package:homesaaz/screen/home/home_screen.dart';
import 'package:homesaaz/screen/login/login_screen.dart';
import 'package:homesaaz/screen/seeall/seeall_screen.dart';
import 'package:homesaaz/screen/signup/signup_screen.dart';

// create two method with name replaceWith and goto

replaceWithLoginScreen(context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => LoginScreen()));
}

gotoLoginScreen(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => LoginScreen()));
}

gotoForgotPassword(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => ForgotPassword()));
}

replaceWithForgotPassword(context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => ForgotPassword()));
}

gotoSignUpScreen(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => SignUpScreen()));
}

replaceWithSignUpScreen(context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => SignUpScreen()));
}

replaceWithHomeScreen(context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => HomeScreen()));
}

gotoHomeScreen(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => HomeScreen()));
}

replaceWithSeeAllScreen(context,title) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => SeeAllScreen(title)));
}

gotoSeeAllScreen(context,title) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => SeeAllScreen(title)));
}