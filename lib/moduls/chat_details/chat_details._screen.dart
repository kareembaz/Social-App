import 'package:chat/layout/home_cubit/home_cubit.dart';
import 'package:chat/layout/home_cubit/home_states.dart';
import 'package:chat/model/message_model.dart';
import 'package:chat/model/user_model.dart';
import 'package:chat/shared/icon_broken.dart';
import 'package:chat/shared/themes.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatelessWidget {
  var messageControll = TextEditingController();

  UserModel usermodel;
  ChatDetailsScreen({required this.usermodel});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        HomeCubit.get(context).getMessages(reciverId: usermodel.uId);
        return BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        '${usermodel.image}',
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text('${usermodel.name}'),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: HomeCubit.get(context).messages.length >= 0,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message =
                                HomeCubit.get(context).messages[index];
                            if (HomeCubit.get(context).usermodel!.uId ==
                                message.sendId) return buildMyMessags(message);
                            return buildMessage(message);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 15.0,
                          ),
                          itemCount: HomeCubit.get(context).messages.length,
                        ),
                      ),
                      Container(
                        // height: 50.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadiusDirectional.circular(10.0),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: messageControll,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '   Type your Message here .....',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                    )),
                              ),
                            ),
                            Container(
                              height: 60.0,
                              width: 60.0,
                              decoration: BoxDecoration(
                                  color: defoultColor,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: MaterialButton(
                                  minWidth: 1.0,
                                  onPressed: () {
                                    HomeCubit.get(context).sendMessage(
                                      reciverId: usermodel.uId,
                                      dateTime: DateTime.now().toString(),
                                      Text: messageControll.text,
                                    );
                                  },
                                  child: Icon(
                                    IconBroken.Send,
                                    size: 16.0,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) => Center(
                    child: CircularProgressIndicator(
                  color: defoultColor,
                )),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel messagemodel) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0,
          ),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              bottomEnd: Radius.circular(10.0),
            ),
          ),
          child: Text('${messagemodel.text}'),
        ),
      );

  Widget buildMyMessags(MessageModel messagemodel) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0,
          ),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.2),
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              bottomStart: Radius.circular(10.0),
            ),
          ),
          child: Text('${messagemodel.text}'),
        ),
      );
}
