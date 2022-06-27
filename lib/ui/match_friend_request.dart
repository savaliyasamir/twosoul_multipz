import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/Network/bloc/accept_reject_friend_request/accept_reject_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/accept_reject_friend_request/accept_reject_event.dart';
import 'package:twosoul_multipz/Network/bloc/receive_match_friend/receive_match_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/receive_match_friend/receive_match_event.dart';
import 'package:twosoul_multipz/Network/model/request%20model/accept_reject_request_model.dart';
import 'package:twosoul_multipz/Network/model/request%20model/receive_match_request_model.dart';
import 'package:twosoul_multipz/Network/view_state.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';
import '../utils/widget/error_message.dart';

class MatchFriendRequest extends StatefulWidget {
  const MatchFriendRequest({Key? key}) : super(key: key);

  @override
  State<MatchFriendRequest> createState() => _MatchFriendRequestState();
}

class _MatchFriendRequestState extends State<MatchFriendRequest> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    context.read<ReceiveMatchBloc>().add(FetchReceiveMatchData(ReceiveMatchRequestModel(
      type: 1
    )));

  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(5.vw),
              child: Image.asset(icBackButton),
            ),
          ),
          backgroundColor: darkGreyColor,
          centerTitle: true,
          title: CommonTextView(matchRequest,fontSize: 20.sp,fontFamily: displayMedium,),
          excludeHeaderSemantics: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          bottom:  TabBar(
            onTap: (int){
              setState((){
                _tabController.index == 0 ?
                context.read<ReceiveMatchBloc>().add(FetchReceiveMatchData(ReceiveMatchRequestModel(type: 1))) :
                context.read<ReceiveMatchBloc>().add(FetchReceiveMatchData(ReceiveMatchRequestModel(type: 2)));
              });
            },
            controller: _tabController,
            indicatorColor: Colors.transparent,
            indicatorPadding: EdgeInsets.only(left: 4.vw,right: 4.vw),
            indicator: BoxDecoration(
                border: Border.all(color: lightGreyColor,width: 0.3.vw),
              borderRadius: BorderRadius.circular(20),
                ),
            tabs: [
              Container(
                padding: EdgeInsets.all(4.vw),
                width: 40.vw,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(icHeart,width: 6.vw,color: pinkColor,),
                    SizedBox(width: 2.vw,),
                    CommonTextView(like,fontSize: 15.sp,)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(4.vw),
                width: 40.vw,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(icHeart,width: 6.vw,color: yellowColor,),
                    SizedBox(width: 2.vw,),
                    CommonTextView(superLike,fontSize: 15.sp,)
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: backGroundColor,
       body:  TabBarView(
         dragStartBehavior: DragStartBehavior.start,
         physics: const NeverScrollableScrollPhysics(),
         children: [
           Padding(
             padding: EdgeInsets.only(left: 4.vw,right: 4.vw,),
             child: BlocBuilder<ReceiveMatchBloc, ViewState>(
                 builder: (BuildContext context, ViewState state) {
                   if (state is ErrorState) {
                     final error = state.error;
                     return ErrorMessage(
                         error: '${error.message}\nTap to Retry.', callBack: () {});
                   } else if (state is LoadingState) {
                     return const CustomLoader();
                   } else if (state is Empty) {
                     return ErrorMessage(error: '${state.msg}', callBack: () {});
                   }
                   if (state is LoadedState) {
                     return Expanded(
                       child: SingleChildScrollView(
                         padding: EdgeInsets.only(top: 2.vh),
                         physics: const BouncingScrollPhysics(
                             parent: AlwaysScrollableScrollPhysics()),
                         child:state.receiveMatchResponse!.data!.isNotEmpty ? Wrap(
                             spacing: 5.vw,
                             runSpacing: 5.vw,
                             clipBehavior: Clip.antiAliasWithSaveLayer,
                             alignment: WrapAlignment.start,
                             children: state.receiveMatchResponse!.data!
                                 .map((e) => Container(
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
                                   Image.network(
                                     e.sender!.image!
                                         .firstWhere((element) =>
                                     element.isDefault == "1")
                                         .imagename
                                         .toString(),
                                     fit: BoxFit.cover,
                                     loadingBuilder: (BuildContext context,
                                         Widget child,
                                         ImageChunkEvent? loadingProgress) {
                                       if (loadingProgress == null) {
                                         return child;
                                       }
                                       return const Center(
                                           child: CircularProgressIndicator(
                                             color: pinkColor,
                                           ));
                                     },
                                   ),
                                   Column(
                                     crossAxisAlignment:
                                     CrossAxisAlignment.start,
                                     children: [
                                       Container(
                                         margin: const EdgeInsets.all(6),
                                         height: 2.vh,
                                         width: 8.vw,
                                         decoration: BoxDecoration(
                                           color: pinkColor,
                                           borderRadius:
                                           BorderRadius.circular(5),
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
                                             CommonTextView('${e.sender!.distance} ${e.sender!.distanceIn}',
                                                 fontSize: 6.sp,
                                                 fontFamily: displayMedium,
                                                 color: Colors.white),
                                           ],
                                         ),
                                       ),
                                       const Spacer(),
                                       Center(
                                           child: CommonTextView('${e.sender!.name},${e.sender!.age}',
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
                                             GestureDetector(
                                               onTap: () {
                                                 context.read<AcceptRejectBloc>().add(FetchAcceptRejectData(AcceptRejectRequestModel(
                                                   senderId: e.sender!.id,
                                                   flag: 2
                                                 )));
                                                 context.read<ReceiveMatchBloc>().add(FetchReceiveMatchData(ReceiveMatchRequestModel(type: 1)));
                                               },
                                               child: Container(
                                                   padding:
                                                   EdgeInsets.all(2.vw),
                                                   width: 15.vw,
                                                   height: 5.5.vh,
                                                   child:
                                                   Image.asset(icReject)),
                                             ),
                                             Container(
                                               height: 4.vh,
                                               width: 0.3.vw,
                                               color: Colors.white,
                                             ),
                                             GestureDetector(
                                               onTap: () {
                                                 context.read<AcceptRejectBloc>().add(FetchAcceptRejectData(AcceptRejectRequestModel(
                                                     senderId: e.sender!.id,
                                                     flag: 1
                                                 )));
                                                 context.read<ReceiveMatchBloc>().add(FetchReceiveMatchData(ReceiveMatchRequestModel(type: 1)));
                                               },
                                               child: Container(
                                                   padding:
                                                   EdgeInsets.all(3.5.vw),
                                                   width: 15.vw,
                                                   height: 5.5.vh,
                                                   child: Image.asset(
                                                      icCheck),
                                               ),
                                             ),
                                           ],
                                         ),
                                       ),
                                     ],
                                   ),
                                 ],
                               ),
                             ))
                                 .toList()) : SizedBox(
                           height: 60.vh,
                           child: Center(
                             child: CommonTextView('No Data Found',
                                 color: lightGreyColor,
                                 fontSize: 20.sp,
                                 fontFamily: displayMedium),
                           ),
                         ),
                       ),
                     );
                   }
                   return const Center(
                       child: CircularProgressIndicator(
                         color: pinkColor,
                       ));
                 }),
           ),
           Padding(
             padding: EdgeInsets.only(left: 4.vw,right: 4.vw,),
             child: BlocBuilder<ReceiveMatchBloc, ViewState>(
                 builder: (BuildContext context, ViewState state) {
                   if (state is ErrorState) {
                     final error = state.error;
                     return ErrorMessage(
                         error: '${error.message}\nTap to Retry.', callBack: () {});
                   } else if (state is LoadingState) {
                     return const CustomLoader();
                   } else if (state is Empty) {
                     return ErrorMessage(error: '${state.msg}', callBack: () {});
                   }
                   if (state is LoadedState) {
                     return Expanded(
                       child: SingleChildScrollView(
                         padding: EdgeInsets.only(top: 2.vh),
                         physics: const BouncingScrollPhysics(
                             parent: AlwaysScrollableScrollPhysics()),
                         child:state.receiveMatchResponse!.data!.isNotEmpty ? Wrap(
                             spacing: 5.vw,
                             runSpacing: 5.vw,
                             clipBehavior: Clip.antiAliasWithSaveLayer,
                             alignment: WrapAlignment.start,
                             children: state.receiveMatchResponse!.data!
                                 .map((e) => Container(
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
                                   Image.network(
                                     e.sender!.image!
                                         .firstWhere((element) =>
                                     element.isDefault == "1")
                                         .imagename
                                         .toString(),
                                     fit: BoxFit.cover,
                                     loadingBuilder: (BuildContext context,
                                         Widget child,
                                         ImageChunkEvent? loadingProgress) {
                                       if (loadingProgress == null) {
                                         return child;
                                       }
                                       return const Center(
                                           child: CircularProgressIndicator(
                                             color: pinkColor,
                                           ));
                                     },
                                   ),
                                   Column(
                                     crossAxisAlignment:
                                     CrossAxisAlignment.start,
                                     children: [
                                       Container(
                                         margin: const EdgeInsets.all(6),
                                         height: 2.vh,
                                         width: 8.vw,
                                         decoration: BoxDecoration(
                                           color: pinkColor,
                                           borderRadius:
                                           BorderRadius.circular(5),
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
                                             CommonTextView('${e.sender!.distance} ${e.sender!.distanceIn}',
                                                 fontSize: 6.sp,
                                                 fontFamily: displayMedium,
                                                 color: Colors.white),
                                           ],
                                         ),
                                       ),
                                       const Spacer(),
                                       Center(
                                           child: CommonTextView('${e.sender!.name},${e.sender!.age}',
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
                                             GestureDetector(
                                               onTap: () {
                                                 context.read<AcceptRejectBloc>().add(FetchAcceptRejectData(AcceptRejectRequestModel(
                                                     senderId: e.sender!.id,
                                                     flag: 2
                                                 )));
                                                 context.read<ReceiveMatchBloc>().add(FetchReceiveMatchData(ReceiveMatchRequestModel(type: 2)));
                                               },
                                               child: Container(
                                                   padding:
                                                   EdgeInsets.all(2.vw),
                                                   width: 15.vw,
                                                   height: 5.5.vh,
                                                   child:
                                                   Image.asset(icReject)),
                                             ),
                                             Container(
                                               height: 4.vh,
                                               width: 0.3.vw,
                                               color: Colors.white,
                                             ),
                                             GestureDetector(
                                               onTap: () {
                                                 context.read<AcceptRejectBloc>().add(FetchAcceptRejectData(AcceptRejectRequestModel(
                                                     senderId: e.sender!.id,
                                                     flag: 1
                                                 )));
                                                 context.read<ReceiveMatchBloc>().add(FetchReceiveMatchData(ReceiveMatchRequestModel(type: 2)));
                                               },
                                               child: Container(
                                                 padding:
                                                 EdgeInsets.all(3.5.vw),
                                                 width: 15.vw,
                                                 height: 5.5.vh,
                                                 child: Image.asset(
                                                     icCheck),
                                               ),
                                             ),
                                           ],
                                         ),
                                       ),
                                     ],
                                   ),
                                 ],
                               ),
                             ))
                                 .toList()) : SizedBox(
                           height: 60.vh,
                           child: Center(
                             child: CommonTextView('No Data Found',
                                 color: lightGreyColor,
                                 fontSize: 20.sp,
                                 fontFamily: displayMedium),
                           ),
                         ),
                       ),
                     );
                   }
                   return const Center(
                       child: CircularProgressIndicator(
                         color: pinkColor,
                       ));
                 }),
           ),
         ],
         controller: _tabController,
       ),
      ),
    );
  }
}
