import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twosoul_multipz/Network/model/response%20model/login_response.dart';
import 'package:twosoul_multipz/Network/repository/repository.dart';
import 'package:twosoul_multipz/Network/view_state.dart';
import 'login_event.dart';

class LoginBloc extends Bloc<LoginEvents, ViewState> {
  final LoginRepository repository;
  late LoginResponseModel responseData;
  LoginBloc({required this.repository}) : super(InitialState());

  @override
  Stream<ViewState> mapEventToState(LoginEvents event) async* {
    if(event is FetchData){
      yield LoadingState();
      try {
        responseData = await repository.getLoginData(event.loginRequestModel);
        if (responseData != null) {
          yield LoadedState(loginResponse: responseData);
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