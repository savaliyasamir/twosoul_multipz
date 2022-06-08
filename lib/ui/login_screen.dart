import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/ui/choose_language_screen.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 2.vh, left: 4.vw, right: 4.vw),
        height: 100.vh,
        width: 100.vw,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(loginBackGround), fit: BoxFit.fill)),
        child: Column(
          children: [
            SizedBox(
              height: 15.vh,
            ),
            Image.asset(
              icTwoSoul,
              width: 25.vw,
            ),
            CommonTextView(twoSoul,fontSize: 28.sp,color: Colors.white,fontFamily: displayBold),
            SizedBox(
              height: 1.vh,
            ),
           CommonTextView(loremLpsum,textAlign: TextAlign.center,fontFamily:displayRegular, color: white70,fontSize: 14.sp),
            const Spacer(),
            loginButton(icGoogle, btnTextLoginWithGoogle, lightGreyColor,
               backGroundColor, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ChooseLanguageScreen()));
                }),
            loginButton(icApple, btnTextLoginWithApple, Colors.transparent,
                Colors.white, () {}),
            CommonTextView(byUsingUpYou,color: white70,fontSize: 12.sp,fontFamily: displayRegular,textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }

  Widget loginButton(icon, btnText, btnColor, textColor, onPressed) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.vh),
      height: 6.vh,
      child: RaisedButton(
          onPressed: onPressed,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              side: BorderSide(color: greyColor)),
          color: btnColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(icon, height: 2.5.vh),
              SizedBox(
                width: 3.vw,
              ),
              CommonTextView(btnText,fontSize: 16.sp, color: textColor,fontFamily: displayMedium),
            ],
          )),
    );
  }
}
