import 'package:flutter/cupertino.dart';

class App {
  static const String appName = 'HomeSaaz';

  static const font_name = "Roboto";

  // error strings
  static String errorEmail = "Invalid Email ID";
  static String errorMobileOnly = "Invalid Enter mobile no.";
  static String errorPassword = "Invalid Enter password";

  // display strings
  static String email = 'Email ID';
  static String password = 'Password';
  static String mobile = 'Mobile Number';

  //Home Screen strings
  static String categoriesName = 'Categories';
  static String newProductsName = 'New Products';
  static String trendingProductsName = 'Trending Products';
  static String featuredProductsName = 'Featured Products';

  //Payment Screen
  static String subtotal = 'Subtotal';
  static String discount = 'Discount';
  static String shipping = 'Shipping';
  static String total = 'Total';


  // assets string
  static const rootIcon = 'assets/icon/';
  static const rootImage = 'assets/image/';
  static const HomeImage = 'assets/image/home_ui/';

  static const appIcon = rootIcon + 'appIcon.png';
  static const backIcon = rootIcon + 'back.png';
  static const cartIcon = rootIcon + 'cartIcon.png';
  static const userIcon = rootIcon + 'userIcon.png';
  static const deleteIcon = rootIcon + 'delete_icon.png';
  static const editIcon = rootIcon + 'edit_icon.png';
  static const menuIcon = rootIcon + 'menuIcon.png';
  static const searchIcon = rootIcon + 'searchIcon.png';
  static const cencelIcon = rootIcon + 'Cencel.png';
  static const backArrow = rootIcon +'backArrow.png';
  static const user = rootIcon +'user.png';
  static const shopping_cart = rootIcon +'shopping_cart.png';
  static const left_arrow = rootIcon +'left_arrow.png';
  static const close = rootIcon +'close.png';

  static const splashImage = rootImage + 'splash.png';
  static const splash = rootImage + 'splash.jpg';
  static const appNameImage = rootImage + 'appNameLogo.png';
  static const bannerImage = rootImage + 'banner.png';
  static const VectorVisaCreditCard = rootImage + 'VectorVisaCreditCard.png';
  static const defaultImage = rootImage + 'default.jpg';
  static const cat1 = HomeImage + 'cat1.png';
  static const cat2 = HomeImage + 'cat2.png';
  static const cat3 = HomeImage + 'cat3.png';
  static const cat4 = HomeImage + 'cat4.png';
  static const cat5 = HomeImage + 'cat5.png';
  static const cat6 = HomeImage + 'cat6.png';
  static const banner_bottom = HomeImage + 'banner_bottom.png';
  static const banner_center = HomeImage + 'banner_center.png';
  static const banner_top = HomeImage + 'banner_top.png';
  static const featured_product_first = HomeImage + 'featured_product_first.png';
  static const featured_product_second = HomeImage + 'featured_product_second.png';
  static const product_name_first = HomeImage + 'product_name_first.png';
  static const product_name_second = HomeImage + 'product_name_second.png';
  static const product_name_third = HomeImage + 'product_name_third.png';
  static const trending_product_first = HomeImage + 'trending_product_first.png';
  static const trending_product_second = HomeImage + 'trending_product_second.png';
  static const confirmation = HomeImage + 'confirmation.png';

  static Route createRoute({Widget page}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.fastLinearToSlowEaseIn;

        var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
