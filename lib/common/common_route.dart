import 'package:flutter/material.dart';
import 'package:homesaaz/model/address_model.dart';
import 'package:homesaaz/model/cart_model.dart';
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
import 'package:homesaaz/screen/seeall/categories_all.dart';
import 'package:homesaaz/screen/seeall/seeall_screen.dart';
import 'package:homesaaz/screen/seeall/subCategory/sub_category_products.dart';
import 'package:homesaaz/screen/signup/signup_screen.dart';
import 'package:homesaaz/screen/wish/wish_screen.dart';

import '../app.dart';

// create two method with name replaceWith and goto

replaceWithLoginScreen(context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => LoginScreen()));
}

gotoLoginScreen(context, {bool isBack = false}) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => LoginScreen(isBack: isBack)));
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

gotoSignUpScreen(context,{bool isBack = false}) {
  Navigator.push(
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

gotoSeeAllScreen(context,title, String id,{bool cat = false}) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => SeeAllScreen(title,id,cat)));
}

gotoProductDetailScreen(context, Product product) async {
  return await Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product)));
}

gotoSubCategoryProducts(context, String catId, String subCatId, String catName,String subCatName) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => SubCategoryProducts(catId, subCatId, catName, subCatName)));
}
replaceWithProfileScreen(context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => ProfileScreen()));
}

gotoProfileScreen(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => ProfileScreen()));
}
gotoAddressScreen(context, CartModel cartModel) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => AddressScreen(cartModel)));
}
gotoCreateAddressScreen(context,bool edit,AddressData addressData) async {
  var res = await Navigator.push(
      context, MaterialPageRoute(builder: (context) => CreateAddressScreen(edit,addressData)));
  return res;
}
gotoConfirmationScreen(context, String orderId, String id) {
  Navigator.pushAndRemoveUntil(context,
      App.createRoute(page: ConfirmationScreen(orderId,id)),
          (Route<dynamic> route) => false);
}

replaceWithCartScreen(context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => CartScreen()));
}

gotoCartScreen(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => CartScreen()));
}

gotoWishScreen(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => WishScreen()));
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
gotoCheckoutScreen(context,AddressData addressData, CartModel cartModel) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => CheckoutScreen(addressData,cartModel)));
}

gotoMyOrderDetailScreen(context, String orderId ) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => MyOrdersDetailScreen(orderId)));
}
replaceWithMyOrderDetailScreen(context,String orderId) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => MyOrdersDetailScreen(orderId)));
}

gotoCategoriesAll(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => CategoriesAll()));
}