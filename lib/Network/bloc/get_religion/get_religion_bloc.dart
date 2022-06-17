

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/get_religion/get_religion_event.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_religion_response_model.dart';
import 'package:twosoul_multipz/Network/repository/repository.dart';
import 'package:twosoul_multipz/Network/view_state.dart';

class GetReligionBloc extends Bloc<GetReligionEvents, ViewState> {
  final GetReligionRepository repository;
  late GetReligionResponseModel responseData;
  GetReligionBloc({required this.repository}) : super(InitialState());

  @override
  Stream<ViewState> mapEventToState(GetReligionEvents event) async* {
    switch (event) {
      case GetReligionEvents.fetchData:
        yield LoadingState();
        try {
          responseData = await repository.getReligionList();

          if (responseData != null) {
            yield LoadedState(getReligionResponse: responseData);
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