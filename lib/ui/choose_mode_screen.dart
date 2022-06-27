import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/Network/bloc/choose_mode/choose_mode_bloc.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/base_screen.dart';
import 'package:twosoul_multipz/utils/widget/common_button.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';

import '../Network/bloc/choose_mode/choose_mode_event.dart';


class ChooseModeScreen extends StatefulWidget {
  const ChooseModeScreen({Key? key}) : super(key: key);

  @override
  State<ChooseModeScreen> createState() => _ChooseModeScreenState();
}

class _ChooseModeScreenState extends State<ChooseModeScreen> {
  List<String> chooseModeList = ['Date','Relationship','Friendship'];
  String selectedMode = 'Date';
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(icBackButton, height: 2.vh),
            ),
            SizedBox(width: 25.vw,),
            CommonTextView(chooseMode,color: Colors.white,fontSize: 20.sp,fontFamily: displayMedium),
          ],
        ),
          Padding(
            padding:  EdgeInsets.only(top: 2.vh,bottom: 2.vh),
            child: CommonTextView(whatKindOfConnection,fontFamily: displayMedium,fontSize: 14.sp),
          ),
          Wrap(
            runSpacing: 3.vw,
            children: chooseModeList.map((e) => GestureDetector(
              onTap: (){
                setState(() {
                  selectedMode = e;
                });
              },
              child: Container(
                padding: EdgeInsets.all(4.vw),

                decoration: BoxDecoration(
                    color: darkGreyColor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonTextView(e,fontFamily: displayMedium,fontSize: 18.sp,),
                        Image.asset(selectedMode == e ?icFree:icFreeUnselected,height: 3.vh),
                      ],
                    ),
                    SizedBox(height: 0.5.vh,),
                    CommonTextView('Lorem Ipsum is simply dummy text of printing\ntypesetting as a industry.',color: white50,fontFamily: displayRegular),
                  ],
                ),
              ),
            )).toList(),
          ),
          SizedBox(height: 5.vh),
          CommonButton(onPressed: (){
            context.read<ChooseModeBloc>().add(
                FetchData(
                    selectedMode == "Date" ? "0" : selectedMode == "Relationship" ? "1" : "2"));
            Navigator.pop(context);
          }, btnText: btnContinueWithDate),
          
        ],
      ),
    );
  }
}
