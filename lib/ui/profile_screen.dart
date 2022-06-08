
import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/ui/edit_profile_screen.dart';
import 'package:twosoul_multipz/ui/setting_screen.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/base_screen.dart';
import 'package:twosoul_multipz/utils/widget/common_button.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> getLikes = ['25','50','75'];
  String selected = '50';
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        child: Expanded(
          child: SingleChildScrollView(
            physics:  const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 2.vh,bottom: 2.vh),
                    clipBehavior: Clip.antiAlias,
                    height: 20.vh,
                    width: 40.vw,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: pinkColor),
                    child: Image.asset('assets/image/Rectangle 129.png',fit: BoxFit.cover,),
                  ),
                ),
                Center(child: CommonTextView("Disha Smith, 23",fontSize: 20.sp,fontFamily: displayMedium)),
                Center(child: CommonTextView('Self employed',color: white50,fontSize: 16.sp,fontFamily: displayRegular,)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingScreen()));
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 9.vh,
                            width: 18.vw,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(icSetting),
                              )
                            ),
                          ),
                          SizedBox(height: 1.vh,),
                          CommonTextView(setting,fontFamily: displayRegular)
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 6.vh),
                              height: 11.vh,
                              width: 22.vw,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                image: const DecorationImage(
                                  image: AssetImage(icCamara)
                                )
                              ),

                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 0.5.vh),
                              height: 3.vh,
                              width: 6.vw,
                              child: Image.asset(icAddPhoto),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.vh,),
                        CommonTextView(addMedia,fontFamily: displayRegular)
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen()));
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5.5.vw),
                            height: 9.vh,
                            width: 18.vw,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: const DecorationImage(
                                image: AssetImage(icEditProfile),
                              )
                            ),
                          ),
                          SizedBox(height: 1.vh,),
                          CommonTextView(editProfile,fontFamily: displayRegular)
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 4.vw,right: 4.vw),
                  margin: EdgeInsets.only(top: 2.vh,bottom: 2.vh),
                  height: 10.vh,
                  decoration: BoxDecoration(
                    color: yellowColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonTextView(getCredits,fontSize: 18.sp,fontFamily: displayMedium,color: Colors.white),
                          CommonTextView(getFreeCredits,fontSize: 14.sp,color: Colors.white,fontFamily: displayLight),
                        ],
                      ),
                      Image.asset(icGetCredits,width: 8.vw,),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Column(
                     children: [
                       GestureDetector(
                         onTap: (){
                           showDialog(
                               context: context,
                               barrierColor: Colors.white.withOpacity(0.30),
                               builder: (BuildContext context) {
                                 return dialogBox(standOutWithLikes, youAreMoreLikely, icLike, likes, btnGetLikes, (){
                                 });
                               }
                           );
                         },
                         child: Container(
                           padding: EdgeInsets.all(5.vw),
                           height: 9.vh,
                           width: 18.vw,
                           decoration: const BoxDecoration(
                             image: DecorationImage(
                               image: AssetImage(icLike)
                             )
                           ),
                         ),
                       ),
                       SizedBox(
                         height: 1.vh,
                       ),
                       RichText(
                         text: TextSpan(
                           text: '22',
                           style: TextStyle(fontSize: 14.sp,color: pinkColor,fontFamily: displayRegular),
                           children:  <TextSpan>[

                             TextSpan(text: ' $likes', style: likeTextStyle),
                           ],
                         ),
                       )
                     ],
                   ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            showDialog(
                                context: context,
                                barrierColor: Colors.white.withOpacity(0.30),
                                builder: (BuildContext context) {
                                  return dialogBox(standOutWithSuperLikes, youAreMoreSuperLikely, icSuperLike, 'super like', btnGetSuperLikes, (){
                                  });
                                }
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(5.vw),
                            height: 8.5.vh,
                            width: 18.vw,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(icSuperLike)
                              )
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.vh,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: '5',
                            style: TextStyle(fontSize: 14.sp,color: yellowColor,fontFamily: displayRegular),
                            children:  <TextSpan>[
                              TextSpan(text: ' $superLikes', style: likeTextStyle),
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            showDialog(
                                context: context,
                                barrierColor: Colors.white.withOpacity(0.30),
                                builder: (BuildContext context) {
                                  return dialogBox(standOutWithRewinds, youAreMoreRewinds, icRewinds, rewinds, btnGetRewinds, (){
                                  });
                                }
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(4.vw),
                            height: 9.vh,
                            width: 18.vw,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(icRewinds),
                              )
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.vh,
                        ),
                        RichText(
                          text: TextSpan(
                            text: '8',
                            style: TextStyle(fontSize: 14.sp,color: blueColor,fontFamily: displayRegular),
                            children:  <TextSpan>[
                              TextSpan(text: ' $rewinds', style: likeTextStyle),
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4.vw),
                          height: 9.vh,
                          width: 18.vw,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: const DecorationImage(
                              image: AssetImage(icUpgrade),
                            )
                          ),
                        ),
                        SizedBox(
                          height: 1.vh,
                        ),
                      CommonTextView(upgrade,fontSize: 14.sp,color: Colors.white,fontFamily: displayLight),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 1.vh,),
                CommonTextView(whatYouGetFree,color: Colors.white,fontSize: 16.sp,fontFamily: displayMedium,),
                SizedBox(height: 1.vh,),
                Wrap(
                  runSpacing: 2.vw,
                  children: twoSoulFree.map((e) => Row(
                    children: [
                      Container(
                        height: 3.vh,
                        width: 6.vw,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icFree),
                            fit: BoxFit.fill
                          ),
                        ),
                      ),
                      SizedBox(width: 2.vw,),
                      CommonTextView(e,color: white50,fontSize: 14.sp,fontFamily: displayRegular),
                    ],
                  )).toList(),
                ),
                SizedBox(height: 1.vh,),
                CommonTextView(whatYouGetPremium,color: Colors.white,fontSize: 16.sp,fontFamily: displayMedium,),
                SizedBox(height: 1.vh,),
                Wrap(
                  runSpacing: 2.vw,
                  children: twoSoulPremium.map((e) => Row(
                    children: [
                      Container(
                        height: 3.vh,
                        width: 6.vw,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(icFree),
                              fit: BoxFit.fill
                          ),
                        ),
                      ),
                      SizedBox(width: 2.vw,),
                      CommonTextView(e,color: white50,fontSize: 14.sp,fontFamily: displayRegular),
                    ],
                  )).toList(),
                ),
                SizedBox(height: 2.vh,),
              ],
            ),
          ),
        ),
    );
  }
  Widget dialogBox(String title,String subTitle,String icon,String commonName,String btnText,Function onPressed){
    return StatefulBuilder(
      builder: (context,setState){
        return AlertDialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          content: Container(
            padding: EdgeInsets.all(4.vw),
            height: 60.vh,
            width: 100.vw,
            decoration: BoxDecoration(
                color: backGroundColor,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(icon,height: 7.vh),
                CommonTextView(title,fontSize: 18.sp,fontFamily: displayMedium,color: Colors.white),
                CommonTextView(subTitle,color: white50,fontFamily: displayRegular,fontSize: 14.sp,),
                Wrap(
                  children: getLikes.map((e) => Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            selected = e;
                          });
                        },
                        child: Container(
                            height: 11.vh,
                            width: 25.vw,
                            decoration:  BoxDecoration(
                              border:e == selected ? const Border(
                                left: BorderSide(
                                  color: greyColor,
                                  width: 1.0,
                                ),
                                right: BorderSide(
                                  color: greyColor,
                                  width: 1.0,
                                ),
                              ) : Border.all(color: Colors.transparent),
                            ),
                            child:  Column(
                              mainAxisAlignment: e == selected ? MainAxisAlignment.start : MainAxisAlignment.end,
                              children: [
                                CommonTextView(e,color: Colors.white,fontSize: 40.sp,fontFamily: displayMedium,),
                                CommonTextView(commonName,color: Colors.white,fontSize: 12.sp,fontFamily: displayLight,),
                              ],
                            )
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 4.vh,
                        width: 25.vw,
                        decoration:  BoxDecoration(
                            color: e == selected ? pinkColor : Colors.transparent,
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5)
                            )
                        ),
                        child: CommonTextView('\$.$e/ea',fontSize: 14.sp,fontFamily: displayMedium,color: Colors.white),
                      ),
                    ],
                  ),).toList(),
                ),
                CommonButton(btnText: btnText,onPressed: onPressed,),
                SizedBox(
                  height: 6.vh,
                  width: 100.vw,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                      elevation: 0,
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      color: backGroundColor,
                      child: CommonTextView(btnNoThanks,
                          fontSize: 16.sp, color: Colors.white.withOpacity(0.20),fontFamily: displayRegular)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

