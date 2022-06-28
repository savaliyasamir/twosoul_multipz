import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/Network/bloc/community/community_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/community/community_event.dart';
import 'package:twosoul_multipz/Network/view_state.dart';
import 'package:twosoul_multipz/main.dart';
import 'package:twosoul_multipz/ui/chat/chat_provider.dart';
import 'package:twosoul_multipz/ui/chat/chat_room.dart';
import 'package:twosoul_multipz/ui/message_screen.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/base_screen.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';
import 'package:twosoul_multipz/utils/widget/error_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController listScrollController = ScrollController();
  late ChatProvider chatProvider;
  @override
  void initState() {
    chatProvider = context.read<ChatProvider>();
    super.initState();
    context.read<CommunityBloc>().add(CommunityEvents.fetchData);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextView('Messages',fontFamily: displayMedium,fontSize: 20.sp,),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 2.vh,bottom: 2.vh),
            width: 100.vw,
            height: 12.vw,
            decoration: BoxDecoration(
              color: darkGreyColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              cursorColor: lightGreyColor,
              style:  TextStyle(color: white50,fontSize: 12.sp),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon:  Icon(Icons.search,color: yellowColor,size: 5.vw),
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
          BlocBuilder<CommunityBloc, ViewState>(
              builder: (BuildContext context, ViewState state) {
                if (state is ErrorState) {
                  final error = state.error;
                  return ErrorMessage(
                      error: '${error.message}\nTap to Retry.', callBack: () {});
                } else
                if (state is LoadingState) {
                  return const CustomLoader();
                } else if (state is Empty) {
                  return ErrorMessage(error: '${state.msg}', callBack: () {});
                }
                if(state is LoadedState){
                  return Container(
                    margin: EdgeInsets.only(top: 2.vh,bottom: 2.vh),
                    height: 40.vw,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        scrollDirection: Axis.horizontal,
                        itemCount: state.communityResponseModel!.data!.length,
                        itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  MessageScreen(
                                id: state.communityResponseModel!.data![index].id,
                                name:state.communityResponseModel!.data![index].name,
                                imageUrl: state.communityResponseModel!.data![index].image!.firstWhere((element) => element.isDefault =="1").imagename,
                              )));
                            },
                            child: Container(
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
                                  Image.network(state.communityResponseModel!.data![index].image!.firstWhere((element) => element.isDefault == "1").imagename.toString(),fit: BoxFit.cover,
                                    loadingBuilder: (BuildContext context, Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return  const CustomLoader();
                                  },),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      padding: EdgeInsets.only(left: 2.vw),
                                      height: 6.vh,
                                      width: 100.vw,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: darkGreyColor
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              CommonTextView(state.communityResponseModel!.data![index].name.toString(),fontSize: 15.sp,fontFamily: displayMedium,),
                                              SizedBox(width: 1.vw,),
                                              const CircleAvatar(
                                                backgroundColor: pinkColor,
                                                radius: 3,
                                              ),
                                            ],
                                          ),
                                          CommonTextView("${state.communityResponseModel!.data![index].gender} . ${state.communityResponseModel!.data![index].age}",color: white50),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                }
              return Container(
                margin: EdgeInsets.only(top: 2.vh,bottom: 2.vh),
                height: 40.vw,
                color: darkGreyColor,
              );
            }
          ),
          CommonTextView('Conversation',fontFamily: displayRegular,fontSize: 18.sp,),
         SizedBox(height: 2.vh),
       /*  Expanded(
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
                                 borderRadius: BorderRadius.circular(100),
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
                         const Spacer(),
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
                                   borderRadius: BorderRadius.circular(50),
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
         ),*/
          chatsWidget(),

        ],
      ),
    );
  }
  Widget chatsWidget() {
    return StreamBuilder<List<ChatRoom>>(
      stream: chatProvider.rooms(
          currentUserId: int.parse(getStorage.read('current_uid').toString()),
          orderByUpdatedAt: true),
      builder: (BuildContext context, AsyncSnapshot<List<ChatRoom>> snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              controller: listScrollController,
              itemBuilder: (context, index) =>
                  buildItem(context, snapshot.data![index]),
              itemCount: snapshot.data!.length,
            ),
          );
        } else {
          return Center(
              child: CommonTextView("No Conversation")
          );
        }
      },
    );
  }
  Widget buildItem(BuildContext context, ChatRoom userChat) {
    return userChat.users![0].id.toString() !=
        getStorage.read("current_uid").toString()
        ? GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MessageScreen(
                  id: userChat.users![0].id,
                  name: userChat.users![0].name ?? "",
                  imageUrl: userChat.users![0].profilePhoto ?? "",
                  groupChatId: userChat.id,
                )));
      },
      child:  Container(
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
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: pinkColor,width: 0.7.vw)
                ),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  height: 13.vw,
                  width: 13.vw,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Image.network(
                    userChat.users![0].profilePhoto! != "null"
                        ? userChat.users![0].profilePhoto.toString()
                        : "",
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const CustomLoader();
                    },
                    fit: BoxFit.cover,
                  ),
                )
            ),
            SizedBox(width: 2.vw,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextView('${userChat.users![0].name}',fontSize: 14.sp,fontFamily: displayRegular,),
                CommonTextView(userChat.lastMessages != null
                    ? userChat.lastMessages!.content
                    : "",fontFamily: displayRegular,color: white50,),
              ],
            ),
            const Spacer(),
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
                      borderRadius: BorderRadius.circular(50),
                      color: pinkColor
                  ),
                  child: CommonTextView('5'),
                ),
              ],
            ),
          ],
        ),
      ),
    )
        : GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MessageScreen(
                  id: userChat.users![1].id,
                  name: userChat.users![1].name ?? "",
                  imageUrl: userChat.users![1].profilePhoto ?? "",
                  groupChatId: userChat.id,
                )));
      },
      child:  Container(
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
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: pinkColor,width: 0.7.vw)
                ),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  height: 13.vw,
                  width: 13.vw,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Image.network(
                    // ignore: unnecessary_null_comparison
                    userChat.users![1].profilePhoto! != null
                        ? userChat.users![1].profilePhoto.toString()
                        : "",
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const CustomLoader();
                    },
                    fit: BoxFit.cover,
                  ),
                )
            ),
            SizedBox(width: 2.vw,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextView('${userChat.users![1].name}',fontSize: 14.sp,fontFamily: displayRegular,),
                CommonTextView(userChat.lastMessages != null
                    ? userChat.lastMessages!.content
                    : "",fontFamily: displayRegular,color: white50,),
              ],
            ),
            const Spacer(),
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
                      borderRadius: BorderRadius.circular(50),
                      color: pinkColor
                  ),
                  child: CommonTextView('5'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
