
import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

// ignore: must_be_immutable
class CommonTextView extends StatelessWidget{
  String text;
  Color? color;
  double? fontSize;
  TextAlign? textAlign;
  String? fontFamily;
  CommonTextView(this.text,{Key? key,this.fontSize,this.fontFamily,this.color,this.textAlign}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,style: TextStyle(
      fontSize: fontSize ?? 12.sp,
      fontFamily: fontFamily,
      color: color ?? Colors.white,
    ),
      textAlign: textAlign ?? TextAlign.left,
    );
  }

}