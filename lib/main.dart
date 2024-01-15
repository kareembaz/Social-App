import 'package:chat/app_cubit/app_cubit.dart';
import 'package:chat/app_cubit/app_states.dart';
import 'package:chat/firebase_options.dart';
import 'package:chat/layout/bloc_opserver.dart';
import 'package:chat/layout/home_cubit/home_cubit.dart';
import 'package:chat/layout/home_screen.dart';
import 'package:chat/moduls/login/login_screen.dart';
import 'package:chat/shared/components/constants.dart';
import 'package:chat/shared/network/local/cach_helper.dart';
import 'package:chat/shared/network/remote/dio_helper.dart';
import 'package:chat/shared/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var tokan = await FirebaseMessaging.instance.getToken();
  // print(tokan);
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    // print(event.data.toString());
  });
  //   بيتاكد ان كل ال  حاجه خلصصت قبل ما يرن الابليكشن
  DioHelper.init();
  await CachHelper.init();
  uId = CachHelper.getData(key: 'uId');
  print(uId);
  Widget widget;
  if (uId != null) {
    widget = HomeScreen();
  } else {
    widget = LoginScreen();
  }

  Bloc.observer = MyBlocObserver();

  bool isDark = CachHelper.getBoolCachDark(key: 'isDark')!;
  // bool isDark = false;
  print(isDark);
  runApp(MyApp(
    startWidget: widget,
    isDark: isDark!,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  final bool isDark;
  MyApp({
    required this.startWidget,
    required this.isDark,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..changeAppMode(chageSaveDark: isDark),
        ),
        BlocProvider(
            create: (context) => HomeCubit()
              ..getUserData()
              ..getPosts()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          title: 'Social app',
          theme: LightTheme,
          darkTheme: DartTheme,
          themeMode:
              AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: startWidget,
          ),
        ),
      ),
    );
  }
}
