import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/Network/bloc/accept_reject_friend_request/accept_reject_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/add_rewind/add_rewind_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/choose_mode/choose_mode_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/community/community_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/contact_us/contact_us_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/create_profile/create_profile_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/faq_data/faq_data_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/filter_%20data/filter_data_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/get_city/get_city_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/get_country/get_country_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/get_language/get_language_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/get_religion/get_religion_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/get_sexuality/get_sexuality_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/get_state/get_state_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/home_page/home_page_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/login/login_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/receive_match_friend/receive_match_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/send_match_friend/send_match_friend_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/set_language/set_language_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/snooze/snooze_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/user_multi_image/user_multi_image_bloc.dart';
import 'package:twosoul_multipz/Network/repository/repository.dart';
import 'package:twosoul_multipz/ui/bottom_bar.dart';
import 'package:twosoul_multipz/ui/login_screen.dart';
import 'package:twosoul_multipz/ui/no_internet_screen.dart';
final getStorage = GetStorage();
void main() async{
  await GetStorage.init();
  init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}
Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  ///internet connectivity check
  StreamSubscription ? subscription;
  bool isInternetConnected = false;
  bool isLogin = false;
  @override
  // ignore: must_call_super
  void initState() {
    ///internet connectivity

    setState(() {

      isLogin = getStorage.read("login")??false;

      subscription = Connectivity()
          .onConnectivityChanged
          .listen((result) {
        setState(() {
          isInternetConnected = result != ConnectivityResult.none;
        });
      });
    });
    initialization();
  }
  ///splash screen time duration
  void initialization() async {
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(repository: LoginRepository()),
        ),
        BlocProvider<GetLanguageBloc>(
          create: (BuildContext context) => GetLanguageBloc(repository: GetLanguageRepository()),
        ),
        BlocProvider<SetLanguageBloc>(
          create: (BuildContext context) => SetLanguageBloc(repository: SetLanguageRepository()),
        ),
        BlocProvider<GetSexualityBloc>(
          create: (BuildContext context) => GetSexualityBloc(repository: GetSexualityRepository()),
        ),
        BlocProvider<GetReligionBloc>(
          create: (BuildContext context) => GetReligionBloc(repository: GetReligionRepository()),
        ),
        BlocProvider<GetCountryBloc>(
          create: (BuildContext context) => GetCountryBloc(repository: GetCountryRepository()),
        ),
        BlocProvider<GetStateBloc>(
          create: (BuildContext context) => GetStateBloc(repository: GetStateRepository()),
        ),
        BlocProvider<GetCityBloc>(
          create: (BuildContext context) => GetCityBloc(repository: GetCityRepository()),
        ),
        BlocProvider<CreateProfileBloc>(
          create: (BuildContext context) => CreateProfileBloc(repository: CreateProfileRepository()),
        ),
        BlocProvider<UserMultiImageBloc>(
          create: (BuildContext context) => UserMultiImageBloc(repository: UserMultiImageRepository()),
        ),
        BlocProvider<HomePageBloc>(
          create: (BuildContext context) => HomePageBloc(repository: HomePageRepository()),
        ),
        BlocProvider<CommunityBloc>(
          create: (BuildContext context) => CommunityBloc(repository: CommunityRepository()),
        ),
        BlocProvider<ChooseModeBloc>(
          create: (BuildContext context) => ChooseModeBloc(repository: ChooseModeRepository()),
        ),
        BlocProvider<SnoozeBloc>(
          create: (BuildContext context) => SnoozeBloc(repository: SnoozeRepository()),
        ),
        BlocProvider<EditProfileBloc>(
          create: (BuildContext context) => EditProfileBloc(repository: EditProfileRepository()),
        ),
        BlocProvider<FilterDataBloc>(
          create: (BuildContext context) => FilterDataBloc(repository: FilterDataRepository()),
        ),
        BlocProvider<SendMatchFriendBloc>(
          create: (BuildContext context) => SendMatchFriendBloc(repository: SendMatchFriendRepository()),
        ),
        BlocProvider<AddRewindBloc>(
          create: (BuildContext context) => AddRewindBloc(repository: AddRewindRepository()),
        ),
        BlocProvider<ReceiveMatchBloc>(
          create: (BuildContext context) => ReceiveMatchBloc(repository: ReceiveMatchRepository()),
        ),
        BlocProvider<ContactUsBloc>(
          create: (BuildContext context) => ContactUsBloc(repository: ContactUsRepository()),
        ),
        BlocProvider<GetFaqDataBloc>(
          create: (BuildContext context) => GetFaqDataBloc(repository: FaqDataRepository()),
        ),
        BlocProvider<AcceptRejectBloc>(
          create: (BuildContext context) => AcceptRejectBloc(repository: AcceptRejectRepository()),
        ),
      ],
      child: Resize(builder: () {
        return MaterialApp(
          supportedLocales: const [
            Locale("af"),
            Locale("am"),
            Locale("ar"),
            Locale("az"),
            Locale("be"),
            Locale("bg"),
            Locale("bn"),
            Locale("bs"),
            Locale("ca"),
            Locale("cs"),
            Locale("da"),
            Locale("de"),
            Locale("el"),
            Locale("en"),
            Locale("es"),
            Locale("et"),
            Locale("fa"),
            Locale("fi"),
            Locale("fr"),
            Locale("gl"),
            Locale("ha"),
            Locale("he"),
            Locale("hi"),
            Locale("hr"),
            Locale("hu"),
            Locale("hy"),
            Locale("id"),
            Locale("is"),
            Locale("it"),
            Locale("ja"),
            Locale("ka"),
            Locale("kk"),
            Locale("km"),
            Locale("ko"),
            Locale("ku"),
            Locale("ky"),
            Locale("lt"),
            Locale("lv"),
            Locale("mk"),
            Locale("ml"),
            Locale("mn"),
            Locale("ms"),
            Locale("nb"),
            Locale("nl"),
            Locale("nn"),
            Locale("no"),
            Locale("pl"),
            Locale("ps"),
            Locale("pt"),
            Locale("ro"),
            Locale("ru"),
            Locale("sd"),
            Locale("sk"),
            Locale("sl"),
            Locale("so"),
            Locale("sq"),
            Locale("sr"),
            Locale("sv"),
            Locale("ta"),
            Locale("tg"),
            Locale("th"),
            Locale("tk"),
            Locale("tr"),
            Locale("tt"),
            Locale("uk"),
            Locale("ug"),
            Locale("ur"),
            Locale("uz"),
            Locale("vi"),
            Locale("zh")
          ],
          localizationsDelegates: const [
            CountryLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme:  ThemeData(
            primarySwatch: Colors.grey,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          home: isInternetConnected ? getStorage.read("login")??false ?  BottomBar(isFilter: false,):const LoginScreen() : const NoInternetScreen(),
        );
      },),
    );
  }
}

/*
Variant: debug
Config: debug
Store: C:\Users\ADMIN\.android\debug.keystore
Alias: AndroidDebugKey
MD5: 0D:1C:CF:F1:A5:48:69:2F:DC:0F:48:E8:2D:69:3C:49
SHA1: 1C:E4:D9:60:4E:6B:78:C9:2D:74:9C:8E:5D:69:35:81:04:DA:D9:0A
SHA-256: B9:E5:B6:8A:52:FF:F7:EF:F5:25:90:61:83:14:F2:8F:F2:9A:B4:DC:20:16:7B:8C:19:EE:20:69:9A:BB:37:D3
Valid until: Thursday, 21 March, 2052
*/
