import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/base_screen.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';

class ContactFaqScreen extends StatefulWidget {
  const ContactFaqScreen({Key? key}) : super(key: key);

  @override
  State<ContactFaqScreen> createState() => _ContactFaqScreenState();
}

class _ContactFaqScreenState extends State<ContactFaqScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
       child: Column(
         children: [
           Row(
             children: [
               InkWell(
                 onTap: () {
                   Navigator.pop(context);
                 },
                 child: Image.asset(icBackButton, height: 2.vh),
               ),
               SizedBox(width: 20.vw,),
               CommonTextView(contactFaq,
                   fontSize: 20.sp,
                   fontFamily: displayMedium,
                   color: Colors.white),
             ],
           ),
           SizedBox(
             height: 2.vh,
           ),
          commonContactButton(faq, (){}),
           commonContactButton(contactUs, (){}),
           commonContactButton(termsOfService, (){}),
           commonContactButton(privacyPolicy, (){}),
           commonContactButton(advertising, (){}),
         ],
       ),
    );
  }
  Widget commonContactButton(String text,Function onTap) {
      return  GestureDetector(
        onTap: (){
          onTap();
        },
        child: Container(
          margin: EdgeInsets.only(top: 1.vh),
          padding: EdgeInsets.only(left: 4.vw,right: 4.vw),
          height: 6.vh,
          decoration: BoxDecoration(
            color: darkGreyColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonTextView(text,fontFamily: displayRegular,fontSize: 16.sp),
              Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,size: 2.vh,)
            ],),
        ),
      );
  }
}
