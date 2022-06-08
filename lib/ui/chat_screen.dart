import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/base_screen.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String> welcomeImages = [
    'assets/image/Rectangle 2.png',
    'assets/image/user_image.png',
    'assets/image/user_image1.png',
    'assets/image/Rectangle 129.png'
  ];
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextView('Messages',fontFamily: displayMedium,fontSize: 20.sp,),
          Container(
            margin: EdgeInsets.only(top: 2.vh,bottom: 2.vh),
            width: 100.vw,
            height: 6.vh,
            decoration: BoxDecoration(
              color: darkGreyColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              cursorColor: lightGreyColor,
              style: const TextStyle(color: white50),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search,color: yellowColor),
                fillColor: darkGreyColor,
                filled: true,
                contentPadding: EdgeInsets.only(left: 4.vw, right: 4.vw),
                hintText: 'Search',
                hintStyle:  TextStyle(color: greyColor,fontSize: 14.sp,fontFamily: 'SfUiDisplayRegular'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          CommonTextView('New matches',fontSize: 18.sp,fontFamily: displayRegular,),
          Container(
            margin: EdgeInsets.only(top: 2.vh,bottom: 2.vh),
            height: 20.vh,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              scrollDirection: Axis.horizontal,
                itemCount: welcomeImages.length,
                itemBuilder: (context,index){
                  return Container(
                      margin: EdgeInsets.only(right: 2.vw),
                    clipBehavior: Clip.antiAlias,
                    height: 10.vh,
                    width: 35.vw,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: darkGreyColor
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(welcomeImages[index],fit: BoxFit.fill,)
                      ],
                    ),
                  );
                }),
          ),
          CommonTextView('Conversation',fontFamily: displayRegular,fontSize: 18.sp,),
         SizedBox(height: 2.vh),
         Expanded(
           child: SingleChildScrollView(
             physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
             child: Wrap(
               runSpacing: 1.vw,
               children: welcomeImages.map((e) =>
                   Container(
                     padding: EdgeInsets.only(left: 2.vw,right: 2.vw),
                     height: 10.vh,
                     width: 100.vw,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: darkGreyColor,
                     ),
                     child: Row(
                       children: [
                         Container(
                             padding: EdgeInsets.all(1.vw),
                             height: 15.vw,
                             width: 15.vw,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(50),
                                 border: Border.all(color: pinkColor,width: 0.7.vw)
                             ),
                             child: Container(
                               clipBehavior: Clip.antiAlias,
                               height: 13.vw,
                               width: 13.vw,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(50),
                               ),
                               child: Image.asset(e,fit: BoxFit.fill,),
                             )
                         ),
                         SizedBox(width: 2.vw,),
                         Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             CommonTextView('Pattni',fontSize: 14.sp,fontFamily: displayRegular,),
                             CommonTextView('Hello how are you',fontFamily: displayRegular,color: white50,),
                           ],
                         ),
                         Spacer(),
                         Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             CommonTextView('5 min',fontFamily: displayRegular,color: white50,),
                             Container(
                               alignment: Alignment.center,
                               margin: EdgeInsets.only(top: 0.5.vh),
                               width: 6.vw,
                               height: 6.vw,
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(15),
                                   color: pinkColor
                               ),
                               child: CommonTextView('5'),
                             ),
                           ],
                         ),
                       ],
                     ),
                   ),
               ).toList(),
             ),
           ),
         ),

        ],
      ),
    );
  }
}