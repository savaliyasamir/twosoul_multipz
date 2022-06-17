

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/create_profile/create_profile_event.dart';
import 'package:twosoul_multipz/Network/model/response%20model/create_profile_response_model.dart';
import 'package:twosoul_multipz/Network/repository/repository.dart';
import 'package:twosoul_multipz/Network/view_state.dart';

class CreateProfileBloc extends Bloc<CreateProfileEvents, ViewState> {

  final CreateProfileRepository repository;
  late CreateProfileResponseModel responseData;
  CreateProfileBloc({required this.repository}) : super(InitialState());

  @override
  Stream<ViewState> mapEventToState(CreateProfileEvents event) async* {
    if(event is FetchCreateProfileData){
      yield LoadingState();
      try {
        responseData = await repository.getCreateProfile(event.createProfileRequestModel);
        if (responseData != null) {
          yield LoadedState(createProfileResponse: responseData);
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