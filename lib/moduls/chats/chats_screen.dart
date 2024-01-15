import 'package:chat/layout/home_cubit/home_cubit.dart';
import 'package:chat/layout/home_cubit/home_states.dart';
import 'package:chat/model/user_model.dart';
import 'package:chat/moduls/chat_details/chat_details._screen.dart';
import 'package:chat/shared/components/components.dart';
import 'package:chat/shared/themes.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).users.length > 0,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                ItemChat(context, HomeCubit.get(context).users[index]),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsetsDirectional.only(start: 30.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            itemCount: HomeCubit.get(context).users.length,
          ),
          fallback: (context) => Center(
              child: CircularProgressIndicator(
            color: defoultColor,
          )),
        );
      },
    );
  }

  Widget ItemChat(context, UserModel model) => InkWell(
        onTap: () {
          navigatorTO(context, ChatDetailsScreen(usermodel: model));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                '${model.name}',
                style: TextStyle(height: 1.4),
              ),
            ],
          ),
        ),
      );
}
