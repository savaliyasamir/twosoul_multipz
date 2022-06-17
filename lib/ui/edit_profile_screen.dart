import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/base_screen.dart';
import 'package:twosoul_multipz/utils/widget/common_button.dart';
import 'package:twosoul_multipz/utils/widget/common_dob_field.dart';
import 'package:twosoul_multipz/utils/widget/common_dropdown.dart';
import 'package:twosoul_multipz/utils/widget/common_slider.dart';
import 'package:twosoul_multipz/utils/widget/common_textField.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  FocusNode dd = FocusNode();
  FocusNode mm = FocusNode();
  FocusNode yy = FocusNode();
  TextEditingController dateController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  double _heightRangeValue = 101;
  late TabController tabController;
  FocusNode? nameFocusNode;
  String selectedGender = 'Female';
  String selectedSexuality = 'Homosexual';
  String selectedRelationshipStatus = 'single';
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
            SizedBox(height: 5.vh),
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
