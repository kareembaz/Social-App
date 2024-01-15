import 'dart:io';
import 'dart:math';

import 'package:chat/layout/home_cubit/home_states.dart';
import 'package:chat/model/message_model.dart';
import 'package:chat/model/post_model.dart';
import 'package:chat/model/user_model.dart';
import 'package:chat/moduls/chats/chats_screen.dart';
import 'package:chat/moduls/feeds/feeds_screen.dart';
import 'package:chat/moduls/new_post/new_post.dart';
import 'package:chat/moduls/settings/setting_screen.dart';
import 'package:chat/moduls/users/user_screen.dart';
import 'package:chat/shared/components/constants.dart';
import 'package:chat/shared/network/local/cach_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);

  UserModel? usermodel;
  void getUserData() {
    emit(HomeGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      // print(value.data());
      var d = value.data();
      usermodel = UserModel.fromJson(d!);
      // print(d);
      emit(HomeGetUserSucessState());
    }).catchError((error) {
      emit(HomeGetUserErrorState(error));
    });
  }

  int currentIndex = 0;

  List<Widget> Screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPost(),
    UserScreen(),
    SettingScreen(),
  ];
  List<String> title = [
    'Home',
    'Chats',
    'Posts',
    'Users',
    'Setting',
  ];

  void chanageBottonNav(int index) {
    if (index == 1) getUsers();
    if (index == 2) {
      emit(AddPostState());
    } else {
      currentIndex = index;
      emit(ChangeButtonNavState());
    }
  }

  //////////////////////////////
  /// select image in phone
  File? ProfileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Image.file(_image!);

      ProfileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(ProfileProfileImageSuccessState());
    } else {
      print('No image selected . ');
      emit(ProfileProfileImageSuccessState());
    }
  }

  File? CoverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Image.file(_image!);

      CoverImage = File(pickedFile.path);
      emit(ProfileCoverImageSuccessState());
    } else {
      print('No image selected . ');
      emit(ProfileCoverImageErrorState());
    }
  }

// //////////////////////////// store in fireStore
  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(userupDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(ProfileImage!.path).pathSegments.last}')
        .putFile(ProfileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );

        // emit(uplaodingProfileImageSuccessState());
      }).catchError((error) {
        emit(uploadingProfileImageErrorState());
      });
    }).catchError((error) {
      emit(uploadingProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(userupDataLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(CoverImage!.path).pathSegments.last}')
        .putFile(CoverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          coverImage: value,
        );
        // emit(uplaodingCoverImageSuccessState());
      }).catchError((error) {
        emit(uploadingCoverImageErrorState());
      });
    }).catchError((error) {
      emit(uploadingCoverImageErrorState());
    });
  }

  // void upImagesUser(
  //     {required String name, required String phone, required String bio}) {
  //   if (CoverImage != null) {
  //     uploadCoverImage();
  //   } else if (ProfileImage != null) {
  //     uploadProfileImage();
  //   } else if (CoverImage != null && ProfileImage != null) {
  //   } else {
  //     updateUser(name: name, phone: phone, bio: bio);
  //   }
  // }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? coverImage,
  }) {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: usermodel!.email,
      uId: usermodel!.uId,
      isEmailVerified: usermodel!.isEmailVerified,
      coverImage: coverImage ?? usermodel!.coverImage,
      image: image ?? usermodel!.image,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
      emit(userupDataSuccessState());
    }).catchError((error) {
      emit(userupDataErrorState());
    });
  }

//////create posts /////////////////////////////////////////////////////

  File? PostImage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Image.file(_image!);

      PostImage = File(pickedFile.path);
      emit(postImageSuccessState());
    } else {
      print('No image selected . ');
      emit(postImageErrorState());
    }
  }

  void removePostImage() {
    PostImage = null;
    emit(removePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(CreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(PostImage!.path).pathSegments.last}')
        .putFile(PostImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        CreatePost(dateTime: dateTime, text: text, postImage: value);
        emit(CreatePostSuccessState());
      }).catchError((error) {
        emit(CreatePostErrorState());
      });
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  void CreatePost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());
    postModel model = postModel(
      name: usermodel!.name,
      uId: usermodel!.uId,
      image: usermodel!.image,
      dateTime: dateTime,
      postImage: postImage ?? '',
      text: text,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

///// get the posts
  List<postModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];
  List<int> comments = [];
  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(postModel.fromJson(element.data()));
        }).catchError((error) {});
        element.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length);
        }).catchError((error) {});
      });
    }).catchError((error) {
      emit(GetPostErrorState(error));
    });
  }

  void likePost(String posttId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(posttId)
        .collection('likes')
        .doc(usermodel!.uId)
        .set({'like': true}).then((value) {
      emit(likePostSucessState());
    }).catchError((error) {
      emit(likePostErrorState(error.toString()));
    });
  }

  /// comments
  void commentpost(String posttId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(posttId)
        .collection('comments')
        .doc(usermodel!.uId)
        .set({'comment': true}).then((value) {
      emit(commentPostSucessState());
    }).catchError((error) {
      emit(commentPostErrorState(error.toString()));
    });
  }

  List<UserModel> users = [];
  void getUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != usermodel!.uId)
            users.add(UserModel.fromJson(element.data()));
          emit(HomeGetAllUserSucessState());
        });
      }).catchError((error) {
        print(error.toString());
        emit(HomeGetAllUserErrorState(error));
      });
  }

// send meassage
  var commentControll = TextEditingController();

  void sendMessage({
    required String? reciverId,
    required String? dateTime,
    required String? Text,
  }) {
    MessageModel messageModel = MessageModel(
      sendId: usermodel!.uId,
      dateTime: dateTime,
      reseiverId: reciverId,
      text: Text,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel!.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSucessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(reciverId)
        .collection('chats')
        .doc(usermodel!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSucessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String? reciverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel!.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessageSucessState());
    });
  }
}
