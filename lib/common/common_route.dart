import 'package:flutter/material.dart';
import 'package:homesaaz/model/address_model.dart';
import 'package:homesaaz/model/dashboard_model.dart';
import 'package:homesaaz/screen/add_card/add_card_screen.dart';
import 'package:homesaaz/screen/address/address_screen.dart';
import 'package:homesaaz/screen/cart/cart_screen.dart';
import 'package:homesaaz/screen/checkout/checkout_screen.dart';
import 'package:homesaaz/screen/confirmation/confirmation_screen.dart';
import 'package:homesaaz/screen/create_address/create_address_screen.dart';
import 'package:homesaaz/screen/forgot/forgot_password_screen.dart';
import 'package:homesaaz/screen/home/home_screen.dart';
import 'package:homesaaz/screen/login/login_screen.dart';
import 'package:homesaaz/screen/my_orders/my_orders_screen.dart';
import 'package:homesaaz/screen/my_orders_details/my_orders_detail_screen.dart';
import 'package:homesaaz/screen/payment/payment_screen.dart';
import 'package:homesaaz/screen/product_detail/product_detail.dart';
import 'package:homesaaz/screen/profile/profile_screen.dart';
import 'package:homesaaz/screen/seeall/seeall_screen.dart';
import 'package:homesaaz/screen/signup/signup_screen.dart';

import '../app.dart';

// create two method with name replaceWith and goto

replaceWithLoginScreen(context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => LoginScreen()));
}

gotoLoginScreen(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => LoginScreen()));
}
gotoLoginScreenUntilRemove(context) {
  Navigator.pushAndRemoveUntil(context,
      App.createRoute(page: LoginScreen()),
          (Route<dynamic> route) => false);
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
gotoHomeScreenUntilRemove(context) {
  Navigator.pushAndRemoveUntil(context,
      App.createRoute(page: HomeScreen()),
          (Route<dynamic> route) => false);
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

replaceWithProductDetailScreen(context,Product product) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product)));
}

gotoProductDetailScreen(context, Product product) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product)));
}
replaceWithProfileScreen(context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => ProfileScreen()));
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
gotoPaymentScreen(context, {AddressData mapAddress}) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => PaymentScreen(addressData: mapAddress)));
}
replaceWithAddCardScreen(context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => AddCardScreen()));
}
gotoAddCardScreen(context ) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => AddCardScreen()));
}
replaceWithMyOrdersScreen(context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => MyOrdersScreen()));
}
gotoMyOrdersScreen(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => MyOrdersScreen()));
}
replaceWithCheckoutScreen(context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => CheckoutScreen()));
}
gotoCheckoutScreen(context,{AddressData addressData}) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => CheckoutScreen(addressData: addressData)));
}

gotoMyOrderDetailScreen(context, String orderId ) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => MyOrdersDetailScreen(orderId)));
}
replaceWithMyOrderDetailScreen(context,String orderId) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => MyOrdersDetailScreen(orderId)));
}