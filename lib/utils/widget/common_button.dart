import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/utils/constants.dart';

// ignore: must_be_immutable
class CommonButton extends StatefulWidget{
  String btnText;
  Function onPressed;
  CommonButton({Key? key, required this.onPressed,required this.btnText}) : super(key: key);

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 6.vh,
      width: 100.vw,
      child: RaisedButton(
          onPressed: (){
            widget.onPressed();
          },
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          color: yellowColor,
          child: Text(widget.btnText,
              style:  TextStyle(fontSize: 16.sp, color: Colors.white,fontFamily: 'SfUiDisplayRegular'))),
    );
  }
}