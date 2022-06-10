import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/ui/filter_screen.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/base_screen.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';

///03-06-2022
class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextView(community,fontSize: 20.sp,fontFamily: displayMedium,color: Colors.white),
                  CommonTextView(marbauUsers,fontSize: 12.sp,fontFamily: displayLight,color: white50,)
                ],
              ),
              InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const FilterScreen()));
                  },
                  child: Image.asset(icFilter,height: 3.5.vw,)),
            ],
          ),
        SizedBox(
          height: 4.vh,
        ),
        Expanded(
          child: SingleChildScrollView(
            physics:  const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Wrap(
              runSpacing: 6.vw,
              spacing: 4.vw,
              children: List.filled(20,   GestureDetector(
                onTap: (){
                  showModalBottomSheet<void>(
                    backgroundColor: Colors.transparent,
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.all(4.vw),
                        height: 75.vh,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          image: DecorationImage(image:AssetImage('assets/image/Rectangle 129.png'),fit: BoxFit.cover ),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CommonTextView('Disha Smith,24',fontSize: 20.sp,fontFamily: displayMedium,color: backGroundColor),
                            CommonTextView('Loreum Issupe',color: backGroundColor,fontFamily: displayRegular,fontSize: 12.sp),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 7.vh,
                                  width: 14.vw,
                                  decoration: BoxDecoration(
                                  ),
                                  child: Image.asset(icLeft)
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 3.vw,right: 3.vw),
                                  alignment: Alignment.center,
                                  height: 7.vh,
                                  width: 14.vw,
                                    child: Image.asset(icWhiteLike)
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 3.vw),
                                  alignment: Alignment.center,
                                  height: 7.vh,
                                  width: 14.vw,
                                    child: Image.asset(icWhiteSuperLike)
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 7.vh,
                                  width: 14.vw,
                                    child: Image.asset(icRight)
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2.vh,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Column(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      height: 27.vw,
                      width: 27.vw,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: greyColor
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset('assets/image/Rectangle 129.png',fit: BoxFit.cover,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(5),
                                height: 4.vw,
                                width: 8.vw,
                                decoration: BoxDecoration(
                                    color: pinkColor,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(icLocation1,height: 0.7.vh),
                                    SizedBox(width: 0.5.vw,),
                                    CommonTextView('2km',fontSize: 6.sp,fontFamily: displayMedium,color: Colors.white,)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 1.vh,),
                    CommonTextView('Disha Smith,24',fontFamily: displayRegular,fontSize: 12.sp,color: Colors.white,),
                  ],
                ),
              ),),
            ),
          ),
        ),
        ],
      ),
    );
  }
}
