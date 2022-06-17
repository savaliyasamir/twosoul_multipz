
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/get_state/get_state_event.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_state_response_model.dart';
import 'package:twosoul_multipz/Network/repository/repository.dart';
import 'package:twosoul_multipz/Network/view_state.dart';

class GetStateBloc extends Bloc<GetStateEvents,ViewState>
{
  final GetStateRepository repository;
  late GetStateResponseModel responseData;
  GetStateBloc({required this.repository}) : super(InitialState());

  @override
  Stream<ViewState> mapEventToState(GetStateEvents event) async* {
    if (event is FetchData) {
      yield  LoadingState();
      try {
        responseData = await repository.getStateList(countryId: event.countryId);
        if(responseData != null){
          yield LoadedState(getStateResponse: responseData);
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