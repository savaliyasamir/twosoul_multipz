

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/Network/model/response%20model/common_model/user_data_model.dart';
import 'package:twosoul_multipz/main.dart';
import 'package:twosoul_multipz/ui/chat/chat_provider.dart';
import 'package:twosoul_multipz/ui/chat/chat_room.dart';
import 'dart:math' as math;
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';

class MessageScreen extends StatefulWidget {
  int? id;
  String? name;
  String? imageUrl;
  String? groupChatId;

   MessageScreen({Key? key,this.id,this.name,this.imageUrl,this.groupChatId = ""}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen>with TickerProviderStateMixin {
  TextEditingController contentController = TextEditingController();
   AnimationController? _controller;
   List<IconData> icons = const [ Icons.gif_box, Icons.camera_alt, Icons.image_sharp,Icons.keyboard_voice_sharp ];
  final ScrollController listScrollController = ScrollController();
  late ChatProvider chatProvider;
  late ChatRoom chatRoom;
  List<QueryDocumentSnapshot> listMessage = [];
  int _limit = 20;
  final int _limitIncrement = 20;
  @override
  void initState() {
    chatProvider = context.read<ChatProvider>();
    listScrollController.addListener(_scrollListener);
    readLocal();
    ChatRoom();
    super.initState();
    _controller =  AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }
  _scrollListener() {
    if (listScrollController.offset >=
        listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange &&
        _limit <= listMessage.length) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  Future<void> readLocal() async {
    if (widget.groupChatId!.isEmpty) {
      chatRoom = await chatProvider.createRoom(
          currentUserId: int.parse(getStorage.read('current_uid').toString()),
          otherUser: UserData(
              id: widget.id!,
              name: widget.name,
            profilePhoto: widget.imageUrl.toString(),
             ));
      setState(() {
        widget.groupChatId = chatRoom.id!;
      });
    }

  }

  void onSendMessage(
      String content,
      int type,
      ) {
    contentController.clear();
    chatProvider.sendMessage(
        content: content,
        type: type,
        groupChatId: widget.groupChatId!,
        currentUserId: int.parse(getStorage.read('current_uid').toString()),
        peerId: widget.id!);
    Future.delayed(const Duration(milliseconds: 1000), () {
      listScrollController.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      /*floatingActionButton:  Column(
        mainAxisSize: MainAxisSize.min,
        children:  List.generate(icons.length, (int index) {
          Widget child =  Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child:  ScaleTransition(
              scale:  CurvedAnimation(
                parent: _controller!,
                curve:  Interval(
                    0.0,
                    1.0 - index / icons.length / 2.0,
                    curve: Curves.easeOut
                ),
              ),
              child:  FloatingActionButton(
                heroTag: null,
                backgroundColor: backGroundColor,
                mini: true,
                child:  Icon(icons[index], color: yellowColor),
                onPressed: () {},
              ),
            ),
          );
          return child;
        }).toList()..add(
           FloatingActionButton(
            heroTag: null,
            child:  AnimatedBuilder(
              animation: _controller!,
              builder: (BuildContext context, Widget? child) {
                return  Transform(
                  transform:  Matrix4.rotationZ(_controller!.value * 0.5 * math.pi),
                  alignment: FractionalOffset.center,
                  child:  Icon(_controller!.isDismissed ? Icons.menu : Icons.close),
                );
              },
            ),
            onPressed: () {
              if (_controller!.isDismissed) {
                _controller!.forward();
              } else {
                _controller!.reverse();
              }
            },
          ),
        ),
      ),*/
      appBar: AppBar(
        leadingWidth: 30.vw,
        title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              CommonTextView(widget.name.toString(),fontSize: 20.sp,fontFamily: displayMedium),
            CommonTextView("Online",color: white50,)
            ]
        ),
        elevation: 0,
        backgroundColor: backGroundColor,
        leading: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(5.vw),
                child: Image.asset(icBackButton),
              ),
            ),

            Container(
              clipBehavior: Clip.antiAlias,
              height: 15.vw,
              width: 15.vw,
              decoration: BoxDecoration(
                color: pinkColor,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 0.5.vw,color: yellowColor),
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl.toString()),
                  fit: BoxFit.cover
                )
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 4.vw,right: 4.vw),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Flexible(child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 100.vh,
                      ),
                    ],
                  ),
                ),
              ),
            )),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:  List.generate(icons.length, (int index) {
                    Widget child =  Container(
                      height: 10.vh,
                      width: 13.vw,
                      alignment: FractionalOffset.topCenter,
                      child:  ScaleTransition(
                        scale:  CurvedAnimation(
                          parent: _controller!,
                          curve:  Interval(
                              0.0,
                              1.0 - index / icons.length / 2.0,
                              curve: Curves.easeOut
                          ),
                        ),
                        child:  Container(
                          height: 13.vw,
                          width: 13.vw,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: darkGreyColor
                          ),
                          child:  Icon(icons[index], color: yellowColor),
                        ),
                      ),
                    );
                    return child;
                  }).toList()..add(
                    GestureDetector(
                      onTap: () {
                        if (_controller!.isDismissed) {
                          _controller!.forward();
                        } else {
                          _controller!.reverse();
                        }
                      },
                      child: Container(
                        height: 13.vw,
                        width: 13.vw,
                        margin: EdgeInsets.only(right: 1.vw),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: darkGreyColor
                        ),
                        child:  AnimatedBuilder(
                          animation: _controller!,
                          builder: (BuildContext context, Widget? child) {
                            return  Transform(
                              transform:  Matrix4.rotationZ(_controller!.value * 0.5 * math.pi),
                              alignment: FractionalOffset.center,
                              child:  Icon(_controller!.isDismissed ? Icons.dashboard : Icons.close,color: yellowColor,),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                      textInputAction: TextInputAction.newline,
                      controller: contentController,
                      style: const TextStyle(color: pinkColor),
                      cursorColor: pinkColor,
                      minLines: 1,
                      maxLines: 10,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        fillColor: darkGreyColor,
                        prefixIcon: const Icon(Icons.face_unlock_sharp,color: white50,),
                        filled: true,
                        contentPadding:
                        EdgeInsets.only(left: 2.vw, right: 2.vw),
                        hintText: "send message",
                        hintStyle: const TextStyle(color: white50),

                      )),
                ),
                GestureDetector(
                  onTap: (){
                    if(contentController.text.isNotEmpty){
                      onSendMessage(contentController.text.toString(), 0);
                    }
                  },

                  child: Container(
                      height: 13.vw,
                      width: 13.vw,
                      padding: EdgeInsets.all(2.vw),
                      margin: EdgeInsets.only(left: 1.vw),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: darkGreyColor
                      ),
                      child: Image.asset("assets/ic/ic_send_message.png")),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
