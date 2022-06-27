

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/community/community_event.dart';
import 'package:twosoul_multipz/Network/model/response%20model/community_response_model.dart';
import 'package:twosoul_multipz/Network/repository/repository.dart';
import 'package:twosoul_multipz/Network/view_state.dart';

class CommunityBloc extends Bloc<CommunityEvents, ViewState> {

  final CommunityRepository repository;
  late CommunityResponseModel responseData;
  CommunityBloc({required this.repository}) : super(InitialState());

  @override
  Stream<ViewState> mapEventToState(CommunityEvents event) async* {
    switch (event) {
      case CommunityEvents.fetchData:
        yield LoadingState();
        try {
          responseData = await repository.getCommunity();

          if (responseData != null) {
            yield LoadedState(communityResponseModel: responseData);
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