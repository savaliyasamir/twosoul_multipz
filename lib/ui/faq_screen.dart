

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/Network/bloc/faq_data/faq_data_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/faq_data/faq_data_event.dart';
import 'package:twosoul_multipz/Network/view_state.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/base_screen.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';
import 'package:twosoul_multipz/utils/widget/error_message.dart';

class FaqDataScreen extends StatefulWidget {
  const FaqDataScreen({Key? key}) : super(key: key);

  @override
  State<FaqDataScreen> createState() => _FaqDataScreenState();
}

class _FaqDataScreenState extends State<FaqDataScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetFaqDataBloc>().add(GetFaqDataEvents.fetchData);
  }
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(icBackButton, height: 2.vh),
              ),
              SizedBox(width: 20.vw,),
              CommonTextView("FAQ",
                  fontSize: 20.sp,
                  fontFamily: displayMedium,
                  color: Colors.white),
            ],
          ),
          BlocBuilder<GetFaqDataBloc, ViewState>(
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
               return Expanded(child: SingleChildScrollView(
                 child: Html(
                    data: state.faqDataResponse!.data![0].question,
                 ),
               ));
             }
             return const Text("no data found");
            }

          ),
        ],
      ),
    );
  }
}
