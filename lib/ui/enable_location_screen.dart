import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/ui/more_information_screen.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/base_screen.dart';
import 'package:twosoul_multipz/utils/widget/common_button.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';


class EnableLocationScreen extends StatelessWidget {
  const EnableLocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Image.asset(icBackButton,height: 2.vh)),
          ),
          SizedBox(height: 15.vh,),
          Center(child: Image.asset(icLocation,height: 25.vw)),
          Padding(
            padding:  EdgeInsets.only(top: 4.vh,bottom: 1.vh),
            child: CommonTextView(enableLocation,fontSize: 24.sp,color: Colors.white,fontFamily: displayMedium),
          ),
          CommonTextView(chooseYourLocation,textAlign:TextAlign.center,fontSize: 12.sp,fontFamily: displayRegular,color: white50),
          SizedBox(height: 7.vh,),
          CommonButton(btnText: btnEnableLocation,onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => MoreInformationScreen()));
          },)
        ],
      ),
    );
  }
}
