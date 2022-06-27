


import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/send_match_friend/send_match_friend_event.dart';
import 'package:twosoul_multipz/Network/model/response%20model/send_match_friend_response_model.dart';
import 'package:twosoul_multipz/Network/repository/repository.dart';
import 'package:twosoul_multipz/Network/view_state.dart';

class SendMatchFriendBloc extends Bloc<SendMatchFriendEvents, ViewState> {
  final SendMatchFriendRepository repository;
  late SendMatchFriendResponseModel responseData;
  SendMatchFriendBloc({required this.repository}) : super(InitialState());

  @override
  Stream<ViewState> mapEventToState(SendMatchFriendEvents event) async* {
    if(event is FetchSendMatchData){
      yield LoadingState();
      try {
        responseData = await repository.getSendMatchFriend(event.sendMatchFriendRequestModel);
        if (responseData != null) {
          yield LoadedState(sendMatchFriendResponse: responseData);
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