import 'package:chat/layout/home_cubit/home_cubit.dart';
import 'package:chat/layout/home_cubit/home_states.dart';
import 'package:chat/layout/home_screen.dart';
import 'package:chat/moduls/feeds/feeds_screen.dart';
import 'package:chat/shared/components/components.dart';
import 'package:chat/shared/icon_broken.dart';
import 'package:chat/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPost extends StatelessWidget {
  var textControll = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var postImage = HomeCubit.get(context).PostImage;
        return Scaffold(
          appBar: defoultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              TextButton(
                onPressed: () {
                  var now = DateTime.now();
                  if (HomeCubit.get(context).PostImage == null) {
                    HomeCubit.get(context).CreatePost(
                        dateTime: now.toString(), text: textControll.text);
                  } else {
                    HomeCubit.get(context).uploadPostImage(
                        dateTime: now.toString(), text: textControll.text);
                  }
                },
                child: Text(
                  'POST',
                  style: TextStyle(color: defoultColor),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is CreatePostLoadingState)
                  LinearProgressIndicator(
                    color: defoultColor,
                  ),
                if (state is CreatePostLoadingState)
                  SizedBox(
                    height: 10.0,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          '${HomeCubit.get(context).usermodel!.image}'),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      '${HomeCubit.get(context).usermodel!.name}',
                      style: TextStyle(height: 1.4),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textControll,
                    autocorrect: true,
                    decoration: InputDecoration(
                      hintText: 'What is on your mind ....',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (HomeCubit.get(context).PostImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(postImage!),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            HomeCubit.get(context).removePostImage();
                          },
                          icon: CircleAvatar(
                              backgroundColor: defoultColor,
                              radius: 20.0,
                              child: Icon(
                                Icons.close,
                                size: 18.0,
                                color: Colors.white,
                              ))),
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          HomeCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconBroken.Image, color: defoultColor),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'add Photo',
                              style: TextStyle(color: defoultColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '# tags',
                          style: TextStyle(color: defoultColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
