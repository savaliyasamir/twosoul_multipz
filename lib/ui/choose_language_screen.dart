import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/Network/bloc/get_language/get_language_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/get_language/get_language_event.dart';
import 'package:twosoul_multipz/Network/bloc/set_language/set_language_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/set_language/set_language_event.dart';
import 'package:twosoul_multipz/Network/model/request%20model/set_language_request_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_language_response_model.dart';
import 'package:twosoul_multipz/ui/upload_image_screen.dart';
import 'package:twosoul_multipz/utils/widget/base_screen.dart';
import 'package:twosoul_multipz/utils/widget/common_button.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';
import 'package:twosoul_multipz/utils/widget/error_message.dart';
import '../Network/view_state.dart';
import '../utils/constants.dart';

class ChooseLanguageScreen extends StatefulWidget {
  bool setting;
   ChooseLanguageScreen({Key? key,  required this.setting}) : super(key: key);

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  List<GetLanguageResponseModel> language = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      context.read<GetLanguageBloc>().add(GetLanguageEvents.fetchData);
    });

  }

  @override
  Widget build(BuildContext context) {
    return  BaseScreen(
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              icTwoSoul,
              width: 20.vw,
            ),
          ),
          CommonTextView(twoSoul, fontSize: 24.sp,color: Colors.white,fontFamily: displayMedium),
          SizedBox(height: 6.vh,),
         CommonTextView(chooseLanguage,fontSize: 20.sp,color: Colors.white,fontFamily: displayMedium),
         SizedBox(height: 4.vh,),
          BlocBuilder<GetLanguageBloc, ViewState>(
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
                if(state is LoadedState) {
                  return ListView.builder(
                    shrinkWrap: true,
                      itemCount: state.getLanguageResponse!.data!.length,
                      itemBuilder: (context, index) =>  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedLanguage = state.getLanguageResponse!.data![index].name.toString();
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 1.vh),
                      padding: EdgeInsets.only(left: 4.vw, right: 4.vw),
                      decoration: BoxDecoration(
                        color: selectedLanguage == state.getLanguageResponse!.data![index].name
                            ? pinkColor
                            : darkGreyColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 6.vh,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonTextView(state.getLanguageResponse!.data![index].name.toString(), fontSize: 16.sp,
                              fontFamily: displayRegular,
                              color: Colors.white),
                          SizedBox(
                            height: 7.vw,
                            width: 7.vw,
                            child: Image.asset(selectedLanguage == state.getLanguageResponse!.data![index].name
                                ? icSelectedLanguage
                                : icFreeUnselected),
                          ),
                        ],
                      ),
                    ),
                  ));
                }
                return const CustomLoader();
            }
          ),
          SizedBox(height: 10.vh,),
          CommonButton(btnText: btnContinue,onPressed: (){
            context.read<SetLanguageBloc>().add(FetchLanguageData(SetLanguageRequestModel(code: selectedLanguage.substring(0,2))));
            widget.setting ? Navigator.pop(context):Navigator.push(context, MaterialPageRoute(builder: (context) => const UploadImageScreen()));
          },)
        ],
      ),
    );
  }
}
