
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resize/resize.dart';
import 'package:twosoul_multipz/ui/enable_location_screen.dart';
import 'package:twosoul_multipz/utils/constants.dart';
import 'package:twosoul_multipz/utils/widget/base_screen.dart';
import 'package:twosoul_multipz/utils/widget/common_button.dart';
import 'package:twosoul_multipz/utils/widget/common_textview.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  List<File> imageList = [];


  Future getImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      imageList.add(File(image!.path));
      Navigator.pop(context);
    });
  }

  Future getGalleryImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imageList.add(File(image!.path));
      Navigator.pop(context);

    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
              child: Image.asset(icBackButton,height: 2.vh)),
          SizedBox(height: 7.vh,),
          Center(
            child: Image.asset(
              icTwoSoul,
              width: 20.vw,
            ),
          ),
          Center(child: CommonTextView(twoSoul,fontFamily: displayMedium,fontSize: 24.sp,color: Colors.white,)),
          SizedBox(height: 5.vh,),
          CommonTextView(uploadImages,fontSize: 18.sp,fontFamily: displayMedium,color: Colors.white),
          CommonTextView(uploadAMinimum,fontSize: 12.sp,fontFamily: displayMedium,color: white50),
          SizedBox(height: 2.vh,),
          Wrap(
            runSpacing: 3.vw,
            spacing: 3.vw,
            children: [
              GestureDetector(
                onTap: (){
                  if(imageList.length != 5) {
                    showDialog(
                        context: context, builder: (BuildContext context) {
                      return BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: AlertDialog(
                          backgroundColor: darkGreyColor,
                          title: CommonTextView(txtChooseOption, color: lightGreyColor,
                              fontFamily: raidProRegular,
                              fontSize: 18.sp),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                const Divider(height: 1, color: greyColor,),
                                ListTile(
                                  onTap: getGalleryImage,
                                  title: CommonTextView(txtGallery,color: lightGreyColor,fontSize: 15.sp,fontFamily: raidProRegular),
                                  leading: Icon(
                                    Icons.image, color: lightGreyColor,
                                    size: 6.vw,),
                                ),

                                const Divider(height: 1, color: greyColor,),
                                ListTile(
                                  onTap: getImage,
                                  title: CommonTextView(txtCamera,color: lightGreyColor,fontSize: 15.sp,fontFamily: raidProRegular),
                                  leading: Icon(
                                    Icons.camera, color: lightGreyColor,
                                    size: 6.vw,),
                                ),
                              ],
                            ),
                          ),),
                      );
                    });
                  }
                },
                child: Container(
                  height: 17.vh,
                  width: 28.vw,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: darkGreyColor,
                      border: Border.all(color: greyColor)
                  ),
                  child: Icon(Icons.add,color: yellowColor,size: 4.vh,),
                ),
              ),
              for ( var i in imageList ) Container(
                height: 17.vh,
                width: 28.vw,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: FileImage(i),
                      fit: BoxFit.fill
                    )
                ),
              ),

            ],
          ),
          SizedBox(height: 13.vh,),
          CommonButton(btnText: btnContinue,onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const EnableLocationScreen()));
          },),
        ],
      ),
    );
  }
}
