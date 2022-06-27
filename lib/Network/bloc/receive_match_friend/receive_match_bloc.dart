


import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/receive_match_friend/receive_match_event.dart';
import 'package:twosoul_multipz/Network/model/response%20model/receive_match_response_model.dart';
import 'package:twosoul_multipz/Network/repository/repository.dart';
import 'package:twosoul_multipz/Network/view_state.dart';

class ReceiveMatchBloc extends Bloc<ReceiveMatchEvents, ViewState> {


  final ReceiveMatchRepository repository;
  late ReceiveMatchResponseModel responseData;
  ReceiveMatchBloc({required this.repository}) : super(InitialState());

  @override
  Stream<ViewState> mapEventToState(ReceiveMatchEvents event) async* {
    if(event is FetchReceiveMatchData){
      yield LoadingState();
      try {
        responseData = await repository.getReceiveMatch(event.receiveMatchRequestModel);
        if (responseData != null) {
          yield LoadedState(receiveMatchResponse: responseData);
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
    }
  }
}