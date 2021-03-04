import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homesaaz/common/dependency_injection.dart';

class Utils{

  //width
  static double getDeviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  //height
  static double getDeviceHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  //common image style and this use only image name in all screen
  static homeImg(String name) {
    return "assets/image/home_ui/" + name + ".png";
  }

  static assetImage(String name) {
    return "assets/image/" + name + ".png";
  }

  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        // toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.black
    );
  }

  static bool checkLogin() {
    return Injector.loginResponse != null;
  }
}

class  extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
