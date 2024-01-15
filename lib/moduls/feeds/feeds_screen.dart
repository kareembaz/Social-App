import 'package:chat/layout/home_cubit/home_cubit.dart';
import 'package:chat/layout/home_cubit/home_states.dart';
import 'package:chat/model/post_model.dart';
import 'package:chat/shared/icon_broken.dart';
import 'package:chat/shared/themes.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).posts.length > 0 &&
              HomeCubit.get(context).usermodel != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5.0,
                  margin: EdgeInsets.all(8.0),
                  child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          image: NetworkImage(
                            'https://img.freepik.com/free-photo/front-view-sad-girl-being-bullied_23-2149748403.jpg?w=1380&t=st=1704829252~exp=1704829852~hmac=d09a7f27bceb81887c4eb9ef8be6641a927d7d888fbc8cea0a7372aca352c6ff',
                          ),
                          fit: BoxFit.cover,
                          height: 200.0,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Conmmuncation with friends',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ]),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildItemPost(
                      HomeCubit.get(context).posts[index], context, index),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10.0,
                  ),
                  itemCount: HomeCubit.get(context).posts.length,
                )
              ],
            ),
          ),
          fallback: (context) => Center(
              child: CircularProgressIndicator(
            color: defoultColor,
          )),
        );
      },
    );
  }

  Widget buildItemPost(postModel model, context, index) => Card(
        // color: Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage('${model.image}'),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: defoultColor,
                              size: 16.0,
                            )
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: Colors.grey[400], height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        size: 16.0,
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${model.text}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 10.0, top: 5.0),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 5.0),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //                 minWidth: 1.0,
              //                 padding: EdgeInsets.zero,
              //                 onPressed: () {},
              //                 child: Text(
              //                   '#software',
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .caption!
              //                       .copyWith(color: defoultColor),
              //                 )),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 5.0),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //                 minWidth: 1.0,
              //                 padding: EdgeInsets.zero,
              //                 onPressed: () {},
              //                 child: Text(
              //                   '#software_only',
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .caption!
              //                       .copyWith(color: defoultColor),
              //                 )),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 5.0),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //                 minWidth: 1.0,
              //                 padding: EdgeInsets.zero,
              //                 onPressed: () {},
              //                 child: Text(
              //                   '#System',
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .caption!
              //                       .copyWith(color: defoultColor),
              //                 )),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 5.0),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //                 minWidth: 1.0,
              //                 padding: EdgeInsets.zero,
              //                 onPressed: () {},
              //                 child: Text(
              //                   '#Flutter_Developer',
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .caption!
              //                       .copyWith(color: defoultColor),
              //                 )),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                  ),
                  child: Container(
                    height: 140.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          '${model.postImage}',
                        ),
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                size: 16.0,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '${HomeCubit.get(context).likes[index]}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                IconBroken.Chat,
                                size: 16.0,
                                color: Colors.orange,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '${HomeCubit.get(context).comments[index]}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        HomeCubit.get(context)
                            .commentpost(HomeCubit.get(context).postId[index]);
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18.0,
                            backgroundImage: NetworkImage(
                                '${HomeCubit.get(context).usermodel!.image}'),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Write a comment .......',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.grey[400], height: 1.4),
                          ),
                          // Expanded(
                          //   child: TextFormField(
                          //     onFieldSubmitted: (value) {
                          //       // HomeCubit.get(context).commentpost(
                          //       //     HomeCubit.get(context).postId[index],
                          //       //     commentControll.text);
                          //     },
                          //     controller:
                          //         HomeCubit.get(context).commentControll,
                          //     // autocorrect: true,
                          //     decoration: InputDecoration(
                          //       hintText: 'Write the Comment ....',
                          //       hintStyle: TextStyle(
                          //           color: Colors.grey, fontSize: 12.0),
                          //       border: InputBorder.none,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      HomeCubit.get(context)
                          .likePost(HomeCubit.get(context).postId[index]);
                    },
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 16.0,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
