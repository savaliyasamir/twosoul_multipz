import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/ui/login_screen.dart';
import 'package:twosoul_multipz/ui/no_internet_screen.dart';

void main() {
  init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}
Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  ///internet connectivity check
  StreamSubscription ? subscription;
  bool isInternetConnected = false;

  @override
  // ignore: must_call_super
  void initState() {
    ///internet connectivity
    setState(() {
      subscription = Connectivity()
          .onConnectivityChanged
          .listen((result) {
        setState(() {
          isInternetConnected = result != ConnectivityResult.none;
        });
      });
    });
    initialization();
  }
  ///splash screen time duration
  void initialization() async {
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Resize(builder: () {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme:  ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: isInternetConnected ? const LoginScreen() : const NoInternetScreen(),
      );
    },);
  }
}

/*
Variant: debug
Config: debug
Store: C:\Users\ADMIN\.android\debug.keystore
Alias: AndroidDebugKey
MD5: 0D:1C:CF:F1:A5:48:69:2F:DC:0F:48:E8:2D:69:3C:49
SHA1: 1C:E4:D9:60:4E:6B:78:C9:2D:74:9C:8E:5D:69:35:81:04:DA:D9:0A
SHA-256: B9:E5:B6:8A:52:FF:F7:EF:F5:25:90:61:83:14:F2:8F:F2:9A:B4:DC:20:16:7B:8C:19:EE:20:69:9A:BB:37:D3
Valid until: Thursday, 21 March, 2052
*/
