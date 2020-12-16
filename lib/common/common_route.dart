import 'package:flutter/material.dart';
import 'package:homesaaz/screen/address/address_screen.dart';
import 'package:homesaaz/screen/cart/cart_screen.dart';
import 'package:homesaaz/screen/confirmation/confirmation_screen.dart';
import 'package:homesaaz/screen/create_address/create_address_screen.dart';
import 'package:homesaaz/screen/detail/product_detail.dart';
import 'package:homesaaz/screen/forgot/forgot_password_screen.dart';
import 'package:homesaaz/screen/home/home_screen.dart';
import 'package:homesaaz/screen/login/login_screen.dart';
import 'package:homesaaz/screen/payment/payment_screen.dart';
import 'package:homesaaz/screen/profile/profile_screen.dart';
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

replaceWithProductDetailScreen(context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => ProductDetailScreen()));
}

gotoProductDetailScreen(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => ProductDetailScreen()));
}
gotoProfileScreen(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => ProfileScreen()));
}
gotoAddressScreen(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => AddressScreen()));
}
gotoCreateAddressScreen(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => CreateAddressScreen()));
}
gotoConfirmationScreen(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => ConfirmationScreen()));
}

replaceWithCartScreen(context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => CartScreen()));
}

gotoCartScreen(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => CartScreen()));
}
replaceWithPaymentScreen(context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => PaymentScreen()));
}
gotoPaymentScreen(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => PaymentScreen()));
}