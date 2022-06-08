
import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';

// ignore: must_be_immutable
class CommonButtonWithSelection extends StatefulWidget{
  String btnText;
  String selectionText;
  Function onPressed;
   CommonButtonWithSelection({Key? key,required this.btnText,required this.selectionText,required this.onPressed}) : super(key: key);

  @override
  State<CommonButtonWithSelection> createState() => _CommonButtonWithSelectionState();
}

class _CommonButtonWithSelectionState extends State<CommonButtonWithSelection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 1.vh,bottom: 1.vh),
      height: 6.vh,
      width: 100.vw,
      child: RaisedButton(
          elevation: 0,
          onPressed: (){
            widget.onPressed();
          },
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          color: darkGreyColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonTextView(widget.btnText,
                  fontSize: 16.sp, color: Colors.white,fontFamily: displayRegular),
              CommonTextView(widget.selectionText,
                  fontSize: 14.sp, color: lightGreyColor,fontFamily: displayRegular),

            ],
          )),
    );
  }
}