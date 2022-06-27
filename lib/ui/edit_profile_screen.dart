import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/Network/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/get_religion/get_religion_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/get_religion/get_religion_event.dart';
import 'package:twosoul_multipz/Network/bloc/get_sexuality/get_sexuality_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/get_sexuality/get_sexuality_event.dart';
import 'package:twosoul_multipz/Network/model/request%20model/edit_profile_request_model.dart';
import 'package:twosoul_multipz/Network/view_state.dart';
import 'package:twosoul_multipz/main.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/base_screen.dart';
import 'package:twosoul_multipz/utils/widget/common_button.dart';
import 'package:twosoul_multipz/utils/widget/common_dob_field.dart';
import 'package:twosoul_multipz/utils/widget/common_drop.dart';
import 'package:twosoul_multipz/utils/widget/common_dropdown.dart';
import 'package:twosoul_multipz/utils/widget/common_slider.dart';
import 'package:twosoul_multipz/utils/widget/common_textField.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';
import 'package:twosoul_multipz/utils/widget/error_message.dart';
import '../Network/bloc/edit_profile/edit_profile_event.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  FocusNode dd = FocusNode();
  FocusNode mm = FocusNode();
  FocusNode yy = FocusNode();
  TextEditingController dateController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  double _heightRangeValue = 101;
  late TabController tabController;
  FocusNode? nameFocusNode;
  String selectedGender = 'female';
  String selectedRelationshipStatus = 'single';
  var selectedReligion;
  int? selectedSexualityId;
  var sexualityDataSelected;
  int? selectedReligionId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStorage.write(getHeight, "185");
    tabController = TabController(vsync: this, length: 3);
    nameController.text = getStorage.read(getName);
    String dob = getStorage.read(getDob);
    yearController.text = dob.substring(0, 4);
    monthController.text = dob.substring(5, 7);
    dateController.text = dob.substring(8, 10);
    selectedGender = getStorage.read(getGender);
    _heightRangeValue = double.parse(getStorage.read(getHeight).toString());
    tabController.index = int.parse(getStorage.read(getLookingFor));
    selectedRelationshipStatus =
        getStorage.read(getRelationShipStatus) ?? "single";
    aboutController.text = getStorage.read(getAbout) ?? "";
    designationController.text = getStorage.read(getDesignation) ?? "";
    context.read<GetReligionBloc>().add(GetReligionEvents.fetchData);
    context.read<GetSexualityBloc>().add(GetSexualityEvents.fetchData);
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
            child: Image.asset(icBackButton, height: 4.vw),
          ),
          Center(
            child: Stack(alignment: Alignment.bottomRight, children: [
              Container(
                margin: EdgeInsets.all(2.vw),
                height: 30.vw,
                width: 30.vw,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.vw),
                  border: Border.all(color: Colors.white, width: 1.vw),
                ),
                child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.vw),
                    ),
                    height: 29.vw,
                    width: 29.vw,
                    child: Image.network(
                      getStorage.read(getProfilePhoto),
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return  const CustomLoader();
                      },
                    )),
              ),
            ]),
          ),
          SizedBox(height: 5.vh),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: SizedBox(
                height: 120.vh,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextView(name,
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontFamily: raidProRegular),
                    CommonTextField(hintText: name, controller: nameController),
                    ///gender
                    CommonTextView(gender,
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontFamily: raidProRegular),
                    CommonDropDownButton(
                        item: genderList,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedGender = newValue!;
                          });
                        },
                        value: selectedGender),
                    ///sexuality
                    CommonTextView(sexuality,
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontFamily: raidProRegular),
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
                        for (var element in state.getSexualityResponse!.data!) {
                          if (element.name == getStorage.read(getSexuality)) {
                            sexualityDataSelected = element;
                          }
                        }
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

                    ///date of birth TextField
                    CommonTextView("Date of Birth",
                        fontFamily: raidProRegular, fontSize: 14.sp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DOBTextField(
                          enable: false,
                          focusNode: dd,
                          onChanged: (value) {
                            if (dateController.text.length == 2) {
                              FocusScope.of(context).requestFocus(mm);
                            }
                          },
                          textInputAction: TextInputAction.next,
                          maxLength: 2,
                          hintText: 'DD',
                          controller: dateController,
                        ),
                        DOBTextField(
                          enable: false,
                          focusNode: mm,
                          onChanged: (value) {
                            if (monthController.text.length == 2) {
                              FocusScope.of(context).requestFocus(yy);
                            } else if (monthController.text.isEmpty) {
                              FocusScope.of(context).requestFocus(dd);
                            }
                          },
                          textInputAction: TextInputAction.next,
                          maxLength: 2,
                          hintText: 'MM',
                          controller: monthController,
                        ),
                        DOBTextField(
                          enable: false,
                          focusNode: yy,
                          onChanged: (value) {
                            if (yearController.text.length == 4) {
                              yy.unfocus();
                            } else if (yearController.text.isEmpty) {
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
                        CommonTextView(height,
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontFamily: raidProRegular),
                        CommonTextView('${_heightRangeValue.toInt()} cm     ',
                            color: pinkColor,
                            fontSize: 14.sp,
                            fontFamily: displayRegular),
                      ],
                    ),
                    CommonSlider(
                        value: _heightRangeValue,
                        onChanged: (value) {
                          setState(() {
                            _heightRangeValue = value;
                          });
                        },
                        max: 0,
                        min: 200),

                    ///relationship status
                    CommonTextView(relationshipStatus,
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontFamily: raidProRegular),
                    CommonDropDownButton(
                        item: relationshipStatusList,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedRelationshipStatus = newValue!;
                          });
                        },
                        value: selectedRelationshipStatus),

                    ///religion
                    CommonTextView(religion,
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontFamily: raidProRegular),
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
                        for (var element in state.getReligionResponse!.data!) {
                          if (element.name == getStorage.read(getReligion)) {
                            selectedReligion = element;
                          }
                        }
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

                    ///designation
                    CommonTextView(designation,
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontFamily: raidProRegular),
                    CommonTextField(
                        hintText: designation,
                        controller: designationController),

                    ///about
                    CommonTextView(about,
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontFamily: raidProRegular),
                    TextField(
                      maxLines: 4,
                      controller: aboutController,
                      cursorColor: lightGreyColor,
                      style: TextStyle(color: white50, fontSize: 12.sp),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 3.vw, horizontal: 3.vw),
                        fillColor: darkGreyColor,
                        filled: true,
                        //   contentPadding: EdgeInsets.only(left: 4.vw, right: 4.vw),
                        hintText: about,
                        hintStyle: TextStyle(
                            color: greyColor,
                            fontSize: 14.sp,
                            fontFamily: 'SfUiDisplayRegular'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    ///looking for
                    CommonTextView(lookingFor,
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontFamily: raidProRegular),
                    Theme(
                      data: Theme.of(context).copyWith(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        clipBehavior: Clip.antiAlias,
                        height: 13.vw,
                        decoration: BoxDecoration(
                            color: darkGreyColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: DefaultTabController(
                          length: 3,
                          child: TabBar(
                            controller: tabController,
                            unselectedLabelStyle:
                                const TextStyle(color: Colors.white),
                            labelColor: Colors.white,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: const BoxDecoration(color: yellowColor),
                            unselectedLabelColor: Colors.white,
                            tabs: const <Widget>[
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
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.vh,
                    ),
                    CommonButton(
                      btnText: btnDone,
                      onPressed: () {
                        getStorage.write(getDesignation, designationController.text);
                        getStorage.write(getHeight, _heightRangeValue.toString());
                        getStorage.write(getName, nameController.text);
                        getStorage.write(getAbout, aboutController.text);
                        getStorage.write(getRelationShipStatus, selectedRelationshipStatus);
                        getStorage.write(getSexuality, sexualityDataSelected.name);
                        context.read<EditProfileBloc>().add(FetchEditProfileData(EditProfileRequestModel(
                          name: nameController.text,
                          about: aboutController.text,
                          designation: designationController.text,
                          sexualityId: selectedSexualityId,
                          lookingFor: tabController.index,
                          relaitonshipStatus: selectedRelationshipStatus,
                          height: _heightRangeValue.toInt(),
                        )));
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: 1.vh,
                    ),
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
