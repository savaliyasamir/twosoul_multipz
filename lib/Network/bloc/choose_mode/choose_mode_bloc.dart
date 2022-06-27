

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/choose_mode/choose_mode_event.dart';
import 'package:twosoul_multipz/Network/model/response%20model/choose_mode_response_model.dart';
import 'package:twosoul_multipz/Network/repository/repository.dart';
import 'package:twosoul_multipz/Network/view_state.dart';

class ChooseModeBloc extends Bloc<ChooseModeEvents, ViewState> {

  final ChooseModeRepository repository;
  late ChooseModeResponseModel responseData;
  ChooseModeBloc({required this.repository}) : super(InitialState());

  @override
  Stream<ViewState> mapEventToState(ChooseModeEvents event) async* {
    if (event is FetchData) {
      yield  LoadingState();
      try {
        responseData = await repository.getChooseMode(looking_for: event.looking_for);
        if(responseData != null){
          yield LoadedState(chooseModeResponse: responseData);
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