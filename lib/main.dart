import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:homesaaz/common/dependency_injection.dart';
import 'package:homesaaz/screen/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() => setupLocator();

Future setupLocator() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Injector.getInstance();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((_) {
    SharedPreferences.getInstance().then((pref) {
      prefs = pref;
      runApp(MyApp());
    });
  });

  // runApp(MyApp());
}

SharedPreferences prefs;
String deviceToken;

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseMessageInit();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white),
    );
    return MaterialApp(
      title: 'Home Saaz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=new FlutterLocalNotificationsPlugin();
final FirebaseMessaging firebaseMessaging = FirebaseMessaging();


Future<String> firebaseMessageInit() async {

  var android = new AndroidInitializationSettings('@mipmap/ic_launcher'); //app_icon
  final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
  var platform = new InitializationSettings( android: android, iOS: initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(platform).then((value) {
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message  ');
        print(message);
        showNotification(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume ');
        print(message);
        showNotification(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch ');
        print(message);
        showNotification(message);
      },
    );
  });

  if (Platform.isIOS) iosPermission();

  String token = await firebaseMessaging.getToken();
  print("token $token");
  deviceToken = token;

}

void iosPermission() {
  firebaseMessaging.requestNotificationPermissions(
      IosNotificationSettings(sound: true, badge: true, alert: true)
  );
  firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings)
  {
    print("Settings registered: $settings");
  });
}

showNotification(Map<String, dynamic> msg) async {
  var android = new AndroidNotificationDetails(
    'channelId',
    "channelName",
    "channelDescription",
  );
  var iOS = new IOSNotificationDetails();
  var platform = new NotificationDetails(android: android,iOS: iOS);
  if(Platform.isIOS){
    await flutterLocalNotificationsPlugin.show(0, msg['notification']['title'], msg['notification']['body'], platform);
  }else{
    await flutterLocalNotificationsPlugin.show(0, msg['notification']['title'], msg['notification']['body'], platform);
  }
}
