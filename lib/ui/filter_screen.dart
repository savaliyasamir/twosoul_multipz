import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/Network/bloc/filter_%20data/filter_data_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/filter_%20data/filter_data_event.dart';
import 'package:twosoul_multipz/Network/bloc/get_religion/get_religion_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/get_sexuality/get_sexuality_bloc.dart';
import 'package:twosoul_multipz/Network/model/request%20model/filter_data_request_model.dart';
import 'package:twosoul_multipz/Network/view_state.dart';
import 'package:twosoul_multipz/ui/bottom_bar.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/base_screen.dart';
import 'package:twosoul_multipz/utils/widget/common_button.dart';
import 'package:twosoul_multipz/utils/widget/common_drop.dart';
import 'package:twosoul_multipz/utils/widget/common_range_slider.dart';
import 'package:twosoul_multipz/utils/widget/common_slider.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';
import 'package:twosoul_multipz/utils/widget/error_message.dart';

import '../Network/bloc/get_religion/get_religion_event.dart';
import '../Network/bloc/get_sexuality/get_sexuality_event.dart';



///03-06-2022
class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> with TickerProviderStateMixin  {
  FocusNode dd = FocusNode();
  FocusNode mm = FocusNode();
  FocusNode yy = FocusNode();
  TextEditingController dateController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  double distanceValue = 75;
  int? selectedSexualityId;
  var sexualityDataSelected;
  int? selectedReligionId;
  var selectedReligion;
  TextEditingController locationController = TextEditingController();
  RangeValues ageValue = const RangeValues(20, 30);
  RangeValues heightValue = const RangeValues(116, 175);
  late TabController lookingForController;
  late TabController genderController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lookingForController = TabController(vsync: this, length: 3);
    genderController = TabController(vsync: this, length: 3);
    context.read<GetSexualityBloc>().add(GetSexualityEvents.fetchData);
    context.read<GetReligionBloc>().add(GetReligionEvents.fetchData);

  }
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(icBackButton, height: 2.vh),
              ),
              CommonTextView(
                filters,
                  fontSize: 20.sp,fontFamily: displayMedium,color: Colors.white
              ),
              CommonTextView(
                clear,
                color: yellowColor,
                fontSize: 12.sp,
                fontFamily: displayMedium,
              ),
            ],
          ),
          SizedBox(
            height: 2.vh,
          ),
        Expanded(child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: SizedBox(
            height: 90.vh,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Location TextField
               /* CommonTextView(
                  location,
                  fontSize: 14.sp,fontFamily: raidProRegular,
                ),
                TextField(
                  controller: locationController,
                  cursorColor: lightGreyColor,
                  style: const TextStyle(color: white50),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    suffixIcon:
                    Icon(Icons.location_on, color: yellowColor, size: 5.vw),
                    fillColor: darkGreyColor,
                    filled: true,
                    contentPadding: EdgeInsets.only(left: 4.vw, right: 4.vw,top: 1.vh,bottom: 3.vh),
                    hintText: 'Location',
                    hintStyle: TextStyle(
                        color: greyColor,
                        fontSize: 14.sp,
                        fontFamily: displayRegular),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),*/
                ///Interested In
                CommonTextView(interestedIn,fontSize: 14.sp,fontFamily: raidProRegular,),
                Theme(
                  data: Theme.of(context).copyWith(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                  ),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    height: 13.vw,
                    decoration: BoxDecoration(
                        color: darkGreyColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:   DefaultTabController(
                      length: 3, child:  TabBar(
                      controller: genderController,
                      unselectedLabelStyle: const TextStyle(color: Colors.white),
                      labelColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: const BoxDecoration(
                          color: yellowColor),
                      unselectedLabelColor: Colors.white,
                      tabs: <Widget>[
                        Tab(
                          icon: CommonTextView('Girls',fontFamily: displayMedium),
                        ),
                        Tab(
                          icon: CommonTextView('Boys',fontFamily: displayMedium),
                        ),
                        Tab(
                          icon: CommonTextView('Both',fontFamily: displayMedium),
                        ),
                      ],
                    ),),
                  ),
                ),
                /// Distance Slider
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextView(
                      distance,
                      fontSize: 14.sp,fontFamily: raidProRegular,
                    ),
                    CommonTextView(
                        '${distanceValue.toInt()} km.     ',
                        color: pinkColor,fontSize: 14.sp,fontFamily: displayRegular),
                  ],
                ),
                CommonSlider(value: distanceValue, onChanged: (value) {
                  setState(() {
                    distanceValue = value;
                  });
                }, max: 0, min: 200),
                ///Age TextField
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextView(age,fontFamily: raidProRegular,fontSize: 14.sp),
                    CommonTextView(
                        '${ageValue.start.toInt()} - ${ageValue.end.toInt()}     ',
                        color: pinkColor,fontSize: 14.sp,fontFamily: displayRegular),

                  ],
                ),
                CommonRangeSlider(
                    value: ageValue,
                    onChanged: (RangeValues value) {
                      setState(() {
                        ageValue = value;
                      });
                    },
                    max: 100,
                    min: 1),
                ///Height slider
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextView(
                        height,
                        fontSize: 14.sp,color: Colors.white,fontFamily: raidProRegular
                    ),
                    CommonTextView('${heightValue.start.toInt()} - ${heightValue.end.toInt()} km     ',color: pinkColor,fontSize: 14.sp,fontFamily: displayRegular),

                  ],
                ),
                CommonRangeSlider(
                    value: heightValue,
                    onChanged: (RangeValues value) {
                      setState(() {
                        heightValue = value;
                      });
                    },
                    max: 200,
                    min: 100),
                ///Sexuality Drop Down
                CommonTextView(
                  sexuality,
                  fontSize: 14.sp,fontFamily: raidProRegular,
                ),
                BlocBuilder<GetSexualityBloc, ViewState>(
                    builder: (BuildContext context, ViewState state) {
                      if (state is ErrorState) {
                        final error = state.error;
                        return ErrorMessage(
                            error: '${error.message}\nTap to Retry.',
                            callBack: () {});
                      } else if (state is LoadingState) {
                        return const CustomLoader();
                      } else if (state is Empty) {
                        return ErrorMessage(
                            error: '${state.msg}', callBack: () {});
                      }
                      if (state is LoadedState) {
                        return state.getSexualityResponse!.data != null
                            ? CommonDrop(
                          hintText: '$select $sexuality',
                          item: state.getSexualityResponse!.data!,
                          onChanged: (value) {
                            setState(() {
                              sexualityDataSelected = value;
                              selectedSexualityId =
                                  sexualityDataSelected.id;
                            });
                          },
                          value: sexualityDataSelected,
                        )
                            : Container();
                      }
                      return const Center(
                          child: CircularProgressIndicator(
                            color: pinkColor,
                          ));
                    }),
                ///Religion Drop Down
                CommonTextView(religion,fontSize: 14.sp,fontFamily: raidProRegular,),
                BlocBuilder<GetReligionBloc, ViewState>(
                    builder: (BuildContext context, ViewState state) {
                      if (state is ErrorState) {
                        final error = state.error;
                        return ErrorMessage(
                            error: '${error.message}\nTap to Retry.',
                            callBack: () {});
                      } else if (state is LoadingState) {
                        return const CustomLoader();
                      } else if (state is Empty) {
                        return ErrorMessage(
                            error: '${state.msg}', callBack: () {});
                      }
                      if (state is LoadedState) {
                        return state.getReligionResponse!.data != null
                            ? CommonDrop(
                          hintText: '$select $religion',
                          item: state.getReligionResponse!.data!,
                          onChanged: (value) {
                            setState(() {
                              selectedReligion = value;
                              selectedReligionId = selectedReligion.id;
                            });
                          },
                          value: selectedReligion,
                        )
                            : Container();
                      }
                      return const Center(
                          child: CircularProgressIndicator(
                            color: pinkColor,
                          ));
                    }),
               ///Looking for
               CommonTextView(lookingFor,fontSize: 14.sp,fontFamily: raidProRegular,),
                Theme(
                  data: Theme.of(context).copyWith(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                  ),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    height: 13.vw,
                    decoration: BoxDecoration(
                        color: darkGreyColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:   DefaultTabController(
                      length: 3, child:  TabBar(
                      controller: lookingForController,
                      unselectedLabelStyle: const TextStyle(color: Colors.white),
                      labelColor: Colors.white,
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
                SizedBox(height: 2.vh,),
                CommonButton(btnText: btnTextApply,onPressed: (){
                  context.read<FilterDataBloc>().add(FetchFilterData(FilterDataRequestModel(
                    lookingFor: lookingForController.index ,
                    sexualityId: selectedSexualityId,
                    religionId: selectedReligionId,
                    distance: distanceValue.toInt(),
                    ageStart: ageValue.start.toInt(),
                    ageEnd: ageValue.end.toInt(),
                    heightStart: heightValue.start.toInt(),
                    heightEnd: heightValue.end.toInt(),
                    interestedIn: genderController.index == 0 ? "male" : genderController.index == 1 ? "female" : "both",
                  )));
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomBar(isFilter: true)));
                },),
                SizedBox(height: 2.vh,),
              ],
            ),
          ),
        )),
        ],
      ),
    );
  }
}
