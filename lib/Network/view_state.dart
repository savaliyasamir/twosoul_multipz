import 'package:equatable/equatable.dart';
import 'package:twosoul_multipz/Network/model/request%20model/send_match_friend_request_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/accept_reject_reasponse_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/add_rewind_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/choose_mode_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/contact_us_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/edit_profile_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/faq_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_city_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_country_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_language_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_religion_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_sexuality_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/get_state_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/login_response.dart';
import 'package:twosoul_multipz/Network/model/response%20model/receive_match_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/send_match_friend_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/set_language_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/snooze_response_model.dart';
import 'package:twosoul_multipz/Network/model/response%20model/user_multi_image_response_model.dart';
import 'model/response model/community_response_model.dart';
import 'model/response model/create_profile_response_model.dart';
import 'model/response model/home_page_response_model.dart';

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
  final UserMultiImageResponseModel? userMultiImageResponse;
  final HomePageResponseModel? homePageResponse;
  final CommunityResponseModel? communityResponseModel;
  final ChooseModeResponseModel? chooseModeResponse;
  final SnoozeResponseModel? snoozeResponseModel;
  final EditProfileResponseModel? editProfileResponse;
  final SendMatchFriendResponseModel? sendMatchFriendResponse;
  final AddRewindResponseModel? addRewindResponse;
  final ReceiveMatchResponseModel? receiveMatchResponse;
  final ContactUsResponseModel? contactUsResponse;
  final FaqDataResponseModel? faqDataResponse;
  final AcceptRejectResponseModel? acceptRejectResponse;

  LoadedState(
      {this.loginResponse,
      this.getLanguageResponse,
      this.setLanguageResponseModel,
      this.getSexualityResponse,
      this.getReligionResponse,
      this.getCountryResponse,
      this.getStateResponse,
      this.getCityResponse,
      this.createProfileResponse,
        this.userMultiImageResponse,
        this.homePageResponse,
        this.communityResponseModel,
        this.chooseModeResponse,
        this.snoozeResponseModel,
        this.editProfileResponse,
        this.sendMatchFriendResponse,
        this.addRewindResponse,
        this.receiveMatchResponse,
        this.contactUsResponse,
        this.faqDataResponse,
        this.acceptRejectResponse
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
