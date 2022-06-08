import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/utils/constants.dart';


class BaseScreen extends StatelessWidget {
  final child;
  const BaseScreen({Key? key,this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: Padding(
        padding: EdgeInsets.only(left: 4.vw,right: 4.vw,top: 6.vh),
        child: child,
      ),
    );
  }
}
