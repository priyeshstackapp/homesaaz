import 'package:flutter/material.dart';


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
  static getAssetsHomeImg(String name) {
    return "assets/image/home_ui/" + name + ".png";
  }
}