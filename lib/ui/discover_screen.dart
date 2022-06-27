import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:resize/resize.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:twosoul_multipz/Network/bloc/add_rewind/add_rewind_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/add_rewind/add_rewind_event.dart';
import 'package:twosoul_multipz/Network/bloc/filter_%20data/filter_data_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/home_page/home_page_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/send_match_friend/send_match_friend_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/send_match_friend/send_match_friend_event.dart';
import 'package:twosoul_multipz/Network/model/request%20model/home_page_request_model.dart';
import 'package:twosoul_multipz/Network/model/request%20model/send_match_friend_request_model.dart';
import 'package:twosoul_multipz/Network/model/request%20model/sned_type_request_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/home_page_response_model.dart';
import 'package:twosoul_multipz/Network/view_state.dart';
import 'package:twosoul_multipz/main.dart';
import 'package:twosoul_multipz/ui/filter_screen.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/base_screen.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';
import 'package:twosoul_multipz/utils/widget/error_message.dart';

import '../Network/bloc/home_page/home_page_event.dart';

///03-06-2022

class DiscoverScreen extends StatefulWidget {
  bool filter;
  DiscoverScreen({Key? key, required this.filter}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  bool wrapView = true;
  final _swipeController = SwipableStackController();
  int lastIndex = 0;
  String? deviceAToken;
  Position? currentLocation;
  List<String> welcomeImages = [
    'assets/image/Rectangle 2.png',
    'assets/image/user_image.png',
    'assets/image/user_image1.png',
    'assets/image/Rectangle 129.png'
  ];
  bool isFilter = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      isFilter = widget.filter;
      if (widget.filter == false) {
        determinePosition();
      }
    });
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (!serviceEnabled) {
      await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
      return Future.error(locationDenied);
    }

    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      return Future.error(locationPermanentlyDenied);
    }
    if (serviceEnabled) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentLocation = position;
      FirebaseMessaging.instance.getToken().then((value) {
        getStorage.write('device_token', value);
        context.read<HomePageBloc>().add(FetchHomePageData(HomePageRequestModel(
              longitude: position.longitude,
              latitude: position.latitude,
              deviceToken: value,
              distance: 20,
              limit: 20,
            )));
      });
      getStorage.write('longitude', position.longitude);
      getStorage.write('latitude', position.latitude);
    }
    return await Geolocator.getCurrentPosition();
  }

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
                  CommonTextView(
                      '${getStorage.read(getCity)},${getStorage.read(getCountry)}',
                      fontFamily: displayLight,
                      color: white50)
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
          !isFilter
              ? BlocBuilder<HomePageBloc, ViewState>(
                  builder: (BuildContext context, ViewState data) {
                  if (data is ErrorState) {
                    final error = data.error;
                    return ErrorMessage(
                        error: '${error.message}\nTap to Retry.',
                        callBack: () {});
                  } else if (data is LoadingState) {
                    return CustomLoader();
                  } else if (data is Empty) {
                    return ErrorMessage(error: '${data.msg}', callBack: () {});
                  }
                  if (data is LoadedState) {
                    return data.homePageResponse!.data!.isNotEmpty
                        ? wrapView
                            ? Expanded(
                                child: SingleChildScrollView(
                                  padding: EdgeInsets.only(top: 2.vh),
                                  physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  child: Wrap(
                                    spacing: 5.vw,
                                    runSpacing: 5.vw,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    alignment: WrapAlignment.start,
                                    children:
                                        data.homePageResponse!.data!.map((e) {
                                      return Container(
                                        clipBehavior: Clip.antiAlias,
                                        width: 43.vw,
                                        height: 56.vw,
                                        decoration: BoxDecoration(
                                          color: greyColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            Image.network(
                                              e.image!
                                                  .firstWhere((element) =>
                                                      element.isDefault == "1")
                                                  .imagename!,
                                              fit: BoxFit.cover,
                                              loadingBuilder: (BuildContext context, Widget child,
                                                  ImageChunkEvent? loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return  const CustomLoader();
                                              },
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(6),
                                                  height: 2.vh,
                                                  width: 8.vw,
                                                  decoration: BoxDecoration(
                                                    color: pinkColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(icLocation1,
                                                          height: 1.5.vw),
                                                      SizedBox(
                                                        width: 0.5.vw,
                                                      ),
                                                      CommonTextView(
                                                          '${e.distance} km',
                                                          fontSize: 6.sp,
                                                          fontFamily:
                                                              displayMedium,
                                                          color: Colors.white),
                                                    ],
                                                  ),
                                                ),
                                                const Spacer(),
                                                Center(
                                                    child: CommonTextView(
                                                        '${e.name},${e.age}',
                                                        fontSize: 16.sp,
                                                        fontFamily:
                                                            displayRegular)),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 1.vh),
                                                  padding: EdgeInsets.only(
                                                      left: 3.vw, right: 3.vw),
                                                  height: 5.5.vh,
                                                  width: 100.vw,
                                                  color: pinkColor,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            context
                                                                .read<
                                                                    SendMatchFriendBloc>()
                                                                .add(FetchSendMatchData(
                                                                    SendMatchFriendRequestModel(
                                                                  receiverId:
                                                                      e.id,
                                                                  type: 0,
                                                                )));
                                                            context
                                                                .read<
                                                                    HomePageBloc>()
                                                                .add(FetchHomePageData(
                                                                    HomePageRequestModel(
                                                                  longitude:
                                                                      currentLocation!
                                                                          .longitude,
                                                                  latitude:
                                                                      currentLocation!
                                                                          .latitude,
                                                                  deviceToken:
                                                                      getStorage
                                                                          .read(
                                                                              'device_token'),
                                                                  distance: 20,
                                                                  limit: 20,
                                                                )));
                                                          });
                                                        },
                                                        child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2.vw),
                                                            width: 15.vw,
                                                            height: 5.5.vh,
                                                            child: Image.asset(
                                                                icReject)),
                                                      ),
                                                      Container(
                                                        height: 4.vh,
                                                        width: 0.3.vw,
                                                        color: Colors.white,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            context
                                                                .read<
                                                                    SendMatchFriendBloc>()
                                                                .add(FetchSendMatchData(
                                                                    SendMatchFriendRequestModel(
                                                                  receiverId:
                                                                      e.id,
                                                                  type: 1,
                                                                )));

                                                            context
                                                                .read<
                                                                    HomePageBloc>()
                                                                .add(FetchHomePageData(
                                                                    HomePageRequestModel(
                                                                  longitude:
                                                                      currentLocation!
                                                                          .longitude,
                                                                  latitude:
                                                                      currentLocation!
                                                                          .latitude,
                                                                  deviceToken:
                                                                      getStorage
                                                                          .read(
                                                                              'device_token'),
                                                                  distance: 20,
                                                                  limit: 20,
                                                                )));
                                                          });
                                                        },
                                                        child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    3.5.vw),
                                                            width: 15.vw,
                                                            height: 5.5.vh,
                                                            child: Image.asset(
                                                                icHeart)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              )
                            : Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Visibility(
                                    visible:
                                        data.homePageResponse!.data!.isNotEmpty,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              _swipeController.next(
                                                  swipeDirection:
                                                      SwipeDirection.down);
                                              context.read<SendMatchFriendBloc>().add(FetchSendMatchData(SendMatchFriendRequestModel(
                                                receiverId: data.homePageResponse!.data![lastIndex].id,
                                                type: 0,
                                              )));
                                              data.homePageResponse!.data!.removeAt(lastIndex);
                                              lastIndex = lastIndex + 1;
                                            },
                                            child: Image.asset(icRemove,
                                                width: 15.vw)),
                                        GestureDetector(
                                            onTap: () {
                                              _swipeController.next(
                                                  swipeDirection:
                                                      SwipeDirection.left);
                                              context.read<AddRewindBloc>().add(FetchAddRewindData(AddRewindRequestModel(
                                                receiver_id: data.homePageResponse!.data![lastIndex].id
                                              )));
                                              data.homePageResponse!.data!.removeAt(lastIndex);
                                              lastIndex = lastIndex + 1;

                                            },
                                            child: Image.asset(icRewinds,
                                                width: 15.vw)),
                                        GestureDetector(
                                            onTap: () {
                                              _swipeController.next(
                                                  swipeDirection:
                                                      SwipeDirection.right);
                                              context.read<SendMatchFriendBloc>().add(FetchSendMatchData(SendMatchFriendRequestModel(
                                                receiverId: data.homePageResponse!.data![lastIndex].id,
                                                type: 2,
                                              )));
                                              data.homePageResponse!.data!.removeAt(lastIndex);
                                              lastIndex = lastIndex + 1;
                                            },
                                            child: Image.asset(icSuperLike,
                                                width: 15.vw)),
                                        GestureDetector(
                                            onTap: () {
                                           setState((){
                                             _swipeController.next(
                                                 swipeDirection:
                                                 SwipeDirection.up);
                                             context.read<SendMatchFriendBloc>().add(FetchSendMatchData(SendMatchFriendRequestModel(
                                               receiverId: data.homePageResponse!.data![lastIndex].id,
                                               type: 1,
                                             )));
                                             data.homePageResponse!.data!.removeAt(lastIndex);
                                             lastIndex = lastIndex + 1;

                                           });
                                            },
                                            child: Image.asset(icLike,
                                                width: 15.vw)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          bottom: 10.vh, top: 4.vh),
                                      height: 60.vh,
                                      child: SwipableStack(
                                        overlayBuilder: (context, properties) {
                                          final opacity = min(
                                              properties.swipeProgress, 1.0);
                                          final isRight =
                                              properties.direction ==
                                                  SwipeDirection.right;
                                          final isLeft = properties.direction ==
                                              SwipeDirection.left;
                                          final isUp = properties.direction ==
                                              SwipeDirection.up;
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
                                        onSwipeCompleted: (index,swipe){
                                          setState((){
                                            swipe == SwipeDirection.right?
                                              context.read<SendMatchFriendBloc>().add(FetchSendMatchData(SendMatchFriendRequestModel(
                                                receiverId: data.homePageResponse!.data![lastIndex].id,
                                                type: 2,
                                              ))) :
                                            swipe == SwipeDirection.left ?
                                            context.read<AddRewindBloc>().add(FetchAddRewindData(AddRewindRequestModel(
                                              receiver_id: data.homePageResponse!.data![lastIndex].id
                                            ))):
                                            swipe == SwipeDirection.up ?
                                            context.read<SendMatchFriendBloc>().add(FetchSendMatchData(SendMatchFriendRequestModel(
                                              receiverId: data.homePageResponse!.data![lastIndex].id,
                                              type: 1,
                                            ))) :
                                            context.read<SendMatchFriendBloc>().add(FetchSendMatchData(SendMatchFriendRequestModel(
                                              receiverId: data.homePageResponse!.data![lastIndex].id,
                                              type: 0,
                                            )));
                                            data.homePageResponse!.data!.removeAt(lastIndex);
                                            lastIndex = lastIndex + 1;
                                          });
                                        },
                                        itemCount:
                                            data.homePageResponse!.data!.length,
                                        builder: (BuildContext context,
                                            swipeProperty) {
                                          return GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet<void>(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    backGroundColor,
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return bottomSheet(
                                                      swipeProperty.index,
                                                      data.homePageResponse!
                                                          .data);
                                                },
                                              );
                                            },
                                            child: Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                height: 60.vh,
                                                width: 100.vw,
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  children: [
                                                    Image.network(
                                                        data
                                                            .homePageResponse!
                                                            .data![swipeProperty
                                                                .index]
                                                            .image!
                                                            .firstWhere((element) =>
                                                                element
                                                                    .isDefault ==
                                                                "1")
                                                            .imagename
                                                            .toString(),
                                                        fit: BoxFit.fill),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.all(
                                                                  3.vw),
                                                          height: 3.vh,
                                                          width: 12.vw,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: pinkColor),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Image.asset(
                                                                icLocation1,
                                                                width: 2.vw,
                                                              ),
                                                              SizedBox(
                                                                  width: 1.vw),
                                                              CommonTextView(
                                                                  '${data.homePageResponse!.data![swipeProperty.index].distance}${data.homePageResponse!.data![swipeProperty.index].distanceIn}',
                                                                  fontFamily:
                                                                      displayMedium,
                                                                  fontSize:
                                                                      8.sp),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 4.vw),
                                                          height: 7.vh,
                                                          width: 100.vw,
                                                          color: pinkColor,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CommonTextView(
                                                                '${data.homePageResponse!.data![swipeProperty.index].name},${data.homePageResponse!.data![swipeProperty.index].age}',
                                                                fontFamily:
                                                                    displayMedium,
                                                                fontSize: 20.sp,
                                                              ),
                                                              CommonTextView(
                                                                '${data.homePageResponse!.data![swipeProperty.index].city!.name},${data.homePageResponse!.data![swipeProperty.index].country!.name}',
                                                                fontFamily:
                                                                    displayRegular,
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.80),
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
                              )
                        : SizedBox(
                            height: 80.vh,
                            child: Center(
                              child: CommonTextView('No Data Found',
                                  color: lightGreyColor,
                                  fontSize: 20.sp,
                                  fontFamily: displayMedium),
                            ),
                          );
                  }
                  return
                    CustomLoader();
                })
              : BlocBuilder<FilterDataBloc, ViewState>(
                  builder: (BuildContext context, ViewState data) {
                  if (data is ErrorState) {
                    final error = data.error;
                    return ErrorMessage(
                        error: '${error.message}\nTap to Retry.',
                        callBack: () {});
                  } else if (data is LoadingState) {
                    return SizedBox(
                        height: 80.vh,
                        child: const Center(
                            child: CircularProgressIndicator(
                          color: pinkColor,
                        )));
                  } else if (data is Empty) {
                    return ErrorMessage(error: '${data.msg}', callBack: () {});
                  }
                  if (data is LoadedState) {
                    return data.homePageResponse!.data!.isNotEmpty
                        ? wrapView
                            ? Expanded(
                                child: SingleChildScrollView(
                                  padding: EdgeInsets.only(top: 2.vh),
                                  physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  child: Wrap(
                                    spacing: 5.vw,
                                    runSpacing: 5.vw,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    alignment: WrapAlignment.start,
                                    children:
                                        data.homePageResponse!.data!.map((e) {
                                      return Container(
                                        clipBehavior: Clip.antiAlias,
                                        width: 43.vw,
                                        height: 56.vw,
                                        decoration: BoxDecoration(
                                          color: greyColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            Image.network(
                                              e.image!
                                                  .firstWhere((element) =>
                                                      element.isDefault == "1")
                                                  .imagename!,
                                              fit: BoxFit.cover,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(6),
                                                  height: 2.vh,
                                                  width: 8.vw,
                                                  decoration: BoxDecoration(
                                                    color: pinkColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(icLocation1,
                                                          height: 1.5.vw),
                                                      SizedBox(
                                                        width: 0.5.vw,
                                                      ),
                                                      CommonTextView(
                                                          '${e.distance} km',
                                                          fontSize: 6.sp,
                                                          fontFamily:
                                                              displayMedium,
                                                          color: Colors.white),
                                                    ],
                                                  ),
                                                ),
                                                const Spacer(),
                                                Center(
                                                    child: CommonTextView(
                                                        '${e.name},${e.age}',
                                                        fontSize: 16.sp,
                                                        fontFamily:
                                                            displayRegular)),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 1.vh),
                                                  padding: EdgeInsets.only(
                                                      left: 3.vw, right: 3.vw),
                                                  height: 5.5.vh,
                                                  width: 100.vw,
                                                  color: pinkColor,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Image.asset(icReject,
                                                          height: 3.vh),
                                                      Container(
                                                        height: 4.vh,
                                                        width: 0.3.vw,
                                                        color: Colors.white,
                                                      ),
                                                      Image.asset(icHeart,
                                                          height: 2.vh),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              )
                            : Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Visibility(
                                    visible:
                                        data.homePageResponse!.data!.isNotEmpty,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              _swipeController.next(
                                                  swipeDirection:
                                                      SwipeDirection.down);
                                            },
                                            child: Image.asset(icRemove,
                                                width: 15.vw)),
                                        GestureDetector(
                                            onTap: () {
                                              _swipeController.next(
                                                  swipeDirection:
                                                      SwipeDirection.left);
                                            },
                                            child: Image.asset(icRewinds,
                                                width: 15.vw)),
                                        GestureDetector(
                                            onTap: () {
                                              _swipeController.next(
                                                  swipeDirection:
                                                      SwipeDirection.right);
                                            },
                                            child: Image.asset(icSuperLike,
                                                width: 15.vw)),
                                        GestureDetector(
                                            onTap: () {
                                              _swipeController.next(
                                                  swipeDirection:
                                                      SwipeDirection.up);
                                            },
                                            child: Image.asset(icLike,
                                                width: 15.vw)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          bottom: 10.vh, top: 4.vh),
                                      height: 60.vh,
                                      child: SwipableStack(
                                        overlayBuilder: (context, properties) {
                                          final opacity = min(
                                              properties.swipeProgress, 1.0);
                                          final isRight =
                                              properties.direction ==
                                                  SwipeDirection.right;
                                          final isLeft = properties.direction ==
                                              SwipeDirection.left;
                                          final isUp = properties.direction ==
                                              SwipeDirection.up;
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
                                        itemCount:
                                            data.homePageResponse!.data!.length,
                                        builder: (BuildContext context,
                                            swipeProperty) {
                                          return GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet<void>(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    backGroundColor,
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return bottomSheet(
                                                      swipeProperty.index,
                                                      data.homePageResponse!
                                                          .data);
                                                },
                                              );
                                            },
                                            child: Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                height: 60.vh,
                                                width: 100.vw,
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  children: [
                                                    Image.network(
                                                        data
                                                            .homePageResponse!
                                                            .data![swipeProperty
                                                                .index]
                                                            .image!
                                                            .firstWhere((element) =>
                                                                element
                                                                    .isDefault ==
                                                                "1")
                                                            .imagename
                                                            .toString(),
                                                        fit: BoxFit.fill),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.all(
                                                                  3.vw),
                                                          height: 3.vh,
                                                          width: 12.vw,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: pinkColor),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Image.asset(
                                                                icLocation1,
                                                                width: 2.vw,
                                                              ),
                                                              SizedBox(
                                                                  width: 1.vw),
                                                              CommonTextView(
                                                                  '${data.homePageResponse!.data![swipeProperty.index].distance}${data.homePageResponse!.data![swipeProperty.index].distanceIn}',
                                                                  fontFamily:
                                                                      displayMedium,
                                                                  fontSize:
                                                                      8.sp),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 4.vw),
                                                          height: 7.vh,
                                                          width: 100.vw,
                                                          color: pinkColor,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CommonTextView(
                                                                '${data.homePageResponse!.data![swipeProperty.index].name},${data.homePageResponse!.data![swipeProperty.index].age}',
                                                                fontFamily:
                                                                    displayMedium,
                                                                fontSize: 20.sp,
                                                              ),
                                                              CommonTextView(
                                                                '${data.homePageResponse!.data![swipeProperty.index].city!.name},${data.homePageResponse!.data![swipeProperty.index].country!.name}',
                                                                fontFamily:
                                                                    displayRegular,
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.80),
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
                              )
                        : SizedBox(
                            height: 80.vh,
                            child: Center(
                              child: CommonTextView('No Data Found',
                                  color: lightGreyColor,
                                  fontSize: 20.sp,
                                  fontFamily: displayMedium),
                            ),
                          );
                  }
                  return const Center(
                      child: CircularProgressIndicator(
                    color: pinkColor,
                  ));
                })
        ],
      ),
    );
  }

  ///bottom_sheet
  Widget bottomSheet(int index, List<HomeData>? data) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          height: 45.vh,
          width: 100.vw,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(data![index]
                    .image!
                    .firstWhere((element) => element.isDefault == "1")
                    .imagename
                    .toString()),
                fit: BoxFit.cover),
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
                      ///name And gender
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonTextView(
                            '${data[index].name}, ${data[index].age}',
                            fontFamily: displayMedium,
                            fontSize: 20.sp,
                          ),
                          Image.asset(icSend, width: 7.vw),
                        ],
                      ),
                      CommonTextView(
                        '${data[index].gender}',
                        fontSize: 14.sp,
                        color: white50,
                        fontFamily: displayRegular,
                      ),
                      SizedBox(
                        height: 2.vh,
                      ),

                      ///location
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
                                CommonTextView(
                                    '${data[index].distance}${data[index].distanceIn}',
                                    fontFamily: displayMedium,
                                    fontSize: 8.sp),
                              ],
                            ),
                          ),
                        ],
                      ),
                      CommonTextView(
                        '${data[index].city!.name}, ${data[index].country!.name}',
                        color: white50,
                        fontFamily: displayRegular,
                        fontSize: 14.sp,
                      ),
                      SizedBox(
                        height: 2.vh,
                      ),

                      ///about
                      CommonTextView(
                        about,
                        fontFamily: displayMedium,
                        fontSize: 16.sp,
                      ),
                      CommonTextView(
                        "${data[index].about}",
                        fontSize: 14.sp,
                        fontFamily: displayRegular,
                        color: white50,
                      ),
                      SizedBox(
                        height: 2.vh,
                      ),

                      ///height
                      CommonTextView(
                        height,
                        fontFamily: displayMedium,
                        fontSize: 16.sp,
                      ),
                      CommonTextView(
                        '${data[index].height} cm',
                        fontSize: 14.sp,
                        fontFamily: displayRegular,
                        color: white50,
                      ),
                      SizedBox(
                        height: 2.vh,
                      ),

                      ///gallery
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
                        children: data[index]
                            .image!
                            .map(
                              (e) => Image.network(e.imagename.toString()),
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
