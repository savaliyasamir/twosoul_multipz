
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/Network/bloc/contact_us/contact_us_bloc.dart';
import 'package:twosoul_multipz/Network/bloc/contact_us/contact_us_event.dart';
import 'package:twosoul_multipz/Network/model/request%20model/contact_us_request_model.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/base_screen.dart';
import 'package:twosoul_multipz/utils/widget/common_button.dart';
import 'package:twosoul_multipz/utils/widget/common_textField.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  List<String> type = ['user',"pressEnquiries","advertisingEnquiries"];
  String typeSelection = 'user';
  String mobileCode = "+91";
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(icBackButton, height: 2.vh),
              ),
              SizedBox(width: 20.vw,),
              CommonTextView(contactUs,
                  fontSize: 20.sp,
                  fontFamily: displayMedium,
                  color: Colors.white),
            ],
          ),
          SizedBox(height: 2.vh,),
         Expanded(
           child: SingleChildScrollView(
             physics: const BouncingScrollPhysics(
                 parent: AlwaysScrollableScrollPhysics()),
             child: SizedBox(
               height: 70.vh,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   ///name
                   CommonTextView(name,
                       fontSize: 14.sp,
                       color: Colors.white,
                       fontFamily: raidProRegular),
                   CommonTextField(hintText: name, controller: nameController),
                   ///email
                   CommonTextView("Email",
                       fontSize: 14.sp,
                       color: Colors.white,
                       fontFamily: raidProRegular),
                   CommonTextField(hintText: "Email", controller: emailController),
                   ///message
                   CommonTextView("Message",
                       fontSize: 14.sp,
                       color: Colors.white,
                       fontFamily: raidProRegular),
                   TextField(
                     maxLines: 4,
                     controller: messageController,
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
                   ///phone_number
                   CommonTextView("Phone Number",
                       fontSize: 14.sp,
                       color: Colors.white,
                       fontFamily: raidProRegular),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Container(
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                             color: darkGreyColor
                         ),
                         height: 6.vh,
                         width: 30.vw,
                         child: CountryCodePicker(
                           padding: EdgeInsets.zero,
                           dialogBackgroundColor: darkGreyColor,
                           onChanged: print,
                           initialSelection: 'IN',
                           favorite: const ['+91','IN'],
                           showCountryOnly: true,
                           showOnlyCountryWhenClosed: false,
                           alignLeft: true,
                           textStyle: const TextStyle(color: white50),
                           dialogTextStyle: const TextStyle(color: white50),
                           searchStyle: const TextStyle(color: white50),
                           closeIcon: const Icon(Icons.close,color: pinkColor,),
                           onInit: (code){
                             mobileCode = code!.code.toString();
                           },

                         ),
                       ),
                       SizedBox(
                         height: 6.vh,
                         width: 60.vw,
                         child:  CommonTextField(hintText: "Phone", controller: phoneNumberController,keyboardType: TextInputType.phone),
                       ),
                     ],
                   ),
                   ///contact_us type
                   Wrap(
                     children: type.map((e) => GestureDetector(
                       onTap: (){
                         setState((){
                           typeSelection = e;
                         });
                       },
                       child: Container(
                         height: 6.vh,
                         margin: EdgeInsets.all(2.vw),
                         decoration: BoxDecoration(
                             color: darkGreyColor,
                             borderRadius: BorderRadius.circular(10)
                         ),
                         padding: EdgeInsets.only(left: 4.vw,right: 4.vw,top: 1.5.vh),
                         child: CommonTextView(e,fontSize: 15.sp,fontFamily: displayMedium,color: typeSelection == e ? yellowColor : Colors.white,),
                       ),
                     )).toList(),
                   ),
                   SizedBox(height: 2.vh,),
                   ///submit button
                   CommonButton(onPressed: (){
                     context.read<ContactUsBloc>().add(FetchContactUsData(ContactUsRequestModel(
                       name: nameController.text,
                       email: emailController.text,
                       message: messageController.text,
                       mobile: int.parse(phoneNumberController.text),
                       mobileCode: mobileCode,
                       type: typeSelection == "user" ? 0 : typeSelection == "pressEnquiries" ? 1:2,
                     )));
                     Navigator.pop(context);
                   }, btnText: "Submit")
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
