import 'package:chat/app_cubit/app_cubit.dart';
import 'package:chat/layout/home_cubit/home_cubit.dart';
import 'package:chat/layout/home_cubit/home_states.dart';
import 'package:chat/moduls/new_post/new_post.dart';
import 'package:chat/shared/components/components.dart';
import 'package:chat/shared/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(listener: (context, state) {
      if (state is AddPostState) {
        navigatorTO(
          context,
          NewPost(),
        );
      }
    }, builder: (context, state) {
      var cubit = HomeCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          title: Text(cubit.title[cubit.currentIndex]),
          actions: [
            IconButton(
                onPressed: () {
                  AppCubit.get(context).changeAppMode();
                },
                icon: Icon(Icons.dark_mode_outlined)),
            IconButton(onPressed: () {}, icon: Icon(IconBroken.Notification)),
            IconButton(onPressed: () {}, icon: Icon(IconBroken.Search)),
          ],
        ),
        body: cubit.Screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.currentIndex,
          onTap: (index) {
            cubit.chanageBottonNav(index);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(IconBroken.Home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(IconBroken.Chat), label: 'Chats'),
            BottomNavigationBarItem(
                icon: Icon(IconBroken.Paper_Upload), label: 'Post'),
            BottomNavigationBarItem(
                icon: Icon(IconBroken.Location), label: 'Users'),
            BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting), label: 'setting'),
          ],
        ),
      );
    });
  }
}
