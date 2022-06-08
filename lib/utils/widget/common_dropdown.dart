import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/utils/constants.dart';

class CommonDropDownButton extends StatefulWidget{
 String value;
 List<String> item;
 Function  onChanged;

 CommonDropDownButton({Key? key, required this.item, required this.onChanged,required this.value}) : super(key: key);

  @override
  State<CommonDropDownButton> createState() => _CommonDropDownButtonState();
}

class _CommonDropDownButtonState extends State<CommonDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return     Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 4.vw,right: 4.vw),
      height: 6.vh,
      decoration: BoxDecoration(
          color: darkGreyColor,
          borderRadius: BorderRadius.circular(10)
      ),
      child: DropdownButton(
        dropdownColor: darkGreyColor,
        iconEnabledColor:yellowColor,
        style: TextStyle(color: white50,fontSize: 14.sp,fontFamily: 'SfUiDisplayRegular'),
        isExpanded: true,
        value: widget.value,
        icon:  Icon(Icons.keyboard_arrow_down,size: 6.vw,),
        borderRadius: BorderRadius.circular(10),
        underline: Container(),
        items: widget.item.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
            widget.onChanged(newValue);
        },
      ),
    );
  }
}