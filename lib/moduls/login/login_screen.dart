import 'package:chat/layout/home_screen.dart';
import 'package:chat/moduls/login/cubit/login_cubit.dart';
import 'package:chat/moduls/login/cubit/login_state.dart';
import 'package:chat/moduls/registor/registor_screen.dart';
import 'package:chat/shared/components/components.dart';
import 'package:chat/shared/network/local/cach_helper.dart';
import 'package:chat/shared/themes.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  var emailControll = TextEditingController();
  var passwordControll = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginSates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            shoowtoast(message: state.error, state: ToastStates.ERROR);
          }
          if (state is LoginISuccessState) {
            CachHelper.saveData(key: 'uId', value: state.UId).then((value) {
              navigatorTOAndEnd(context, HomeScreen());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
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
                            'Login',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'login now  to browse Communication to Friends !!',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            controller: emailControll,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' THe email must not be Empty !!';
                              }
                              return null;
                            },
                            style: Theme.of(context).textTheme.bodyMedium,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.email_outlined),
                                hintText: 'Email Address',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            controller: passwordControll,
                            keyboardType: TextInputType.visiblePassword,
                            onFieldSubmitted: (value) {
                              if (formKey.currentState!.validate()) {
                                // LoginCubit.get(context).userLogin(
                                //   email: emailControll.text,
                                //   password: passwordControll.text,
                                // );
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' THe Password is more short !!';
                              }
                              return null;
                            },
                            obscureText: LoginCubit.get(context).ispassWord,
                            style: Theme.of(context).textTheme.bodyMedium,
                            decoration: InputDecoration(
                                hoverColor: defoultColor,
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    LoginCubit.get(context)
                                        .changePasswordVisility();
                                  },
                                  icon: Icon(LoginCubit.get(context).suffic),
                                ),
                                hintText: 'Email Address',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
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
                                    LoginCubit.get(context).userLogin(
                                      email: emailControll.text,
                                      password: passwordControll.text,
                                    );
                                  }
                                },
                                child: Text('LOGIN',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.white)),
                              ),
                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have an account ? '),
                              TextButton(
                                onPressed: () {
                                  navigatorTO(context, RegistorScreen());
                                },
                                child: Text('REGISTOR NOW ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: defoultColor)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
