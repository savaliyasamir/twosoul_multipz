
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/get_sexuality/get_sexuality_event.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_sexuality_response_model.dart';
import 'package:twosoul_multipz/Network/repository/repository.dart';
import 'package:twosoul_multipz/Network/view_state.dart';

class GetSexualityBloc extends Bloc<GetSexualityEvents, ViewState> {

  final GetSexualityRepository repository;
  late GetSexualityResponseModel responseData;
  GetSexualityBloc({required this.repository}) : super(InitialState());

  @override
  Stream<ViewState> mapEventToState(GetSexualityEvents event) async* {
    switch (event) {
      case GetSexualityEvents.fetchData:
        yield LoadingState();
        try {
          responseData = await repository.getSexualityList();

          if (responseData != null) {
            yield LoadedState(getSexualityResponse: responseData);
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