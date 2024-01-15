import 'package:chat/layout/home_screen.dart';
import 'package:chat/moduls/login/login_screen.dart';
import 'package:chat/moduls/registor/cubit/registor_cubit.dart';
import 'package:chat/moduls/registor/cubit/registor_state.dart';
import 'package:chat/shared/components/components.dart';
import 'package:chat/shared/themes.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistorScreen extends StatelessWidget {
  var emailControll = TextEditingController();
  var passwordControll = TextEditingController();
  var nameControll = TextEditingController();
  var phoneControll = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistorCubit(),
      child: BlocConsumer<RegistorCubit, RegistorStates>(
        listener: (context, state) {
          if (state is CreateUserSccessState) {
            navigatorTOAndEnd(context, LoginScreen());
          }
        },
        builder: (context, state) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[200],
            ),
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/meda1.jpg'),
                      fit: BoxFit.cover)),
              child: Center(
                  child: SingleChildScrollView(
                      child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REGISTER',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontSize: 40.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        'Register now  to Communication to Friends !!',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: nameControll,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' THe name must not be Empty !!';
                          }
                          return null;
                        },
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                          hintText: ' User Name ',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: emailControll,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' THe Email must not be Empty !!';
                          }
                          return null;
                        },
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email_outlined),
                          hintText: '  Email address ',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: passwordControll,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' THe Password is more short !!';
                          }
                          return null;
                        },
                        obscureText: RegistorCubit.get(context).ispassWord,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          hoverColor: defoultColor,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              RegistorCubit.get(context)
                                  .changePasswordVisility();
                            },
                            icon: Icon(RegistorCubit.get(context).suffic),
                          ),
                          hintText: 'Password Address',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        controller: phoneControll,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' THe Phone must not be Empty !!';
                          }
                          return null;
                        },
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
                          hintText: ' Phone ',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! registorLoadingState,
                        builder: (context) => Container(
                          height: 50.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: defoultColor,
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                RegistorCubit.get(context).userregistor(
                                  email: emailControll.text,
                                  password: passwordControll.text,
                                  name: nameControll.text,
                                  phone: phoneControll.text,
                                );
                              }
                            },
                            child: Text('REGISTER',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white)),
                          ),
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ))),
            )),
      ),
    );
    ;
  }
}
