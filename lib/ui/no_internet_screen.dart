
import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/utils/constants.dart';

import '../utils/widget/base_screen.dart';


class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  _NoInternetScreenState createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return  BaseScreen(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 2.vw),
              child: Icon(Icons.wifi_off_rounded,size: 25.vw,color: pinkColor,),
            ),
            Text('Internet ?',style: TextStyle(color: pinkColor,fontSize: 30.sp,fontFamily: displayMedium),),
            SizedBox(height: 10.vw,),
            Text('No internet connection found. Check your connection and\n Try Again',textAlign: TextAlign.center,style: TextStyle(fontSize: 20.sp,fontFamily: displayRegular,color: yellowColor),)
          ],
        ),
      ),
    );
  }
}