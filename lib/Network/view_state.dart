import 'package:equatable/equatable.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_city_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_country_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_language_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_religion_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_sexuality_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_state_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/login_response.dart';
import 'package:twosoul_multipz/Network/model/response%20model/set_language_response_model.dart';

import 'model/response model/create_profile_response_model.dart';

abstract class ViewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingState extends ViewState {}

class InitialState extends ViewState {}

class LoadedState extends ViewState {
  final LoginResponseModel? loginResponse;
  final GetLanguageResponseModel? getLanguageResponse;
  final SetLanguageResponseModel? setLanguageResponseModel;
  final GetSexualityResponseModel? getSexualityResponse;
  final GetReligionResponseModel? getReligionResponse;
  final GetCountryResponseModel? getCountryResponse;
  final GetStateResponseModel? getStateResponse;
  final GetCityResponseModel? getCityResponse;
  final CreateProfileResponseModel? createProfileResponse;

  LoadedState(
      {this.loginResponse,
      this.getLanguageResponse,
      this.setLanguageResponseModel,
      this.getSexualityResponse,
      this.getReligionResponse,
      this.getCountryResponse,
      this.getStateResponse,
      this.getCityResponse,
      this.createProfileResponse
      });
}

/// State indicating that data was loaded successfully, but was null or empty.
class Empty extends ViewState {
  final msg;

  Empty({this.msg});
}

class ErrorState extends ViewState {
  final error;

  ErrorState({this.error});
}
