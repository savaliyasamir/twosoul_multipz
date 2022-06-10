import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/ui/chat_screen.dart';
import 'package:twosoul_multipz/ui/comunity_screen.dart';
import 'package:twosoul_multipz/ui/discover_screen.dart';
import 'package:twosoul_multipz/ui/profile_screen.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int index = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    DiscoverScreen(),
    CommunityScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];
  Future<bool> showExitPopup() async {
    return await  showDialog(
      context: context,
      barrierColor: white50,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetAnimationDuration:
          const Duration(milliseconds: 100),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                padding: EdgeInsets.only(left: 4.vw,right: 4.vw,top: 6.vh,bottom: 2.vh),
                margin: EdgeInsets.only(top: 6.vh),
                height: 25.vh,
                width: 90.vw,
                decoration: BoxDecoration(
                  color: backGroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextView(exitApp,fontSize: 20.sp,fontFamily: raidProRegular,color: yellowColor,),
                    SizedBox(height: 2.vh,),
                    CommonTextView(doYouWantToExit,fontFamily: displayRegular,fontSize: 15.sp),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 2.vw),
                            alignment: Alignment.center,
                            height: 4.vh,
                            width: 16.vw,
                            decoration: BoxDecoration(
                                color: pinkColor, borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              btnCancel,
                              style: TextStyle(fontSize: 12.sp, color: Colors.white),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 4.vh,
                            width: 16.vw,
                            decoration: BoxDecoration(
                                color: pinkColor, borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              'Exit',
                              style: TextStyle(fontSize: 12.sp, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Image.asset(icTwoSoul,height: 30.vw),
            ],
          ),
        );
      },
    )??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (index != 0) {
          setState(() {
            index = 0;
          });
          return false;
        } else {
          return showExitPopup();
        }
      },
      child: Scaffold(
        body: _widgetOptions.elementAt(index),
        backgroundColor: backGroundColor,
        bottomNavigationBar: Container(
          height: 16.vw,
          width: 100.vw,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(bottomBackGroundImage), fit: BoxFit.fill)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      index = 0;
                    });
                  },
                  child: Container(
                      width: 15.vw,
                      height: 15.vw,
                      padding: EdgeInsets.all(4.vw),
                      child: Image.asset(
                          index == 0 ? icDisCoverSelected : icDisCover))),
              InkWell(
                  onTap: () {
                    setState(() {
                      index = 1;
                    });
                  },
                  child: Container(
                      width: 15.vw,
                      height: 15.vw,
                      padding: EdgeInsets.all(4.vw),
                      child:
                          Image.asset(index == 1 ? icLocation0 : icLocation1))),
              InkWell(
                  onTap: () {
                    setState(() {
                      index = 2;
                    });
                  },
                  child: Container(
                      width: 15.vw,
                      height: 15.vw,
                      padding: EdgeInsets.all(4.vw),
                      child:
                          Image.asset(index == 2 ? icChatSelected : icChat))),
              InkWell(
                  onTap: () {
                    setState(() {
                      index = 3;
                    });
                  },
                  child: Container(
                      width: 15.vw,
                      height: 15.vw,
                      padding: EdgeInsets.all(4.vw),
                      child: Image.asset(
                          index == 3 ? icProfileSelected : icProfile))),
            ],
          ),
        ),
      ),
    );
  }
}
