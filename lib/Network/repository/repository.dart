
import 'package:twosoul_multipz/Network/api/service_api.dart';
import 'package:twosoul_multipz/Network/model/request%20model/create_profile_request_model.dart';
import 'package:twosoul_multipz/Network/model/request%20model/login_request.dart';
import 'package:twosoul_multipz/Network/model/response%20model/create_profile_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_city_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_country_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_language_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_religion_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_sexuality_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_state_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/login_response.dart';
import 'package:twosoul_multipz/Network/model/response%20model/set_language_response_model.dart';

class LoginRepository {
  Future<LoginResponseModel> getLoginData(LoginRequestModel loginRequestModel) {
    return ApiService().getLogin(loginRequestModel);
  }
}

class GetLanguageRepository {
  Future<GetLanguageResponseModel> getLanguageList() {
    return ApiService().getLanguage();
  }
}

class GetSexualityRepository {
    Future<GetSexualityResponseModel> getSexualityList(){
    return ApiService().getSexuality();
  }
}
class GetReligionRepository {
  Future<GetReligionResponseModel> getReligionList(){
    return ApiService().getReligion();
  }
}

class SetLanguageRepository {
  Future<SetLanguageResponseModel> setLanguageList({required String? selectedLanguage}) {
    return ApiService().setLanguage(selectedLanguage);
  }
}

class GetCountryRepository {
  Future<GetCountryResponseModel> getCountryList() {
    return ApiService().getCountry();
  }
}

class GetStateRepository {
  Future<GetStateResponseModel> getStateList({required String countryId}) {
    return ApiService().getState(countryId: countryId);
  }
}

class GetCityRepository {
  Future<GetCityResponseModel> getCityList({required String countryId,required String stateId}) {
    return ApiService().getCity(countryId: countryId,stateId: stateId);
  }
}

class CreateProfileRepository {
  Future<CreateProfileResponseModel> getCreateProfile(CreateProfileRequestModel createProfileRequestModel) {
    return ApiService().createProfile(createProfileRequestModel);
  }
}