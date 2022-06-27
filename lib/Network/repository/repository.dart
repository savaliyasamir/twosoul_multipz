
import 'package:twosoul_multipz/Network/api/api_provider.dart';
import 'package:twosoul_multipz/Network/api/service_api.dart';
import 'package:twosoul_multipz/Network/model/request%20model/accept_reject_request_model.dart';
import 'package:twosoul_multipz/Network/model/request%20model/contact_us_request_model.dart';
import 'package:twosoul_multipz/Network/model/request%20model/create_profile_request_model.dart';
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
import 'package:twosoul_multipz/Network/model/response%20model/snooze_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/user_multi_image_response_model.dart';
import 'package:twosoul_multipz/main.dart';
import 'package:twosoul_multipz/utils/constants.dart';

import '../model/request model/edit_profile_request_model.dart';

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
  Future<SetLanguageResponseModel> setLanguageList(SetLanguageRequestModel setLanguageRequestModel) {
    return ApiService().setLanguage(setLanguageRequestModel);
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

class UserMultiImageRepository {
  Future<UserMultiImageResponseModel> getUserMultiImage(UserMultiImageRequestModel userMultiImageRequestModel) {
    return ApiService().userMultiImage();
  }
}

class HomePageRepository {
  Future<HomePageResponseModel> getHomePage(HomePageRequestModel homePageRequestModel) {
    return ApiService().homePage(homePageRequestModel);
  }
}
class CommunityRepository {
  Future<CommunityResponseModel> getCommunity() {
    return ApiService().community();
  }
}

class ChooseModeRepository {
  Future<ChooseModeResponseModel> getChooseMode({required String looking_for}) {
    return ApiService().chooseMode(looking_for: looking_for);
  }
}

class SnoozeRepository {
  Future<SnoozeResponseModel> getSnooze({required String invisible_type}) {
    return ApiService().snoozeData(invisible_type: invisible_type);
  }
}
class EditProfileRepository {
  Future<EditProfileResponseModel> getEditProfile(EditProfileRequestModel editProfileRequestModel) {
    return ApiService().editProfile(editProfileRequestModel);
  }
}
class FilterDataRepository {
  Future<HomePageResponseModel> getFilterData(FilterDataRequestModel filterDataRequestModel) {
    return ApiService().filterData(filterDataRequestModel);
  }
}

class SendMatchFriendRepository {
  Future<SendMatchFriendResponseModel> getSendMatchFriend(SendMatchFriendRequestModel sendMatchFriendRequestModel) {
    return ApiService().sendMatchFriend(sendMatchFriendRequestModel);
  }
}

class AddRewindRepository {
  Future<AddRewindResponseModel> getAddRewind(AddRewindRequestModel sendTypeRequestModel) {
    return ApiService().addRewind(sendTypeRequestModel);
  }
}

class ReceiveMatchRepository {
  Future<ReceiveMatchResponseModel> getReceiveMatch(ReceiveMatchRequestModel receiveMatchRequestModel) {
    return ApiService().receiveMatch(receiveMatchRequestModel);
  }
}
class ContactUsRepository {
  Future<ContactUsResponseModel> getContactUs(ContactUsRequestModel contactUsRequestModel) {
    return ApiService().contactUs(contactUsRequestModel);
  }
}

class FaqDataRepository {
  Future<FaqDataResponseModel> getFaqData() {
    return ApiService().faqData();
  }
}

class AcceptRejectRepository {
  Future<AcceptRejectResponseModel> getAcceptReject(AcceptRejectRequestModel acceptRejectRequestModel) {
    return ApiService().acceptReject(acceptRejectRequestModel);
  }
}

logout(){
  final ApiProvider _apiProvider = ApiProvider();
  _apiProvider.tokenWithGet(userLogoutApiUrl);
  getStorage.erase();
}

userAccountDelete(){
  final ApiProvider _apiProvider = ApiProvider();
  _apiProvider.tokenWithGet(userAccountDeleteApiUrl);
  getStorage.erase();
}

