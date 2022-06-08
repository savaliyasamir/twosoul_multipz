import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import '../ui/choose_mode_screen.dart';


///color
const Color white70 = Color(0xb3ffffff);
const Color white50 = Color(0x8affffff);
const Color pinkColor = Color(0xffF42852);
const Color yellowColor = Color(0xffF78A00);
const Color lightGreyColor = Color(0xffCFCFCF);
const Color greyColor = Color(0xff707070);
const Color darkGreyColor = Color(0xff333333);
const Color backGroundColor = Color(0xff262628);
const Color blueColor = Color(0xff2E40E9);

///font_family
const String displayMedium = 'SfUiDisplayMedium';
const String displayBold = 'SfUiDisplayBold';
const String displayLight = 'SfUiDisplayLight';
const String displayRegular = 'SfUiDisplayRegular';
const String raidProRegular = 'MyRaidProRegular';


///login_screen
const String loginBackGround = 'assets/image/login_backGround.png';
const String icTwoSoul = 'assets/ic/ic_twosoul.png';
const String twoSoul = 'TwoSoul';
const String loremLpsum = 'Lorem Ipsum is simply dummy text of printing\ntypesetting as a industry.Lorem Ipsum is\nsimply typesetting as a industry.';
const String  byUsingUpYou= 'By using up you agree to our terms of use\nand Prrivacy policy';
const String btnTextLoginWithGoogle = 'Login with Google';
const String btnTextLoginWithApple = 'Login with Apple';
const String icGoogle = 'assets/ic/ic_google.png';
const String icApple = 'assets/ic/ic_apple.png';


///Choose Language screen
const String chooseLanguage = 'Choose Language';
const String btnContinue = 'Continue';
List language = ['Spanise','English','French'];
String selectedLanguage = 'Spanise';
const icSelectedLanguage = 'assets/ic/ic_selectedLanguage.png';

///upload_image_screen
const String uploadImages = 'Upload Images';
const String uploadAMinimum = 'Upload a minimum of three pictures';
const String icBackButton = 'assets/ic/ic_backButton.png';
const String txtGallery = 'Gallery';
const String txtCamera = 'Camera';
const String txtChooseOption = 'Choose option';

///enable_location_screen
const String icLocation = 'assets/ic/ic_location.png';
const String enableLocation = 'Enable Your Location';
const String chooseYourLocation = 'Choose your location to start finding the\nrequest around you.';
const String btnEnableLocation = 'Enable Location';

///more_information_screen
const String name = 'Name';
const String gender = 'Gender';
const String sexuality = 'Sexuality';
const String age = 'Age';
const String height = 'Height';
const String relationshipStatus = 'Relationship Status';
const String religion = 'Religion';
const String lookingFor = 'Looking For';
const String btnDone = 'Done';
const String cm = 'cm';
const List<String> lookingForList = ['Friendship','Date','Relationship'];
const  List<String> genderList = ['Man',  'Woman',  'Other',];
const  List<String> sexualityList = ['Homosexual',  'Straight',  'Gay','Queer'];
const Color sliderTrackColor = Color(0xff999999);
const List<String> relationshipStatusList = ['Single','Married'];
const List<String> religionList = ['Hindu','Sikh','Parsi','Jain','Muslim','Christianity','Not Important'];

///bottom_bar
const String bottomBackGroundImage = 'assets/image/bottom_image.png';
const String icDisCover = 'assets/ic/ic_discover.png';
const String icDisCoverSelected = 'assets/ic/ic_discover2.png';
const String icLocation1 = 'assets/ic/ic_location2.png';
const String icLocation0 = "assets/ic/ic_location0.png";
const String icChat = 'assets/ic/ic_ chat.png';
const String icChatSelected = 'assets/ic/ic_chat2.png';
const String icProfile = 'assets/ic/ic_profile.png';
const String icProfileSelected ='assets/ic/ic_profile2.png';


///discover_screen
const String icFilter = 'assets/ic/ic_filter.png';
const String icMenu = 'assets/ic/ic_menu.png';
const String icReject = 'assets/ic/ic_reject.png';
const String icHeart = 'assets/ic/ic_heart.png';
const String icRemove = 'assets/ic/ic_remove.png';
const String icSend = 'assets/ic/ic_send.png';
const String icWhiteLike = 'assets/ic/ic_whiteLike.png';
const String icWhiteSuperLike = 'assets/ic/ic_whiteSuperLike.png';
const String icLeft = 'assets/ic/ic_left.png';
const String icRight = 'assets/ic/ic_right.png';
const String discover = 'Discover';
const String about = 'About';
const String seeAll = 'See All';


///Filter_screen
const String filters = 'Filters';
const String clear = 'Clear';
const String location = 'Location';
const String interestedIn = 'Interested In';
const String distance = 'Distance';
const String btnTextApply = 'Apply';

///Community_screen
const String community = 'Community';
const String  marbauUsers= 'Marbau users near by you';


///profile_screen
const String icUpgrade = 'assets/ic/ic_updrade.png';
const String icSuperLike = 'assets/ic/ic_superLike.png';
const String icLike = 'assets/ic/ic_like.png';
const String icSetting = 'assets/ic/ic_setting.png';
const String icEditProfile = 'assets/ic/ic_editProfile.png';
const String icCamara = 'assets/ic/ic_camara.png';
const String icGetCredits = 'assets/ic/ic_getCredits.png';
const String icRewinds = 'assets/ic/ic_Refresh.png';
const String  getCredits = 'Get Credits!';
const String getFreeCredits= 'Get free credits by watching videos';
TextStyle likeTextStyle = TextStyle(fontSize: 14.sp,color: Colors.white,fontFamily: displayLight);
const String setting = 'Setting';
const String addMedia = 'Add Media';
const String editProfile = 'Edit Profile';
const String likes = 'Likes';
const String superLikes = 'super\nLikes';
const String rewinds = 'Rewinds';
const String upgrade = 'Upgrade';
const String whatYouGetFree = 'What you get in Twosoul\nfree:';
List<String> twoSoulFree = ['200 Swipes','500km','10 rewinds','5 super likes'];
const String  whatYouGetPremium ='What you get in Twosoul\npremium:';
List<String> twoSoulPremium = ['Unlimited Swipes','Unlimited Distance','Unlimited  rewinds','Unlimited SwipesSuper likes'];
const String standOutWithLikes = 'Stand out with Likes';
const String  youAreMoreLikely= 'You\'re 3x more likely to get a\n match!';
const String btnGetLikes = 'Get Likes';
const String standOutWithSuperLikes = 'Stand out with Super Likes';
const String  youAreMoreSuperLikely= 'You\'re 3x more super likely to get a\n match!';
const String btnGetSuperLikes = 'Get Super Likes';
const String standOutWithRewinds = 'Stand out with Rewinds';
const String  youAreMoreRewinds= 'You\'re 3x more rewinds to get a\n match!';
const String btnGetRewinds = 'Get Rewinds';
const String btnNoThanks = 'No Thanks';
const String icFree ='assets/ic/ic_free.png';
const String icFreeUnselected = 'assets/ic/ic_freeUnselected.png';
const String icAddPhoto = 'assets/ic/ic_addPhoto.png';


///setting_screen
const String icClose = 'assets/ic/ic_close.png';
const String settingLoremIpsum   = 'Lorem Ipsum is simply dummy text of printing  simply dummy typesetting as a industry.Lorem Ipsum.';
const String chooseMode = 'Choose mode';
const String dateMode = 'Date mode';
const String snooze = 'Snooze';
const String incognitoMode = 'Incognito mode';
const String currentLocation = 'Current Location';
const String changeLanguage = 'Change Language';
const String securityPrivacy ='Security & Privacy';
const String contactFaq ='Contact & FAQ';
const String logOut = 'Logout';
const String deleteAccount = 'Delete Account';
const String icLanguage = 'assets/ic/ic_language.png';
const String icSecurity = 'assets/ic/ic_securityPrivacy.png';
const String icContact = 'assets/ic/ic_contact.png';
const String icLogout = 'assets/ic/ic_logout.png';
const String icDeleteAccount = 'assets/ic/ic_deleteAccount.png';
Widget horizontalDivider(){
  return Container(
    height: 0.1.vh,
    color: greyColor,
  );
}
//snooze
const String snoozeQuestion = 'How long do you want to be invisible for?';
const String hours24 = '24 hours';
const String hours72 = '72 hours';
const String aWeek = 'A week';
const String indefinitely = 'Indefinitely';
const String btnCancel = 'Cancel';
const String btnOk = 'Ok';
//incognito
const String icIncognito = 'assets/ic/ic_incognito.png';
const String doYouWantToGoIncognito= 'Do you want to go incognito?';
const String incognitoText= 'Lorem Ipsum is simply dummy text of printing\ntypesetting as a industry.Lorem Ipsum is simply\ndummy text of printingtypesetting as a industry.';
const String turnOnIncognitoMode= 'Turn on incognito mode';

///choose mode screen
const String whatKindOfConnection = 'What kind of connection are you\nlokking for?';
const String btnContinueWithDate ='Continue with Date';

///contact & faq
const String faq = 'FAQ';
const String contactUs = 'Contact Us';
const String termsOfService = 'Terms of service';
const String privacyPolicy ='Privacy Policy';
const String advertising='Advertising';

