import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/utils/constants.dart';

// ignore: must_be_immutable
class CommonTextField extends StatelessWidget{
  String hintText;
  TextEditingController controller;
  TextInputType? keyboardType;
  CommonTextField({Key? key, required this.hintText,required this.controller,this.keyboardType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType ?? TextInputType.text,
      controller: controller,
      cursorColor: lightGreyColor,
      style:  TextStyle(color: white50,fontSize: 12.sp),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding:
        EdgeInsets.symmetric(vertical: 3.vw, horizontal: 3.vw),
        fillColor: darkGreyColor,
        filled: true,
        //   contentPadding: EdgeInsets.only(left: 4.vw, right: 4.vw),
        hintText: hintText,
        hintStyle:  TextStyle(color: greyColor,fontSize: 14.sp,fontFamily: 'SfUiDisplayRegular'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

}