import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/base_screen.dart';
import 'package:twosoul_multipz/utils/widget/common_button.dart';
import 'package:twosoul_multipz/utils/widget/common_dropdown.dart';
import 'package:twosoul_multipz/utils/widget/common_range_slider.dart';
import 'package:twosoul_multipz/utils/widget/common_slider.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';

import '../utils/widget/common_dob_field.dart';


///03-06-2022
class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  FocusNode dd = FocusNode();
  FocusNode mm = FocusNode();
  FocusNode yy = FocusNode();
  TextEditingController dateController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  double _heightRangeValue = 101;
  TextEditingController locationController = TextEditingController();
  RangeValues distanceValue = const RangeValues(10, 75);
  RangeValues ageValue = const RangeValues(20, 30);
  RangeValues heightValue = const RangeValues(156, 175);
  String selectedSexuality = 'Homosexual';
  String selectedReligion = 'Not Important';
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
            height: 100.vh,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Location TextField
                CommonTextView(
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
                ),
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
                        '${distanceValue.start.toInt()} - ${distanceValue.end.toInt()} km.     ',
                        color: pinkColor,fontSize: 14.sp,fontFamily: displayRegular),
                  ],
                ),
                CommonRangeSlider(
                    value: distanceValue,
                    onChanged: (RangeValues value) {
                      setState(() {
                        distanceValue = value;
                      });
                    },
                    max: 100,
                    min: 1),
                ///Age TextField
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
                ///Sexuality Drop Down
                CommonTextView(
                  sexuality,
                  fontSize: 14.sp,fontFamily: raidProRegular,
                ),
                CommonDropDownButton(
                    item: sexualityList,
                    onChanged: (String value) {
                      setState(() {
                        selectedSexuality = value;
                      });
                    },
                    value: selectedSexuality),
                ///Religion Drop Down
                CommonTextView(religion,fontSize: 14.sp,fontFamily: raidProRegular,),
                CommonDropDownButton(item: religionList, onChanged: (String value){setState(() {
                  selectedReligion = value;
                });}, value: selectedReligion),
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
                CommonButton(btnText: btnTextApply,onPressed: (){},),
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
