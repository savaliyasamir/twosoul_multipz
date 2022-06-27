


import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/home_page/home_page_event.dart';
import 'package:twosoul_multipz/Network/model/response%20model/home_page_response_model.dart';
import 'package:twosoul_multipz/Network/repository/repository.dart';
import 'package:twosoul_multipz/Network/view_state.dart';

class HomePageBloc extends Bloc<HomePageEvents, ViewState> {
  final HomePageRepository repository;
  late HomePageResponseModel responseData;
  HomePageBloc({required this.repository}) : super(InitialState());

  @override
  Stream<ViewState> mapEventToState(HomePageEvents event) async* {
    if(event is FetchHomePageData){
      yield LoadingState();
      try {
        responseData = await repository.getHomePage(event.homePageRequestModel);
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