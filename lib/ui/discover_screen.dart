import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:resize/resize.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:twosoul_multipz/ui/filter_screen.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/base_screen.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';

///03-06-2022

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  bool wrapView = true;
  final _swipeController = SwipableStackController();
  int lastIndex = 0;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      wrapView = !wrapView;
                    });
                  },
                  child: Image.asset(
                    wrapView ? icDisCoverSelected : icMenu,
                    width: 5.vw,
                  )),
              Column(
                children: [
                  CommonTextView(discover,
                      fontSize: 20.sp, fontFamily: displayMedium),
                  CommonTextView('Houston,USA',
                      fontFamily: displayLight, color: white50)
                ],
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FilterScreen()));
                  },
                  child: Image.asset(
                    icFilter,
                    height: 3.5.vw,
                  )),
            ],
          ),
          wrapView ?
              ///wrap view
              Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 2.vh),
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    child: Wrap(
                      spacing: 5.vw,
                      runSpacing: 5.vw,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      alignment: WrapAlignment.start,
                      children: List.filled(
                          40,
                          Container(
                            clipBehavior: Clip.antiAlias,
                            width: 43.vw,
                            height: 56.vw,
                            decoration: BoxDecoration(
                              color: greyColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  'assets/image/Rectangle 129.png',
                                  fit: BoxFit.fitWidth,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(6),
                                      height: 2.vh,
                                      width: 8.vw,
                                      decoration: BoxDecoration(
                                        color: pinkColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(icLocation1,
                                              height: 1.5.vw),
                                          SizedBox(
                                            width: 0.5.vw,
                                          ),
                                          CommonTextView('2km',
                                              fontSize: 6.sp,
                                              fontFamily: displayMedium,
                                              color: Colors.white),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Center(
                                        child: CommonTextView('Disha Smith,24',
                                            fontSize: 16.sp,
                                            fontFamily: displayRegular)),
                                    Container(
                                      margin: EdgeInsets.only(top: 1.vh),
                                      padding: EdgeInsets.only(
                                          left: 3.vw, right: 3.vw),
                                      height: 5.5.vh,
                                      width: 100.vw,
                                      color: pinkColor,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Image.asset(icReject, height: 3.vh),
                                          Container(
                                            height: 4.vh,
                                            width: 0.3.vw,
                                            color: Colors.white,
                                          ),
                                          Image.asset(icHeart, height: 2.vh),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                )
              :
              ///swappable stack view
              Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Visibility(
                      visible: welcomeImages.isNotEmpty,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                _swipeController.next(
                                    swipeDirection: SwipeDirection.down);
                              },
                              child: Image.asset(icRemove, width: 15.vw)),
                          GestureDetector(
                              onTap: () {
                                _swipeController.next(
                                    swipeDirection: SwipeDirection.left);
                              },
                              child: Image.asset(icRewinds, width: 15.vw)),
                          GestureDetector(
                              onTap: () {
                                _swipeController.next(
                                    swipeDirection: SwipeDirection.right);
                              },
                              child: Image.asset(icSuperLike, width: 15.vw)),
                          GestureDetector(
                              onTap: () {
                                _swipeController.next(
                                    swipeDirection: SwipeDirection.up);
                              },
                              child: Image.asset(icLike, width: 15.vw)),
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(bottom: 10.vh, top: 4.vh),
                        height: 60.vh,
                        child: SwipableStack(
                          overlayBuilder: (context, properties) {
                            final opacity = min(properties.swipeProgress, 1.0);
                            final isRight =
                                properties.direction == SwipeDirection.right;
                            final isLeft =
                                properties.direction == SwipeDirection.left;
                            final isUp =
                                properties.direction == SwipeDirection.up;
                            return Center(
                              child: Opacity(
                                opacity: opacity,
                                child: Image.asset(
                                  isUp
                                      ? icLike
                                      : isRight
                                          ? icSuperLike
                                          : isLeft
                                              ? icRewinds
                                              : icRemove,
                                  width: 15.vw,
                                ),
                              ),
                            );
                          },
                          controller: _swipeController,
                          stackClipBehaviour: Clip.none,
                          itemCount: welcomeImages.length,
                          builder: (BuildContext context, swipeProperty) {
                            return GestureDetector(
                              onTap: () {
                                showModalBottomSheet<void>(
                                  isScrollControlled: true,
                                  backgroundColor: backGroundColor,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return bottomSheet(swipeProperty.index);
                                  },
                                );
                              },
                              child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 60.vh,
                                  width: 100.vw,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Image.asset(
                                          welcomeImages[swipeProperty.index],
                                          fit: BoxFit.fill),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.all(3.vw),
                                            height: 3.vh,
                                            width: 12.vw,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: pinkColor),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  icLocation1,
                                                  width: 2.vw,
                                                ),
                                                SizedBox(width: 1.vw),
                                                CommonTextView('2km',
                                                    fontFamily: displayMedium,
                                                    fontSize: 8.sp),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.only(left: 4.vw),
                                            height: 7.vh,
                                            width: 100.vw,
                                            color: pinkColor,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CommonTextView(
                                                  'Disha Smith,24',
                                                  fontFamily: displayMedium,
                                                  fontSize: 20.sp,
                                                ),
                                                CommonTextView(
                                                  'Loreum Issupe',
                                                  fontFamily: displayRegular,
                                                  color: Colors.white
                                                      .withOpacity(0.80),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            );
                          },
                        )),
                  ],
                ),
        ],
      ),
    );
  }

  ///bottom_sheet
  Widget bottomSheet(int index) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          height: 45.vh,
          width: 100.vw,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(welcomeImages[index]), fit: BoxFit.cover),
          ),
        ),
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 4.vw, top: 8.vh, bottom: 33.vh),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(icBackButton, width: 3.vw),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 4.vw, right: 4.vw, top: 3.vh),
                  width: 100.vw,
                  decoration: BoxDecoration(
                      color: backGroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonTextView(
                            'Disha Smith,24 ',
                            fontFamily: displayMedium,
                            fontSize: 20.sp,
                          ),
                          Image.asset(icSend, width: 7.vw),
                        ],
                      ),
                      CommonTextView(
                        'Female',
                        fontSize: 14.sp,
                        color: white50,
                        fontFamily: displayRegular,
                      ),
                      SizedBox(
                        height: 2.vh,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonTextView(
                            location,
                            fontFamily: displayMedium,
                            fontSize: 16.sp,
                          ),
                          Container(
                            height: 3.vh,
                            width: 12.vw,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: pinkColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  icLocation1,
                                  width: 2.vw,
                                ),
                                SizedBox(width: 1.vw),
                                CommonTextView('2km',
                                    fontFamily: displayMedium, fontSize: 8.sp),
                              ],
                            ),
                          ),
                        ],
                      ),
                      CommonTextView(
                        'Houstan, United Status',
                        color: white50,
                        fontFamily: displayRegular,
                        fontSize: 14.sp,
                      ),
                      SizedBox(
                        height: 2.vh,
                      ),
                      CommonTextView(
                        about,
                        fontFamily: displayMedium,
                        fontSize: 16.sp,
                      ),
                      CommonTextView(
                        'Lorem Ipsum is simply dummy text of printing setting as a industry.Lorem Ipsum is simply dummy text of printingtypesetting as a industry.',
                        fontSize: 14.sp,
                        fontFamily: displayRegular,
                        color: white50,
                      ),
                      SizedBox(
                        height: 2.vh,
                      ),
                      CommonTextView(
                        height,
                        fontFamily: displayMedium,
                        fontSize: 16.sp,
                      ),
                      CommonTextView(
                        '172 cm',
                        fontSize: 14.sp,
                        fontFamily: displayRegular,
                        color: white50,
                      ),
                      SizedBox(
                        height: 2.vh,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonTextView(
                            txtGallery,
                            fontFamily: displayMedium,
                            fontSize: 16.sp,
                          ),
                          CommonTextView(
                            seeAll,
                            fontFamily: displayLight,
                            fontSize: 10.sp,
                            color: pinkColor,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.vh,
                      ),
                      StaggeredGrid.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 2.vw,
                        mainAxisSpacing: 2.vw,
                        children: welcomeImages
                            .map(
                              (e) => Image.asset(e),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
