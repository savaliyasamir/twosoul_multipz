import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/ui/upload_image_screen.dart';
import 'package:twosoul_multipz/utils/widget/base_screen.dart';
import 'package:twosoul_multipz/utils/widget/common_button.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';

import '../utils/constants.dart';

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({Key? key}) : super(key: key);

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {

  @override
  Widget build(BuildContext context) {
    return  BaseScreen(
      child:  Column(
        children: [
          SizedBox(
            height: 11.vh,
          ),
          Center(
            child: Image.asset(
              icTwoSoul,
              width: 20.vw,
            ),
          ),
          CommonTextView(twoSoul, fontSize: 24.sp,color: Colors.white,fontFamily: displayMedium),
          SizedBox(height: 6.vh,),
         CommonTextView(chooseLanguage,fontSize: 20.sp,color: Colors.white,fontFamily: displayMedium),
         SizedBox(height: 4.vh,),
          Wrap(
           runSpacing: 2.5.vw,
           children: language.map((e) =>  GestureDetector(
             onTap: (){
               setState(() {
                 selectedLanguage = e;
               });
             },
             child: Container(
               padding: EdgeInsets.only(left: 4.vw,right: 4.vw),
               decoration: BoxDecoration(
                 color:selectedLanguage == e? pinkColor:darkGreyColor,
                 borderRadius: BorderRadius.circular(10),
               ),
               height: 6.vh,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   CommonTextView(e,fontSize: 16.sp,fontFamily: displayRegular,color: Colors.white),
                   Container(
                     height: 4.vh,
                     width: 8.vw,

                     child: Image.asset(selectedLanguage == e ?icSelectedLanguage:icFreeUnselected),
                   ),
                 ],
               ),
             ),
           ),).toList(),
         ),
          SizedBox(height: 10.vh,),
          CommonButton(btnText: btnContinue,onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const UploadImageScreen()));
          },)
        ],
      ),
    );
  }
}
