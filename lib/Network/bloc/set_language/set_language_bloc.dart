


import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/set_language/set_language_event.dart';
import 'package:twosoul_multipz/Network/model/response%20model/set_language_response_model.dart';
import 'package:twosoul_multipz/Network/repository/repository.dart';
import 'package:twosoul_multipz/Network/view_state.dart';

class SetLanguageBloc extends Bloc<SetLanguageEvents,ViewState>
{
  final SetLanguageRepository repository;
  late SetLanguageResponseModel responseData;
  SetLanguageBloc({required this.repository}) : super(InitialState());

  @override
  Stream<ViewState> mapEventToState(SetLanguageEvents event) async* {
    if (event is FetchLanguageData) {
      yield  LoadingState();
      try {
        responseData = await repository.setLanguageList( event.setLanguageRequestModel);
        if(responseData != null){
          yield LoadedState(setLanguageResponseModel: responseData);
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