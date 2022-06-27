


import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/edit_profile/edit_profile_event.dart';
import 'package:twosoul_multipz/Network/model/response%20model/edit_profile_response_model.dart';
import 'package:twosoul_multipz/Network/repository/repository.dart';
import 'package:twosoul_multipz/Network/view_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvents, ViewState> {

  final EditProfileRepository repository;
  late EditProfileResponseModel responseData;
  EditProfileBloc({required this.repository}) : super(InitialState());

  @override
  Stream<ViewState> mapEventToState(EditProfileEvents event) async* {
    if(event is FetchEditProfileData){
      yield LoadingState();
      try {
        responseData = await repository.getEditProfile(event.editProfileRequestModel);
        if (responseData != null) {
          yield LoadedState(editProfileResponse: responseData);
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