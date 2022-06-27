
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/user_multi_image/user_multi_image_event.dart';
import 'package:twosoul_multipz/Network/model/response%20model/user_multi_image_response_model.dart';
import 'package:twosoul_multipz/Network/repository/repository.dart';
import 'package:twosoul_multipz/Network/view_state.dart';

class UserMultiImageBloc extends Bloc<UserMultiImageEvents, ViewState> {

  final UserMultiImageRepository repository;
  late UserMultiImageResponseModel responseData;
  UserMultiImageBloc({required this.repository}) : super(InitialState());

  @override
  Stream<ViewState> mapEventToState(UserMultiImageEvents event) async* {
    if(event is FetchData){
      yield LoadingState();
      try {
        responseData = await repository.getUserMultiImage(event.userMultiImageRequestModel);
        if (responseData != null) {
          yield LoadedState(userMultiImageResponse: responseData);
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