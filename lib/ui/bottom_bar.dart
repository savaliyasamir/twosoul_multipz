import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/ui/chat_screen.dart';
import 'package:twosoul_multipz/ui/comunity_screen.dart';
import 'package:twosoul_multipz/ui/discover_screen.dart';
import 'package:twosoul_multipz/ui/profile_screen.dart';
import 'package:twosoul_multipz/utils/constants.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(index),
      backgroundColor: backGroundColor,
      bottomNavigationBar: Container(
        height: 8.vh,
        width: 100.vw,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bottomBackGroundImage),
            fit: BoxFit.fill
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
                onTap: (){
                  setState(() {
                    index = 0;
                  });
                },
                child: Container(
                    width: 15.vw,
                    height: 6.vh,
                    padding: EdgeInsets.all(3.vw),
                    child: Image.asset(index == 0 ? icDisCoverSelected : icDisCover))),
            InkWell(
                onTap: (){
                  setState(() {
                    index = 1;
                  });
                },
                child: Container(
                    width: 15.vw,
                    height: 6.vh,
                    padding: EdgeInsets.all(3.vw),child: Image.asset(index == 1 ? icLocation0 : icLocation1))),
            InkWell(
                onTap: (){
                  setState(() {
                    index = 2;
                  });
                },
                child: Container(
                    width: 15.vw,
                    height: 6.vh,
                    padding: EdgeInsets.all(3.vw),child: Image.asset(index == 2 ? icChatSelected : icChat))),
            InkWell(
                onTap: (){
                  setState(() {
                    index = 3;
                  });
                },
                child: Container(
                    width: 15.vw,
                    height: 6.vh,
                    padding: EdgeInsets.all(3.vw),
                    child: Image.asset(index == 3 ? icProfileSelected : icProfile))),
          ],
        ),

      ),
    );
  }
}
