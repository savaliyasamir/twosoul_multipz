



import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/filter_%20data/filter_data_event.dart';
import 'package:twosoul_multipz/Network/model/response%20model/home_page_response_model.dart';
import 'package:twosoul_multipz/Network/repository/repository.dart';
import 'package:twosoul_multipz/Network/view_state.dart';

class FilterDataBloc extends Bloc<FilterDataEvents, ViewState> {

  final FilterDataRepository repository;
  late HomePageResponseModel responseData;
  FilterDataBloc({required this.repository}) : super(InitialState());

  @override
  Stream<ViewState> mapEventToState(FilterDataEvents event) async* {
    if(event is FetchFilterData){
      yield LoadingState();
      try {
        responseData = await repository.getFilterData(event.filterDataRequestModel);
        if (responseData != null) {
          yield LoadedState(homePageResponse: responseData);
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