import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/Network/bloc/login/login_event.dart';
import 'package:twosoul_multipz/Network/model/request%20model/login_request.dart';
import 'package:twosoul_multipz/main.dart';
import 'package:twosoul_multipz/ui/bottom_bar.dart';
import 'package:twosoul_multipz/ui/choose_language_screen.dart';
import 'package:twosoul_multipz/ui/sign_in_out/google.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';
import 'package:twosoul_multipz/utils/widget/error_message.dart';

import '../Network/bloc/login/login_bloc.dart';
import '../Network/view_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, ViewState>(
        listener: (context, state){
          if(state is LoadedState) {
            getStorage.write('LoginToken', state.loginResponse!.token.toString()).then((value) {
              print(getStorage.read('LoginToken'));
              getStorage.write('login', true);

              if(state.loginResponse!.data!.name ==""){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>  ChooseLanguageScreen(
                      // ignore: unrelated_type_equality_checks
                      setting: false,
                    )));
              }
              else{
                getStorage.write(getName, state.loginResponse!.data!.name);
                getStorage.write(getCountry, state.loginResponse!.data!.country!.name);
                getStorage.write(getCity, state.loginResponse!.data!.city!.name);
                getStorage.write(getState, state.loginResponse!.data!.state!.name);
                getStorage.write(getLookingFor, state.loginResponse!.data!.lookingFor);
                getStorage.write(getDistance, state.loginResponse!.data!.distance);
                getStorage.write(getProfilePhoto, state.loginResponse!.data!.image!.firstWhere((element) => element.isDefault == "1").imagename);
                getStorage.write(getAge, state.loginResponse!.data!.age);
                getStorage.write(getGender, state.loginResponse!.data!.gender);
                getStorage.write(getSexuality, state.loginResponse!.data!.sexuality!.name);
                getStorage.write(getHeight, state.loginResponse!.data!.height);
                getStorage.write(getDob, state.loginResponse!.data!.dob);
                getStorage.write(getReligion, state.loginResponse!.data!.religion!.name);
                getStorage.write(getRelationShipStatus, state.loginResponse!.data!.relaitonshipStatus);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>  BottomBar(isFilter: false,)));
            }}
            );
          }
        },
          builder: (BuildContext c, ViewState state) {
        return Container(
          padding: EdgeInsets.only(bottom: 2.vh, left: 4.vw, right: 4.vw),
          height: 100.vh,
          width: 100.vw,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(loginBackGround), fit: BoxFit.fill)),
          child: Column(
            children: [
              SizedBox(
                height: 15.vh,
              ),
              Image.asset(
                icTwoSoul,
                width: 25.vw,
              ),
              CommonTextView(twoSoul,
                  fontSize: 28.sp,
                  color: Colors.white,
                  fontFamily: displayBold),
              SizedBox(
                height: 1.vh,
              ),
              CommonTextView(loremLpsum,
                  textAlign: TextAlign.center,
                  fontFamily: displayRegular,
                  color: white70,
                  fontSize: 14.sp),
              const Spacer(),

              /// sign-in with google
              loginButton(icGoogle, btnTextLoginWithGoogle, lightGreyColor,
                  backGroundColor, () {
                signInWithGoogle().then((user) {
                  context.read<LoginBloc>().add(FetchData(LoginRequestModel(
                      loginType: "1", socialId: user.user.uid)));
                  if (state is ErrorState) {
                    final error = state.error;
                    return ErrorMessage(
                        error: '${error.message}\nTap to Retry.', callBack: () {});
                  } else
                  if (state is LoadingState) {
                    return const CustomLoader();
                  } else if (state is Empty) {
                    return ErrorMessage(error: '${state.msg}', callBack: () {});
                  }

                });
              }),

              /// sign-in with apple
              loginButton(icApple, btnTextLoginWithApple, Colors.transparent,
                  Colors.white, () {}),
              CommonTextView(
                byUsingUpYou,
                color: white70,
                fontSize: 12.sp,
                fontFamily: displayRegular,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget loginButton(icon, btnText, btnColor, textColor, onPressed) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.vh),
      height: 6.vh,
      // ignore: deprecated_member_use
      child: RaisedButton(
          onPressed: onPressed,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              side: BorderSide(color: greyColor)),
          color: btnColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(icon, height: 2.5.vh),
              SizedBox(
                width: 3.vw,
              ),
              CommonTextView(btnText,
                  fontSize: 16.sp, color: textColor, fontFamily: displayMedium),
            ],
          )),
    );
  }
}
