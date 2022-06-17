


import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';

class CommonDrop extends StatefulWidget{
  var value;
  List item;
  Function  onChanged;
  String hintText;
  double? width;
  CommonDrop({Key? key,required this.hintText, required this.item, required this.onChanged,required this.value,this.width}) : super(key: key);

  @override
  State<CommonDrop> createState() => _CommonDropState();
}

class _CommonDropState extends State<CommonDrop> {
  @override
  Widget build(BuildContext context) {
    return     Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 4.vw,right: 4.vw),
      height: 13.vw,
      width: widget.width ?? 100.vw,
      decoration: BoxDecoration(
          color: darkGreyColor,
          borderRadius: BorderRadius.circular(10)
      ),
      child: DropdownButton(
        hint: CommonTextView(widget.hintText,color: greyColor,fontSize: 14.sp,),
        dropdownColor: darkGreyColor,
        iconEnabledColor:yellowColor,
        style: TextStyle(color: white50,fontSize: 14.sp,fontFamily: displayRegular),
        isExpanded: true,
        value: widget.value,
        icon:  Icon(Icons.keyboard_arrow_down,size: 6.vw,),
        borderRadius: BorderRadius.circular(10),
        underline: Container(),
        items: widget.item.map((items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items.name.toString()),
          );
        }).toList(),
        onChanged: (newValue) {
          widget.onChanged(newValue);
        },
      ),
    );
  }
}