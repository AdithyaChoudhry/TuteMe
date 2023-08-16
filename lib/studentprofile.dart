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


class EditProfilePage2 extends StatefulWidget {
  @override
  _EditProfilePageState2 createState() => _EditProfilePageState2();
}

class _EditProfilePageState2 extends State<EditProfilePage2> {File? pickedImage;
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


                  ],

                ),
              ),

        ),

      );
}







