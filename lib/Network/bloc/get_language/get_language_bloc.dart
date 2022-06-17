
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/get_language/get_language_event.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_language_response_model.dart';
import 'package:twosoul_multipz/Network/repository/repository.dart';
import 'package:twosoul_multipz/Network/view_state.dart';

class GetLanguageBloc extends Bloc<GetLanguageEvents, ViewState> {
  final GetLanguageRepository repository;
  late GetLanguageResponseModel responseData;
  GetLanguageBloc({required this.repository}) : super(InitialState());

  @override
  Stream<ViewState> mapEventToState(GetLanguageEvents event) async* {
    switch (event) {
      case GetLanguageEvents.fetchData:
        yield LoadingState();

        try {
          responseData = await repository.getLanguageList();

          if (responseData != null) {
            yield LoadedState(getLanguageResponse: responseData);
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
