import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/ui/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        home: const LoginScreen(),
      );
    },);
  }
}

