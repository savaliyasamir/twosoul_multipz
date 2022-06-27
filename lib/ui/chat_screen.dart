import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/Network/bloc/community/community_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/community/community_event.dart';
import 'package:twosoul_multipz/Network/view_state.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CommunityBloc>().add(CommunityEvents.fetchData);
  }
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
                          return Container(
                            margin: EdgeInsets.only(right: 2.vw),
                            clipBehavior: Clip.antiAlias,
                            height: 10.vh,
                            width: 35.vw,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: darkGreyColor
                            ),
                            child: Image.network(state.communityResponseModel!.data![index].image!.firstWhere((element) => element.isDefault == "1").imagename.toString(),fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return  const CustomLoader();
                            },),
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
         ),

        ],
      ),
    );
  }
}
