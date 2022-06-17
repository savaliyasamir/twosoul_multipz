import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/Network/bloc/create_profile/create_profile_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/create_profile/create_profile_event.dart';
import 'package:twosoul_multipz/Network/bloc/get_city/get_city_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/get_city/get_city_event.dart';
import 'package:twosoul_multipz/Network/bloc/get_country/get_country_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/get_country/get_country_event.dart';
import 'package:twosoul_multipz/Network/bloc/get_religion/get_religion_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/get_religion/get_religion_event.dart';
import 'package:twosoul_multipz/Network/bloc/get_sexuality/get_sexuality_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/get_sexuality/get_sexuality_event.dart';
import 'package:twosoul_multipz/Network/bloc/get_state/get_state_bloc.dart';
import 'package:twosoul_multipz/Network/model/request%20model/create_profile_request_model.dart';
import 'package:twosoul_multipz/Network/view_state.dart';
import 'package:twosoul_multipz/ui/bottom_bar.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/base_screen.dart';
import 'package:twosoul_multipz/utils/widget/common_button.dart';
import 'package:twosoul_multipz/utils/widget/common_drop.dart';
import 'package:twosoul_multipz/utils/widget/common_dropdown.dart';
import 'package:twosoul_multipz/utils/widget/common_slider.dart';
import 'package:twosoul_multipz/utils/widget/common_textField.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';
import 'package:twosoul_multipz/utils/widget/error_message.dart';
import '../Network/bloc/get_state/get_state_event.dart';
import '../Network/model/response model/common_model/sexuality_data.dart';
import '../utils/widget/common_dob_field.dart';

class MoreInformationScreen extends StatefulWidget {
  const MoreInformationScreen({Key? key}) : super(key: key);

  @override
  State<MoreInformationScreen> createState() => _MoreInformationScreenState();
}

class _MoreInformationScreenState extends State<MoreInformationScreen>  with SingleTickerProviderStateMixin {
  TextEditingController nameController = TextEditingController();
  double _heightRangeValue = 101;
  double latitude = 0.0;
  double longitude = 0.0;
  FocusNode dd = FocusNode();
  FocusNode mm = FocusNode();
  FocusNode yy = FocusNode();
  TextEditingController dateController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
   late TabController tabController;
  FocusNode? nameFocusNode;
  String selectedGender = 'Female';
  String? countryId;
  String? stateId;
  String? cityId;
  int? selectedSexualityId;
  int? selectedReligionId;
  var sexualityDataSelected;
  var selectedReligion;
  var countryDropDownValue;
  var stateDropDownvalue;
  var cityDropDownvalue;
  String selectedRelationshipStatus = 'single';
  bool isSelected = false;
  @override
  void initState() {
    super.initState();
    setState((){
      determinePosition();
    });
    tabController = TabController(vsync: this, length:3);
      context.read<GetSexualityBloc>().add(GetSexualityEvents.fetchData);
    context.read<GetReligionBloc>().add(GetReligionEvents.fetchData);
    context.read<GetCountryBloc>().add(GetCountryEvents.fetchData);
  }
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (!serviceEnabled) {
      await Geolocator.requestPermission();
    }


    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
      return Future.error(locationDenied);
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          locationPermanentlyDenied);
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
      longitude = position.longitude;
      latitude = position.latitude;
    return await Geolocator.getCurrentPosition();
  }
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(icBackButton, height: 2.vh)),
          SizedBox(height: 1.vh,),
        Expanded(
          child: SingleChildScrollView(
            physics:  const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: SizedBox(
              height: 110.vh,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextView(
                    name,
                      fontSize: 14.sp,color: Colors.white,fontFamily: raidProRegular
                  ),
                  CommonTextField(hintText: name, controller: nameController),
                  ///gender selection
                  CommonTextView(gender,fontSize: 14.sp,color: Colors.white,fontFamily: raidProRegular),
                  CommonDropDownButton(
                      item: genderList,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGender = newValue!;
                        });
                      },
                      value: selectedGender),
                  ///sexuality selection
                  CommonTextView(
                    sexuality,
                      fontSize: 14.sp,color: Colors.white,fontFamily: raidProRegular
                  ),
                  BlocBuilder<GetSexualityBloc, ViewState>(
                      builder: (BuildContext context, ViewState state) {
                                   if (state is ErrorState) {
                          final error = state.error;
                          return ErrorMessage(
                              error: '${error.message}\nTap to Retry.', callBack: () {});
                        } else
                        if (state is LoadingState) {
                          return const Center(child: CircularProgressIndicator(color: pinkColor,));
                        } else if (state is Empty) {
                          return ErrorMessage(error: '${state.msg}', callBack: () {});
                        }
                        if(state is LoadedState) {
                          return state. getSexualityResponse!.data != null ? CommonDrop(
                             hintText: '$select $sexuality',
                            item: state.getSexualityResponse!.data!, onChanged: (value){
                            setState((){
                              sexualityDataSelected = value;
                              selectedSexualityId = sexualityDataSelected.id;

                            });
                          }, value: sexualityDataSelected, ) :
                              Container();
                        }
                        return const Center(child: CircularProgressIndicator(color: pinkColor,));
                    }
                  ),
                  ///Age textField
                  CommonTextView(age,fontFamily: raidProRegular,fontSize: 14.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DOBTextField(
                        focusNode: dd,
                        onChanged: (value){
                          if(dateController.text.length == 2){
                            FocusScope.of(context).requestFocus(mm);
                          }
                        },
                        textInputAction: TextInputAction.next,
                        maxLength: 2,
                        hintText: 'DD',
                        controller: dateController,
                      ),
                      DOBTextField(
                        focusNode: mm,
                        onChanged: (value){
                          if(monthController.text.length == 2){
                            FocusScope.of(context).requestFocus(yy);
                          }else if(monthController.text.isEmpty){
                            FocusScope.of(context).requestFocus(dd);
                          }
                        },
                        textInputAction: TextInputAction.next,
                        maxLength: 2,
                        hintText: 'MM',
                        controller: monthController,
                      ), DOBTextField(
                        focusNode: yy,
                        onChanged: (value){
                          if(yearController.text.length == 4){
                            yy.unfocus();
                          }else if(yearController.text.isEmpty){
                            FocusScope.of(context).requestFocus(mm);
                          }
                        },
                        textInputAction: TextInputAction.done,
                        maxLength: 4,
                        hintText: 'YYYY',
                        controller: yearController,
                      ),
                    ],
                  ),
                  ///Height slider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonTextView(
                        height,
                          fontSize: 14.sp,color: Colors.white,fontFamily: raidProRegular
                      ),
                      CommonTextView('${_heightRangeValue.toInt()} cm     ',color: pinkColor,fontSize: 14.sp,fontFamily: displayRegular),
                      
                    ],
                  ),
                  CommonSlider(value: _heightRangeValue, onChanged: (value) {
                    setState(() {
                      _heightRangeValue = value;
                    });
                  }, max: 0, min: 200),
                  ///select Relation ship status drop down
                  CommonTextView(relationshipStatus,fontSize: 14.sp,fontFamily: raidProRegular),
                  CommonDropDownButton(item: relationshipStatusList, onChanged: (String? newValue){
                    setState(() {
                      selectedRelationshipStatus = newValue!;
                    });
                  }, value: selectedRelationshipStatus),
                  ///select Religion drop down
                  CommonTextView(religion,fontSize: 14.sp,fontFamily: raidProRegular),
                  BlocBuilder<GetReligionBloc, ViewState>(
                      builder: (BuildContext context, ViewState state) {
                        if (state is ErrorState) {
                          final error = state.error;
                          return ErrorMessage(
                              error: '${error.message}\nTap to Retry.', callBack: () {});
                        } else
                        if (state is LoadingState) {
                          return const Center(child: CircularProgressIndicator(color: pinkColor,));
                        } else if (state is Empty) {
                          return ErrorMessage(error: '${state.msg}', callBack: () {});
                        }
                        if(state is LoadedState) {
                          return state.getReligionResponse!.data != null ? CommonDrop(
                            hintText: '$select $religion',
                            item: state.getReligionResponse!.data!, onChanged: (value){
                            setState((){
                              selectedReligion = value;
                              selectedReligionId = selectedReligion.id;

                            });
                          }, value: selectedReligion, ) :
                          Container();
                        }
                        return const Center(child: CircularProgressIndicator(color: pinkColor,));
                      }
                  ),
                  ///State And Country Drop Down
                  Row(
                    children: [
                      CommonTextView(country,fontSize: 14.sp,fontFamily: raidProRegular),
                      SizedBox(
                        width: 35.vw,
                      ),
                      CommonTextView(state,fontSize: 14.sp,fontFamily: raidProRegular),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<GetCountryBloc, ViewState>(
                          builder: (BuildContext context, ViewState state) {
                            if (state is ErrorState) {
                              final error = state.error;
                              return ErrorMessage(
                                  error: '${error.message}\nTap to Retry.', callBack: () {});
                            } else
                            if (state is LoadingState) {
                              return const Center(child: CircularProgressIndicator(color: pinkColor,));
                            } else if (state is Empty) {
                              return ErrorMessage(error: '${state.msg}', callBack: () {});
                            }
                            if(state is LoadedState) {
                              return state.getCountryResponse!.data != null ? CommonDrop(
                                width: 45.vw,
                                hintText: '$select $country',
                                item: state.getCountryResponse!.data!, onChanged: (value){
                                setState((){
                                  stateDropDownvalue = null;
                                  cityDropDownvalue = null;
                                  countryDropDownValue = value;
                                  countryId = countryDropDownValue.id.toString();
                                  context.read<GetStateBloc>().add(FetchData(countryId.toString()));

                                });
                              }, value: countryDropDownValue, ) :
                              Container();
                            }
                            return const Center(child: CircularProgressIndicator(color: pinkColor,));
                          }
                      ),
                      BlocBuilder<GetStateBloc, ViewState>(
                          builder: (BuildContext context, ViewState state) {
                            if (state is ErrorState) {
                              final error = state.error;
                              return ErrorMessage(
                                  error: '${error.message}\nTap to Retry.', callBack: () {});
                            } else
                            if (state is LoadingState) {
                              return const Center(child: CircularProgressIndicator(color: pinkColor,));
                            } else if (state is Empty) {
                              return ErrorMessage(error: '${state.msg}', callBack: () {});
                            }
                            if(state is LoadedState) {
                              return state.getStateResponse!.data != null ? CommonDrop(
                                width: 45.vw,
                                hintText: selectState,
                                item: state.getStateResponse!.data!, onChanged: (value){
                                setState((){
                                  cityDropDownvalue = null;
                                  stateDropDownvalue = value;
                                  stateId = stateDropDownvalue.id.toString();
                                  context.read<GetCityBloc>().add(FetchCityData(countryId!,stateId!));
                                });
                              }, value: stateDropDownvalue, ) :
                              Container();
                            }
                            return const Center(child: CircularProgressIndicator(color: pinkColor,));
                          }
                      ),
                    ],
                  ),
                  /// City Drop Down
                  CommonTextView(city,fontSize: 14.sp,fontFamily: raidProRegular),
                  BlocBuilder<GetCityBloc, ViewState>(
                      builder: (BuildContext context, ViewState state) {
                        if (state is ErrorState) {
                          final error = state.error;
                          return ErrorMessage(
                              error: '${error.message}\nTap to Retry.', callBack: () {});
                        } else
                        if (state is LoadingState) {
                          return const Center(child: CircularProgressIndicator(color: pinkColor,));
                        } else if (state is Empty) {
                          return ErrorMessage(error: '${state.msg}', callBack: () {});
                        }
                        if(state is LoadedState) {
                          return state.getCityResponse!.data != null ? CommonDrop(
                            width: 45.vw,
                            hintText: selectState,
                            item: state.getCityResponse!.data!, onChanged: (value){
                            setState((){
                              cityDropDownvalue = value;
                              cityId = cityDropDownvalue.id.toString();
                            });
                          }, value: cityDropDownvalue, ) :
                          Container();
                        }
                        return const Center(child: CircularProgressIndicator(color: pinkColor,));
                      }
                  ),
                  ///select Looking for tab button
                  CommonTextView(lookingFor,fontSize: 14.sp,fontFamily: raidProRegular),
                  Theme(
                    data: Theme.of(context).copyWith(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      height: 6.vh,
                      decoration: BoxDecoration(
                          color: darkGreyColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child:  DefaultTabController(
                        length: 3, child:  TabBar(
                        controller: tabController,
                        unselectedLabelStyle: const TextStyle(color: Colors.white),
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: const BoxDecoration(
                            color: yellowColor),
                        unselectedLabelColor: Colors.white,
                        tabs: <Widget>[
                          Tab(
                            icon: CommonTextView('Friendship',fontFamily: displayMedium),
                          ),

                          Tab(
                            icon: CommonTextView('Date',fontFamily: displayMedium),
                          ),
                          Tab(
                            icon: CommonTextView('Relationship',fontFamily: displayMedium),
                          ),
                        ],
                      ),),
                    ),
                  ),
                  SizedBox(height: 3.vh,),
                  CommonButton(btnText: btnDone,onPressed: (){
                    context.read<CreateProfileBloc>().add(FetchCreateProfileData(CreateProfileRequestModel(
                      name: nameController.text,
                      latitude: latitude,
                      longitude: longitude,
                      stateId: int.parse(stateId.toString()),
                      cityId: int.parse(cityId.toString()),
                      countryId: int.parse(countryId.toString()),
                      gender: selectedGender.toLowerCase(),
                      height: _heightRangeValue.toInt(),
                      sexualityId: selectedSexualityId,
                      religionId: selectedReligionId,
                      relaitonshipStatus: selectedRelationshipStatus,
                      lookingFor: tabController.index,
                      dob: "${yearController.text}-${monthController.text}-${dateController.text}",
                    )));
                   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomBar()), (route) => false);
                  },),
                  SizedBox(height: 1.vh,),
                ],
              ),
            ),
          ),
        ),
        ],
      ),
    );
  }
}
