

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/faq_data/faq_data_event.dart';
import 'package:twosoul_multipz/Network/model/response%20model/faq_response_model.dart';
import 'package:twosoul_multipz/Network/repository/repository.dart';
import 'package:twosoul_multipz/Network/view_state.dart';

class GetFaqDataBloc extends Bloc<GetFaqDataEvents, ViewState> {
  final FaqDataRepository repository;
  late FaqDataResponseModel responseData;
  GetFaqDataBloc({required this.repository}) : super(InitialState());

  @override
  Stream<ViewState> mapEventToState(GetFaqDataEvents event) async* {
    switch (event) {
      case GetFaqDataEvents.fetchData:
        yield LoadingState();
        try {
          responseData = await repository.getFaqData();

          if (responseData != null) {
            yield LoadedState(faqDataResponse: responseData);
          } else {
            yield Empty(msg: "No data found");
          }
        } on SocketException {
          yield ErrorState(
            error: ('No Internet'),
          );
        } on HttpException {
          yield ErrorState(
            error: ('No Service'),
          );
        } on FormatException {
          yield ErrorState(
            error: ('No Format Exception'),
          );
        } catch (e) {
          print(e.toString());
          yield ErrorState(
            error: ('${e.toString()}'),
          );
        }
        break;
    }
  }
}