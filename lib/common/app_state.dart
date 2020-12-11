import 'package:flutter/material.dart';

class AppState {
  static final AppState _singleton = AppState._internal();

  factory AppState() {
    return _singleton;
  }

  AppState._internal();

  String accessToken = "";
  String name = "";

}
