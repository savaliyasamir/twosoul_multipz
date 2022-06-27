
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/contact_us/contact_us_event.dart';
import 'package:twosoul_multipz/Network/model/response%20model/contact_us_response_model.dart';
import 'package:twosoul_multipz/Network/repository/repository.dart';
import 'package:twosoul_multipz/Network/view_state.dart';

class ContactUsBloc extends Bloc<ContactUsEvents, ViewState> {

  final ContactUsRepository repository;
  late ContactUsResponseModel responseData;
  ContactUsBloc({required this.repository}) : super(InitialState());

  @override
  Stream<ViewState> mapEventToState(ContactUsEvents event) async* {
    if(event is FetchContactUsData){
      yield LoadingState();
      try {
        responseData = await repository.getContactUs(event.contactUsRequestModel);
        if (responseData != null) {
          yield LoadedState(contactUsResponse: responseData);
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