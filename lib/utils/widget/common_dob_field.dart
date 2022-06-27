


import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/utils/constants.dart';

// ignore: must_be_immutable
class DOBTextField extends StatelessWidget {
  String hintText;
  TextEditingController controller;
  int maxLength;
  TextInputAction textInputAction;
  FocusNode focusNode;
  Function onChanged;
  bool? enable;

   DOBTextField(
      {Key? key, this.enable,required this.onChanged,required this.focusNode,required this.textInputAction, required this.hintText, required this.controller, required this.maxLength,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12.vw,
      width: 27.vw,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: darkGreyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        enabled:enable ?? true,
        style: TextStyle(color: white50,fontSize: 14.sp),
        onChanged: (value) {
          onChanged(value);
        },
        focusNode: focusNode,
        textInputAction: textInputAction,
        keyboardType: TextInputType.number,
        maxLength: maxLength,
        controller: controller,
        textAlign: TextAlign.center,
        cursorColor: pinkColor,
        decoration: InputDecoration(
          counterStyle: const TextStyle(color: Colors.transparent),
          contentPadding: EdgeInsets.only(left: 4.vw, right: 4.vw,bottom: 0.5.vh),
          hintText: hintText,
          hintStyle: TextStyle(color: greyColor,fontSize: 14.sp),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
