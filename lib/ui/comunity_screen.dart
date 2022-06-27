import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/Network/bloc/community/community_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/community/community_event.dart';
import 'package:twosoul_multipz/Network/view_state.dart';
import 'package:twosoul_multipz/ui/filter_screen.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/base_screen.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';
import 'package:twosoul_multipz/utils/widget/error_message.dart';

///03-06-2022
class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CommunityBloc>().add(CommunityEvents.fetchData);
  }
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextView(community,fontSize: 20.sp,fontFamily: displayMedium,color: Colors.white),
              CommonTextView(marbauUsers,fontSize: 12.sp,fontFamily: displayLight,color: white50,)
            ],
          ),
        SizedBox(
          height: 4.vh,
        ),
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
              return state.communityResponseModel!.data!.isEmpty ? SizedBox(
                height: 70.vh,
                child: Center(
                  child: CommonTextView(
                    "No Data Found",color: lightGreyColor,fontSize: 20.sp,fontFamily: displayMedium,
                  ),
                ),
              ): Expanded(
                child: SingleChildScrollView(
                  physics:  const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  child: Wrap(
                    runSpacing: 6.vw,
                    spacing: 4.vw,
                    children: state.communityResponseModel!.data!.map((e) =>
                        GestureDetector(
                      onTap: (){
                        showModalBottomSheet<void>(
                          backgroundColor: Colors.transparent,
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return Container(
                              padding: EdgeInsets.all(4.vw),
                              height: 75.vh,
                              decoration:  BoxDecoration(
                                  color: Colors.blue,
                                  image: DecorationImage(
                                      image:  NetworkImage(e.image!.firstWhere((element) => element.isDefault == "1").imagename.toString(),
                                      ),fit: BoxFit.cover,
                                  ),
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  CommonTextView('${e.name},${e.age}',fontSize: 20.sp,fontFamily: displayMedium,color: backGroundColor),
                                  CommonTextView('${e.city!.name},${e.country!.name}',color: backGroundColor,fontFamily: displayRegular,fontSize: 12.sp),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          height: 7.vh,
                                          width: 14.vw,
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
                                color: darkGreyColor
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network("${e.image!.firstWhere((element) => element.isDefault == "1").imagename}"
                                    ,fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context, Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return const CustomLoader();
                                  },),
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
                                          CommonTextView('${e.distance}km',fontSize: 6.sp,fontFamily: displayMedium,color: Colors.white,)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 1.vh,),
                          CommonTextView('${e.name},${e.age}',fontFamily: displayRegular,fontSize: 12.sp,color: Colors.white,),
                        ],
                      ),
                    ),).toList()
                  ),
                ),
              );
            }
            return const CustomLoader();
          }
        ),
        ],
      ),
    );
  }
}
