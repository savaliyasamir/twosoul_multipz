import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/base_screen.dart';
import 'package:twosoul_multipz/utils/widget/common_button.dart';
import 'package:twosoul_multipz/utils/widget/common_dropdown.dart';
import 'package:twosoul_multipz/utils/widget/common_range_slider.dart';
import 'package:twosoul_multipz/utils/widget/common_textfield.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  RangeValues _ageRangeValue = const RangeValues(20, 30);
  RangeValues _heightRangeValue = const RangeValues(156, 175);
  late TabController tabController;
  FocusNode? nameFocusNode;
  String selectedGender = 'Woman';
  String selectedSexuality = 'Homosexual';
  String selectedRelationshipStatus = 'Single';
  String   selectedReligion = 'Christianity';
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Image.asset(icBackButton,height: 4.vw),
            ),
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    margin: EdgeInsets.all(2.vw),
                  height: 30.vw,
                  width: 30.vw,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.vw),
                    border: Border.all(color: Colors.white,width: 1.vw),
                  ),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.vw),
                        ),
                        height: 29.vw,
                        width: 29.vw,
                        child: Image.asset('assets/image/Rectangle 129.png',fit: BoxFit.cover ,)),
                ),
                  Image.asset('assets/ic/ic_editProfile1.png',width: 13.vw,),
    ]
              ),
            ),
            SizedBox(height: 5.vh,),
            Expanded(
              child: SingleChildScrollView(
                physics:  const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: SizedBox(
                  height: 100.vh,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextView(
                          name,
                          fontSize: 14.sp,color: Colors.white,fontFamily: raidProRegular
                      ),
                      CommonTextField(hintText: name, controller: nameController),
                      CommonTextView(gender,fontSize: 14.sp,color: Colors.white,fontFamily: raidProRegular),
                      CommonDropDownButton(
                          item: genderList,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedGender = newValue!;
                            });
                          },
                          value: selectedGender),
                      CommonTextView(
                          sexuality,
                          fontSize: 14.sp,color: Colors.white,fontFamily: raidProRegular
                      ),
                      CommonDropDownButton(
                          item: sexualityList,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedSexuality = newValue!;
                            });
                          },
                          value: selectedSexuality),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonTextView(
                              age,
                              fontSize: 14.sp,color: Colors.white,fontFamily: raidProRegular
                          ),
                          CommonTextView('${_ageRangeValue.start.toInt()} - ${_ageRangeValue.end.toInt()}      ',color: pinkColor,fontSize: 14.sp,fontFamily: displayRegular),
                        ],
                      ),
                      CommonRangeSlider(
                          min: 10,
                          max: 50,
                          value: _ageRangeValue, onChanged: (RangeValues value){
                        setState(() {
                          _ageRangeValue = value;
                        });
                      }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonTextView(
                              height,
                              fontSize: 14.sp,color: Colors.white,fontFamily: raidProRegular
                          ),
                          CommonTextView('${_heightRangeValue.start.toInt()} - ${_heightRangeValue.end.toInt()}cm     ',color: pinkColor,fontSize: 14.sp,fontFamily: displayRegular),

                        ],
                      ),
                      CommonRangeSlider(
                          min: 100,
                          max: 200,
                          value: _heightRangeValue, onChanged: (RangeValues value){
                        setState(() {
                          _heightRangeValue= value;
                        });
                      }),
                      CommonTextView(relationshipStatus,fontSize: 14.sp,color: Colors.white,fontFamily: raidProRegular),
                      CommonDropDownButton(item: relationshipStatusList, onChanged: (String? newValue){
                        setState(() {
                          selectedRelationshipStatus = newValue!;
                        });
                      }, value: selectedRelationshipStatus),
                      CommonTextView(religion,fontSize: 14.sp,color: Colors.white,fontFamily: raidProRegular),
                      CommonDropDownButton(item: religionList, onChanged: (String? newValue){
                        setState(() {
                          selectedReligion = newValue!;
                        });
                      }, value: selectedReligion),
                      CommonTextView(lookingFor,fontSize: 14.sp,color: Colors.white,fontFamily: raidProRegular),
                      Theme(
                        data: Theme.of(context).copyWith(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                        ),
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          height: 12.vw,
                          decoration: BoxDecoration(
                              color: darkGreyColor,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: const DefaultTabController(
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
                      SizedBox(height: 3.vh,),
                      CommonButton(btnText: btnDone,onPressed: (){
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
