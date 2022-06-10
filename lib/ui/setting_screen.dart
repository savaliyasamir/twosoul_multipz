import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/ui/choose_mode_screen.dart';
import 'package:twosoul_multipz/ui/contact_faq_screen.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/base_screen.dart';
import 'package:twosoul_multipz/utils/widget/common_button.dart';
import 'package:twosoul_multipz/utils/widget/common_button_with_selection.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool toogleDateMode = true;
  bool toogleIncognitoMode = false;
  String selectedOption = '';
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(icClose, height: 3.vh),
              ),
              CommonTextView(setting,
                  fontSize: 20.sp,
                  fontFamily: displayMedium,
                  color: Colors.white),
              CommonTextView(
                btnDone,
                color: yellowColor,
                fontSize: 12.sp,
                fontFamily: displayMedium,
              ),
            ],
          ),
          SizedBox(
            height: 2.vh,
          ),
        Expanded(
          child: SingleChildScrollView(
            physics:const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              children: [
                ///choose mode
                CommonButtonWithSelection(
                    btnText: chooseMode, selectionText: 'date>', onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ChooseModeScreen()));
                }),
                ///date mode
                titleWithToggle(dateMode, (val) {
                  setState(() {
                    toogleDateMode = val;
                  });
                }, toogleDateMode),
                CommonTextView(
                  settingLoremIpsum,
                  color: white50,
                  fontSize: 12.sp,
                  fontFamily: displayLight,
                ),
                SizedBox(height: 1.vh),
                ///snooze
                CommonButtonWithSelection(
                    btnText: snooze, selectionText: '', onPressed: () {
                  showModalBottomSheet<void>(
                    barrierColor: Colors.white.withOpacity(0.30),
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return Container(
                          padding: EdgeInsets.all(4.vw),
                          height: 50.vh,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                              color: backGroundColor
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CommonTextView(snoozeQuestion,fontSize: 16.sp,fontFamily: displayRegular,),
                              SizedBox(height: 1.vh),
                              GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      selectedOption = hours24;
                                    });
                                  },
                                  child: Container(
                                      color: Colors.transparent,
                                      alignment: Alignment.center,
                                      width:100.vw,child: CommonTextView(hours24,fontSize: 14.sp,fontFamily: displayRegular,color: selectedOption == hours24 ? yellowColor : Colors.white,))),
                              horizontalDivider(),
                              GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      selectedOption = hours72;
                                    });
                                  },
                                  child: Container(
                                      color: Colors.transparent,
                                      width: 100.vw,
                                      alignment: Alignment.center,
                                      child: CommonTextView(hours72,fontSize: 14.sp,fontFamily: displayRegular,color: selectedOption == hours72 ? yellowColor : Colors.white))),
                              horizontalDivider(),
                              GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      selectedOption = aWeek;
                                    });
                                  },
                                  child: Container(
                                      width: 100.vw,
                                      color: Colors.transparent,
                                      alignment: Alignment.center,
                                      child: CommonTextView(aWeek,fontSize: 14.sp,fontFamily: displayRegular,color: selectedOption == aWeek ? yellowColor : Colors.white))),
                              horizontalDivider(),
                              GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      selectedOption = indefinitely;
                                    });
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      width: 100.vw,
                                      color: Colors.transparent,
                                      child: CommonTextView(indefinitely,fontSize: 14.sp,fontFamily: displayRegular,color: selectedOption == indefinitely ? yellowColor : Colors.white))),
                              SizedBox(height: 1.vh),
                              CommonButton(onPressed: (){
                                Navigator.pop(context);
                              },btnText: selectedOption == '' ?btnCancel : btnOk),
                            ],
                          ),
                        );
                      });
                    },
                  );
                }),
                CommonTextView(
                  settingLoremIpsum,
                  color: white50,
                  fontSize: 12.sp,
                  fontFamily: displayLight,
                ),
                SizedBox(height: 1.vh),
                ///incognito mode
                titleWithToggle(incognitoMode, (val) {
                  setState(() {
                    showModalBottomSheet(
                      barrierColor: Colors.white.withOpacity(0.30),
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          padding: EdgeInsets.all(4.vw),
                          height: 50.vh,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                              color: backGroundColor
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(icIncognito,height: 15.vw,),
                              CommonTextView(doYouWantToGoIncognito,fontFamily: displayMedium,fontSize: 18.sp,),
                              CommonTextView(incognitoText,
                                fontSize: 14.sp,
                                fontFamily: displayRegular,color: white50,
                              ),
                              CommonButton(onPressed: (){
                                setState(() {
                                  toogleIncognitoMode = val;
                                  Navigator.pop(context);
                                });

                              }, btnText: turnOnIncognitoMode),
                            ],
                          ),
                        );
                      },
                    );
                  });
                }, toogleIncognitoMode),
                CommonTextView(
                  settingLoremIpsum,
                  color: white50,
                  fontSize: 12.sp,
                  fontFamily: displayLight,
                ),
                SizedBox(height: 1.vh),
                ///current location
                CommonButtonWithSelection(
                    btnText: currentLocation,
                    selectionText: 'Houston,us>',
                    onPressed: () {}),
                SizedBox(height: 5.vh,),
                settingsButton(icLanguage,chooseLanguage,(){}),
                horizontalDivider(),
                settingsButton(icSecurity,securityPrivacy,(){}),
                horizontalDivider(),
                settingsButton(icContact,contactFaq,(){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>const ContactFaqScreen()));
                }),
                horizontalDivider(),
                settingsButton(icLogout,logOut,(){}),
                horizontalDivider(),
                settingsButton(icDeleteAccount,deleteAccount,(){}),
                SizedBox(height: 3.vh,),
              ],
            ),
          ),
        ),
        ],
      ),
    );
  }
///Toogle button with title
  Widget titleWithToggle(String title, Function onChanged, bool value) {
    return Container(
      margin: EdgeInsets.only(top: 1.vh, bottom: 1.vh),
      padding: EdgeInsets.only(left: 4.vw, right: 4.vw),
      height: 6.vh,
      width: 100.vw,
      decoration: BoxDecoration(
        color: darkGreyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonTextView(title,
              fontSize: 16.sp, color: Colors.white, fontFamily: displayRegular),
          FlutterSwitch(
            height: 2.vh,
            width: 6.5.vw,
            padding: 2,
            activeColor: pinkColor,
            toggleColor: backGroundColor,
            inactiveToggleColor: darkGreyColor,
            inactiveColor: backGroundColor,
            toggleSize: 3.vw,
            showOnOff: false,
            onToggle: (val) {
              onChanged(val);
            },
            value: value,
          ),
        ],
      ),
    );
  }

  ///setting common button
Widget settingsButton(String icon,String title,Function onTap){
    return  GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        width: 100.vw,
        height: 6.vh,
        color: Colors.transparent,
        child: Row(
          children: [
            Image.asset(icon,height: 2.vh),
            SizedBox(width: 3.vw,),
            CommonTextView(title,color: Colors.white,fontFamily: displayRegular,fontSize: 16.sp,),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_sharp,color: white50,size: 2.vh),
          ],
        ),
      ),
    );
}

}
