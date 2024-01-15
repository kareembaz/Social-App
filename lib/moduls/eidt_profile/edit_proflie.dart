import 'dart:io';

import 'package:chat/layout/home_cubit/home_cubit.dart';
import 'package:chat/layout/home_cubit/home_states.dart';
import 'package:chat/shared/components/components.dart';
import 'package:chat/shared/icon_broken.dart';
import 'package:chat/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditProfile extends StatelessWidget {
  @override
  var nameControl = TextEditingController();
  var bioControl = TextEditingController();
  var phoneControl = TextEditingController();

  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = HomeCubit.get(context).usermodel;
          var profileImage = HomeCubit.get(context).ProfileImage;
          var coverImage = HomeCubit.get(context).CoverImage;

          nameControl.text = userModel!.name!;
          bioControl.text = userModel.bio!;
          phoneControl.text = userModel.phone!;

          return Scaffold(
            appBar: defoultAppBar(
              context: context,
              title: 'Edit Profile',
              actions: [
                TextButton(
                    onPressed: () {
                      HomeCubit.get(context).updateUser(
                        name: nameControl.text,
                        phone: phoneControl.text,
                        bio: bioControl.text,
                      );
                    },
                    child: Text(
                      'UPDATE',
                      style: TextStyle(color: defoultColor),
                    )),
                SizedBox(
                  width: 15.0,
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is userupDataLoadingState)
                      LinearProgressIndicator(color: defoultColor),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      height: 180.0,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 140.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0)),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: coverImage == null
                                          ? NetworkImage(
                                              '${userModel!.coverImage}')
                                          : FileImage(coverImage)
                                              as ImageProvider,
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      HomeCubit.get(context).getCoverImage();
                                    },
                                    icon: CircleAvatar(
                                        backgroundColor: defoultColor,
                                        radius: 20.0,
                                        child: Icon(
                                          IconBroken.Camera,
                                          size: 18.0,
                                          color: Colors.white,
                                        ))),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 64.0,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage('${userModel!.image}')
                                      : FileImage(profileImage)
                                          as ImageProvider,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    HomeCubit.get(context).getProfileImage();
                                  },
                                  icon: CircleAvatar(
                                      backgroundColor: defoultColor,
                                      radius: 20.0,
                                      child: Icon(
                                        IconBroken.Camera,
                                        size: 18.0,
                                        color: Colors.white,
                                      ))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    if (HomeCubit.get(context).ProfileImage != null ||
                        HomeCubit.get(context).CoverImage != null)
                      Row(
                        children: [
                          if (HomeCubit.get(context).ProfileImage != null)
                            Expanded(
                                child: Column(
                              children: [
                                defaultButton(
                                  text: 'UpLoad Profile Image',
                                  function: () {
                                    HomeCubit.get(context).uploadProfileImage(
                                      name: nameControl.text,
                                      phone: phoneControl.text,
                                      bio: bioControl.text,
                                    );
                                  },
                                ),
                                if (state is userupDataLoadingState)
                                  SizedBox(height: 4.0),
                                if (state is userupDataLoadingState)
                                  LinearProgressIndicator(color: defoultColor),
                              ],
                            )),
                          SizedBox(
                            width: 10.0,
                          ),
                          if (HomeCubit.get(context).CoverImage != null)
                            Expanded(
                                child: Column(
                              children: [
                                defaultButton(
                                  text: 'UpLoad Cover Image',
                                  function: () {
                                    HomeCubit.get(context).uploadCoverImage(
                                      name: nameControl.text,
                                      phone: phoneControl.text,
                                      bio: bioControl.text,
                                    );
                                  },
                                ),
                                if (state is userupDataLoadingState)
                                  SizedBox(height: 4.0),
                                if (state is userupDataLoadingState)
                                  LinearProgressIndicator(color: defoultColor),
                              ],
                            )),
                        ],
                      ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFromField(
                        context: context,
                        control: nameControl,
                        inputType: TextInputType.name,
                        textlabel: 'Name',
                        prefix: IconBroken.User,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'name must not be Empty';
                          }
                        }),
                    SizedBox(
                      height: 10.0,
                    ),
                    defaultFromField(
                      context: context,
                      control: bioControl,
                      inputType: TextInputType.text,
                      textlabel: 'Bio  ',
                      prefix: IconBroken.Info_Circle,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Bio must not be Empty';
                        }
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    defaultFromField(
                      context: context,
                      control: phoneControl,
                      inputType: TextInputType.phone,
                      textlabel: 'Phone',
                      prefix: IconBroken.Call,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Phone must not be Empty';
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
