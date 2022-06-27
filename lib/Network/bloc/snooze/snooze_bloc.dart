

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/snooze/snooze_event.dart';
import 'package:twosoul_multipz/Network/model/response%20model/snooze_response_model.dart';
import 'package:twosoul_multipz/Network/repository/repository.dart';
import 'package:twosoul_multipz/Network/view_state.dart';

class SnoozeBloc extends Bloc<SnoozeEvents, ViewState> {

  final SnoozeRepository repository;
  late SnoozeResponseModel responseData;
  SnoozeBloc({required this.repository}) : super(InitialState());

  @override
  Stream<ViewState> mapEventToState(SnoozeEvents event) async* {
    if (event is FetchData) {
      yield  LoadingState();
      try {
        responseData = await repository.getSnooze(invisible_type: event.invisible_type);
        if(responseData != null){
          yield LoadedState(snoozeResponseModel: responseData);
        }else{
          yield Empty(msg: "No data found");
        }
      }on SocketException {
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
          error: ('Un Known Error ${e.toString()}'),
        );
      }
    }
  }
}