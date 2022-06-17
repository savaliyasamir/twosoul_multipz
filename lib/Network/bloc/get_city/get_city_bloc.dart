


import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/get_city/get_city_event.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_city_response_model.dart';
import 'package:twosoul_multipz/Network/repository/repository.dart';
import 'package:twosoul_multipz/Network/view_state.dart';

class GetCityBloc extends Bloc<GetCityEvents, ViewState> {

  final GetCityRepository repository;
  late GetCityResponseModel responseData;
  GetCityBloc({required this.repository}) : super(InitialState());

  @override
  Stream<ViewState> mapEventToState(GetCityEvents event) async* {
    if (event is FetchCityData) {
      yield  LoadingState();
      try {
        responseData = await repository.getCityList(countryId: event.countryId,stateId: event.stateId);
        if(responseData != null){
          yield LoadedState(getCityResponse: responseData);
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