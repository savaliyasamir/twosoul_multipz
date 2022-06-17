import 'package:flutter/services.dart';
import 'package:twosoul_multipz/Network/api/api_provider.dart';
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
import 'package:twosoul_multipz/utils/constants.dart';

abstract class ServiceApi{
  Future<LoginResponseModel> getLogin(LoginRequestModel loginRequestModel);
  Future<GetLanguageResponseModel> getLanguage();
}

class ApiService extends ServiceApi{
  @override
  Future<LoginResponseModel> getLogin(LoginRequestModel loginRequestModel) async {
    ApiProvider apiProvider = ApiProvider();
    try {
      var response = await apiProvider.post(loginUserApiUrl,body: loginRequestModel);
      return LoginResponseModel.fromJson(response);
    } catch(e){
      return LoginResponseModel();
    }
  }

  @override
  Future<GetLanguageResponseModel> getLanguage() async{
    ApiProvider apiProvider = ApiProvider();
    
    try{
      var   response = await apiProvider.get(getLanguageApiUrl);
      return GetLanguageResponseModel.fromJson(response);
    }catch(e){
      return GetLanguageResponseModel();
    }
  }

  Future<SetLanguageResponseModel> setLanguage(selectedLanguage) async {
    ApiProvider apiProvider = ApiProvider();
    try {
      var response = await apiProvider.tokenWithPost(setLanguageApiUrl);
      return SetLanguageResponseModel.fromJson(response);
    } catch(e){
      return SetLanguageResponseModel();
    }
  }



  Future<GetSexualityResponseModel> getSexuality() async{
    ApiProvider apiProvider = ApiProvider();

    try{
      var   response = await apiProvider.tokenWithGet(getSexualityApiUrl);
      return GetSexualityResponseModel.fromJson(response);
    }catch(e){
      return GetSexualityResponseModel();
    }
  }

  Future<GetReligionResponseModel> getReligion() async{
    ApiProvider apiProvider = ApiProvider();

    try{
      var   response = await apiProvider.tokenWithGet(getReligionApiUrl);
      return GetReligionResponseModel.fromJson(response);
    }catch(e){
      return GetReligionResponseModel();
    }
  }


  Future<GetCountryResponseModel> getCountry() async{
    ApiProvider apiProvider = ApiProvider();

    try{
      var   response = await apiProvider.get(getCountryApiUrl);
      return GetCountryResponseModel.fromJson(response);
    }catch(e){
      return GetCountryResponseModel();
    }
  }
  @override
  Future<GetStateResponseModel> getState({String countryId = ""}) async {
    ApiProvider apiProvider = ApiProvider();
    try {
      var response = await apiProvider.get(getStateApiUrl+countryId);
      return GetStateResponseModel.fromJson(response);
    } catch(e){
      return GetStateResponseModel();
    }
  }

  @override
  Future<GetCityResponseModel> getCity({String? countryId,String? stateId}) async {
    ApiProvider apiProvider = ApiProvider();
    try {
      var response = await apiProvider.get(getCityApiUrl+"country_id=$countryId""&"+
      "state_id=$stateId");
      return GetCityResponseModel.fromJson(response);
    } catch(e){
      return GetCityResponseModel();
    }
  }

  Future<CreateProfileResponseModel> createProfile(CreateProfileRequestModel createProfileRequestModel) async {
    ApiProvider apiProvider = ApiProvider();
    try {
      var response = await apiProvider.tokenWithPost(createProfileApiUrl,body: createProfileRequestModel);
      return CreateProfileResponseModel.fromJson(response);
    } catch(e){
      return CreateProfileResponseModel();
    }
  }


}