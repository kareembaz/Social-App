import 'package:chat/layout/home_cubit/home_cubit.dart';
import 'package:chat/layout/home_cubit/home_states.dart';
import 'package:chat/moduls/eidt_profile/edit_proflie.dart';
import 'package:chat/moduls/login/login_screen.dart';
import 'package:chat/shared/components/components.dart';
import 'package:chat/shared/icon_broken.dart';
import 'package:chat/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = HomeCubit.get(context).usermodel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 180.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0)),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              '${userModel!.coverImage}',
                            ),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64.0,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage('${userModel!.image}'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '${userModel!.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                '${userModel!.bio}',
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '350',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              'Photo',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '5K',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              'Followrs',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '300',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              'Followings',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                    child: Text(
                      'Add Photos',
                      style: TextStyle(color: defoultColor),
                    ),
                    onPressed: () {},
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    child: Icon(
                      IconBroken.Edit,
                      color: defoultColor,
                    ),
                    onPressed: () {
                      navigatorTO(context, EditProfile());
                    },
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                    child: Text(
                      'LogOut',
                      style: TextStyle(color: defoultColor),
                    ),
                    onPressed: () {
                      Signout(context);
                    },
                  )),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
