import 'dart:io';


import 'package:editable_image/editable_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:tute_me/profilewidget.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tute_me/textfield.dart';
import 'package:tute_me/user.dart';
import 'package:tute_me/userprefernce.dart';


class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if(pickedfiles != null){
        imagefiles = pickedfiles;
        setState(() {
        });
      }else{
        print("No image is selected.");
      }
    }catch (e) {
      print("error while picking file.");
    }
  }
  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Pic Image From",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {pickImage(ImageSource.camera);

                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("CAMERA"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {pickImage(ImageSource.gallery);

                    },
                    icon: const Icon(Icons.image),
                    label: const Text("GALLERY"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                    label: const Text("CANCEL"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  File? pickedImage;
  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  User user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) =>
      Container(
        child: Builder(
          builder: (context) =>
              Scaffold(
                appBar: AppBar(
                    flexibleSpace: Container(
                      decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 80)],
                          gradient: LinearGradient(
                            colors: [Color(int.parse("0xFF00ACC1")),
                              Color(int.parse("0xFF64FFDA")),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,)
                      ),),
                    title: Text('Edit your information'),
                    centerTitle: true),
                body: ListView(
                  padding: EdgeInsets.all(10),
                  physics: BouncingScrollPhysics(),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.indigo, width: 1),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(10)
                        ),
                      ),
                      child: CircleAvatar(
                        radius:MediaQuery.of(context).size.width*0.2,
                        backgroundColor: Colors.transparent,

                        child: pickedImage != null
                            ? Image.file(
                          pickedImage!,
                          fit: BoxFit.fill,

                        )
                            : Image.network(
                          'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
                          width:170,
                          height: 170,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 5,
                      child: IconButton(
                        onPressed:imagePickerOption,
                        icon: const Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.blue,
                          size: 25,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                          onPressed: imagePickerOption,
                          icon: const Icon(Icons.add_a_photo_sharp),
                          label: const Text('UPLOAD IMAGE')),
                    ),

                    const SizedBox(height: 24),
                    TextFieldWidget(
                      label: 'Name',
                      text: user.name,
                      onChanged: (name) {},
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      label: 'Email ID',
                      text: user.email,
                      onChanged: (EmailID) {},
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      label: 'Subject',
                      text: user.Subject,

                      onChanged: (Subject) {},
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      label: 'Classes',
                      text: user.Classes,

                      onChanged: (Classes) {},
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      label: 'PhoneNumber',
                      text: user.PhoneNumber,

                      onChanged: (PhoneNumber) {},
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      label: 'Address',
                      text: user.Address,
                      maxLines: 5,
                      onChanged: (Address) {},
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      label: 'Fees',
                      text: user.Fees,

                      onChanged: (Fees) {},
                    ),
                    ElevatedButton(
                        onPressed: (){
                          openImages();
                        },
                        child: Text("Open Images")
                    ),

                    Divider(),
                    Text("Picked Files:"),
                    Divider(),

                    imagefiles != null?Wrap(
                      children: imagefiles!.map((imageone){
                        return Container(
                            child:Card(
                              child: Container(
                                height: 100, width:100,
                                child: Image.file(File(imageone.path)),
                              ),
                            )
                        );
                      }).toList(),
                    ):Container()//

                  ],

                ),
              ),

        ),

      );
}







