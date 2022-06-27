import 'package:flutter/services.dart';
import 'package:twosoul_multipz/Network/api/api_provider.dart';
import 'package:twosoul_multipz/Network/model/request%20model/accept_reject_request_model.dart';
import 'package:twosoul_multipz/Network/model/request%20model/contact_us_request_model.dart';
import 'package:twosoul_multipz/Network/model/request%20model/create_profile_request_model.dart';
import 'package:twosoul_multipz/Network/model/request%20model/edit_profile_request_model.dart';
import 'package:twosoul_multipz/Network/model/request%20model/filter_data_request_model.dart';
import 'package:twosoul_multipz/Network/model/request%20model/home_page_request_model.dart';
import 'package:twosoul_multipz/Network/model/request%20model/login_request.dart';
import 'package:twosoul_multipz/Network/model/request%20model/receive_match_request_model.dart';
import 'package:twosoul_multipz/Network/model/request%20model/send_match_friend_request_model.dart';
import 'package:twosoul_multipz/Network/model/request%20model/set_language_request_model.dart';
import 'package:twosoul_multipz/Network/model/request%20model/sned_type_request_model.dart';
import 'package:twosoul_multipz/Network/model/request%20model/user_multi_image_request_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/accept_reject_reasponse_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/add_rewind_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/choose_mode_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/community_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/contact_us_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/create_profile_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/edit_profile_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/faq_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_city_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_country_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_language_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_religion_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_sexuality_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_state_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/home_page_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/login_response.dart';
import 'package:twosoul_multipz/Network/model/response%20model/receive_match_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/send_match_friend_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/set_language_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/user_multi_image_response_model.dart';
import 'package:twosoul_multipz/utils/constants.dart';

import '../model/response model/snooze_response_model.dart';

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

  Future<SetLanguageResponseModel> setLanguage(SetLanguageRequestModel setLanguageRequestModel) async {
    ApiProvider apiProvider = ApiProvider();
    try {
      var response = await apiProvider.tokenWithPost(setLanguageApiUrl,body: setLanguageRequestModel);
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

  Future<GetStateResponseModel> getState({String countryId = ""}) async {
    ApiProvider apiProvider = ApiProvider();
    try {
      var response = await apiProvider.get(getStateApiUrl+countryId);
      return GetStateResponseModel.fromJson(response);
    } catch(e){
      return GetStateResponseModel();
    }
  }


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

  Future<FaqDataResponseModel> faqData() async{
    ApiProvider apiProvider = ApiProvider();

    try{
      var   response = await apiProvider.tokenWithGet(getFaqDataApiUrl);
      return FaqDataResponseModel.fromJson(response);
    }catch(e){
      return FaqDataResponseModel();
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

  Future<UserMultiImageResponseModel> userMultiImage() async {
    ApiProvider apiProvider = ApiProvider();
    try {
      var response = await apiProvider.multipartPost(userMultiImageApiUrl);
      return UserMultiImageResponseModel.fromJson(response);
    } catch(e){
      return UserMultiImageResponseModel();
    }
  }

  Future<HomePageResponseModel> homePage(HomePageRequestModel homePageRequestModel) async {
    ApiProvider apiProvider = ApiProvider();
    try {
      var response = await apiProvider. tokenWithPost(homePageApiUrl,body: homePageRequestModel);
      return HomePageResponseModel.fromJson(response);
    } catch(e){
      return HomePageResponseModel();
    }
  }


  Future<CommunityResponseModel> community() async {
    ApiProvider apiProvider = ApiProvider();
    try {
      var response = await apiProvider.tokenWithGet(communityUserDataApiUrl);
      return CommunityResponseModel.fromJson(response);
    } catch(e){
      return CommunityResponseModel();
    }
  }

  Future<ChooseModeResponseModel> chooseMode({required String looking_for}) async {
    ApiProvider apiProvider = ApiProvider();
    try {
      var response = await apiProvider.tokenWithGet(changeLookingForModeApiUrl+looking_for);
      return ChooseModeResponseModel.fromJson(response);
    } catch(e){
      return ChooseModeResponseModel();
    }
  }

  Future<SnoozeResponseModel> snoozeData({required String invisible_type}) async {
    ApiProvider apiProvider = ApiProvider();
    try {
      var response = await apiProvider.tokenWithGet(changeLookingForModeApiUrl+invisible_type);
      return SnoozeResponseModel.fromJson(response);
    } catch(e){
      return SnoozeResponseModel();
    }
  }

  Future<EditProfileResponseModel> editProfile(EditProfileRequestModel editProfileRequestModel) async {
    ApiProvider apiProvider = ApiProvider();
    try {
      var response = await apiProvider. tokenWithPost(editProfileApiUrl,body: editProfileRequestModel);
      return EditProfileResponseModel.fromJson(response);
    } catch(e){
      return EditProfileResponseModel();
    }
  }

  Future<HomePageResponseModel> filterData(FilterDataRequestModel filterDataRequestModel) async {
    ApiProvider apiProvider = ApiProvider();
    try {
      var response = await apiProvider. tokenWithPost(filterDataApiUrl,body: filterDataRequestModel);
      return HomePageResponseModel.fromJson(response);
    } catch(e){
      return HomePageResponseModel();
    }
  }

  Future<SendMatchFriendResponseModel> sendMatchFriend(SendMatchFriendRequestModel sendMatchFriendRequestModel) async {
    ApiProvider apiProvider = ApiProvider();
    try {
      var response = await apiProvider. tokenWithPost(sendMatchFriendRequestApiUrl,body: sendMatchFriendRequestModel);
      return SendMatchFriendResponseModel.fromJson(response);
    } catch(e){
      return SendMatchFriendResponseModel();
    }
  }

  Future<AddRewindResponseModel> addRewind(AddRewindRequestModel sendTypeRequestModel) async {
    ApiProvider apiProvider = ApiProvider();
    try {
      var response = await apiProvider. tokenWithPost(addRewindApiUrl,body: sendTypeRequestModel);
      return AddRewindResponseModel.fromJson(response);
    } catch(e){
      return AddRewindResponseModel();
    }
  }

  Future<ReceiveMatchResponseModel> receiveMatch(ReceiveMatchRequestModel receiveMatchRequestModel) async {
    ApiProvider apiProvider = ApiProvider();
    try {
      var response = await apiProvider. tokenWithPost(receiveMatchFriendRequestApiUrl,body: receiveMatchRequestModel);
      return ReceiveMatchResponseModel.fromJson(response);
    } catch(e){
      return ReceiveMatchResponseModel();
    }
  }

  Future<ContactUsResponseModel> contactUs(ContactUsRequestModel contactUsRequestModel) async {
    ApiProvider apiProvider = ApiProvider();
    try {
      var response = await apiProvider. tokenWithPost(contactUsApiUrl,body: contactUsRequestModel);
      return ContactUsResponseModel.fromJson(response);
    } catch(e){
      return ContactUsResponseModel();
    }
  }

  Future<AcceptRejectResponseModel> acceptReject(AcceptRejectRequestModel acceptRejectRequestModel) async {
    ApiProvider apiProvider = ApiProvider();
    try {
      var response = await apiProvider. tokenWithPost(acceptRejectMatchFriendRequestApiUrl,body: acceptRejectRequestModel);
      return AcceptRejectResponseModel.fromJson(response);
    } catch(e){
      return AcceptRejectResponseModel();
    }
  }


  Future logout() async {
    ApiProvider apiProvider = ApiProvider();
    try {
      var response = await apiProvider.tokenWithGet(userLogoutApiUrl);
      return response;
    } catch(e){
      return "";
    }
  }

}