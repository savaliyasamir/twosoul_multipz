import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/base_screen.dart';
import 'package:twosoul_multipz/utils/widget/common_button.dart';
import 'package:twosoul_multipz/utils/widget/common_dropdown.dart';
import 'package:twosoul_multipz/utils/widget/common_range_slider.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';


///03-06-2022
class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
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
            height: 90.vh,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    Icon(Icons.location_on, color: yellowColor, size: 2.5.vh),
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
                CommonTextView(interestedIn,fontSize: 14.sp,fontFamily: raidProRegular,),
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
                    child:  const DefaultTabController(
                      length: 3, child:  TabBar(
                      unselectedLabelStyle: TextStyle(color: Colors.white),
                      labelColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                          color: yellowColor),
                      unselectedLabelColor: Colors.white,
                      tabs: <Widget>[
                        Tab(
                          icon: Text('Girls'),
                        ),
                        Tab(
                          icon: Text('Boys'),
                        ),
                        Tab(
                          icon: Text('Both'),
                        ),
                      ],
                    ),),
                  ),
                ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   CommonTextView(
                      age,
                      fontSize: 14.sp,fontFamily: raidProRegular,
                    ),
                    CommonTextView('${ageValue.start.toInt()} - ${ageValue.end.toInt()}      ',
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
                    max: 50,
                    min: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextView(
                      height,
                      fontSize: 14.sp,fontFamily: raidProRegular,
                    ),
                   CommonTextView(
                        '${heightValue.start.toInt()} - ${heightValue.end.toInt()}cm      ',
                       color: pinkColor,fontSize: 14.sp,fontFamily: displayRegular),
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
                CommonTextView(religion,fontSize: 14.sp,fontFamily: raidProRegular,),
                CommonDropDownButton(item: religionList, onChanged: (String value){setState(() {
                  selectedReligion = value;
                });}, value: selectedReligion),
               CommonTextView(lookingFor,fontSize: 14.sp,fontFamily: raidProRegular,),
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
                    child:  const DefaultTabController(
                      length: 3, child:  TabBar(
                      unselectedLabelStyle: TextStyle(color: Colors.white),
                      labelColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                          color: yellowColor),
                      unselectedLabelColor: Colors.white,
                      tabs: <Widget>[
                        Tab(
                          icon: Text('Friendship'),
                        ),

                        Tab(
                          icon: Text('Date'),
                        ),
                        Tab(
                          icon: Text('Relationship'),
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
