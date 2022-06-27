

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/accept_reject_friend_request/accept_reject_event.dart';
import 'package:twosoul_multipz/Network/model/response%20model/accept_reject_reasponse_model.dart';
import 'package:twosoul_multipz/Network/repository/repository.dart';
import 'package:twosoul_multipz/Network/view_state.dart';

class AcceptRejectBloc extends Bloc<AcceptRejectEvents, ViewState> {

  final AcceptRejectRepository repository;
  late AcceptRejectResponseModel responseData;
  AcceptRejectBloc({required this.repository}) : super(InitialState());

  @override
  Stream<ViewState> mapEventToState(AcceptRejectEvents event) async* {
    if(event is FetchAcceptRejectData){
      yield LoadingState();
      try {
        responseData = await repository.getAcceptReject(event.acceptRejectRequestModel);
        if (responseData != null) {
          yield LoadedState(acceptRejectResponse: responseData);
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