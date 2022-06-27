


import 'dart:io';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/add_rewind/add_rewind_event.dart';
import 'package:twosoul_multipz/Network/model/response%20model/add_rewind_response_model.dart';
import 'package:twosoul_multipz/Network/repository/repository.dart';
import 'package:twosoul_multipz/Network/view_state.dart';

class AddRewindBloc extends Bloc<AddRewindEvents, ViewState> {


  final AddRewindRepository repository;
  late AddRewindResponseModel responseData;
  AddRewindBloc({required this.repository}) : super(InitialState());

  @override
  Stream<ViewState> mapEventToState(AddRewindEvents event) async* {
    if(event is FetchAddRewindData){
      yield LoadingState();
      try {
        responseData = await repository.getAddRewind(event.sendTypeRequestModel);
        if (responseData != null) {
          yield LoadedState(addRewindResponse: responseData);
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