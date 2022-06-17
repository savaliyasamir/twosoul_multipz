



import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/get_country/get_country_event.dart';
import 'package:twosoul_multipz/Network/bloc/get_sexuality/get_sexuality_event.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_country_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_sexuality_response_model.dart';
import 'package:twosoul_multipz/Network/repository/repository.dart';
import 'package:twosoul_multipz/Network/view_state.dart';

class GetCountryBloc extends Bloc<GetCountryEvents, ViewState> {
  final GetCountryRepository repository;
  late GetCountryResponseModel responseData;
  GetCountryBloc({required this.repository}) : super(InitialState());

  @override
  Stream<ViewState> mapEventToState(GetCountryEvents event) async* {
    switch (event) {
      case GetCountryEvents.fetchData:
        yield LoadingState();
        try {
          responseData = await repository.getCountryList();

          if (responseData != null) {
            yield LoadedState(getCountryResponse: responseData);
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