import 'package:chat/app_cubit/app_states.dart';
import 'package:chat/layout/home_cubit/home_states.dart';
import 'package:chat/shared/network/local/cach_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeAppMode({bool? chageSaveDark}) {
    if (chageSaveDark != null) {
      isDark = chageSaveDark;
    } else {
      isDark = !isDark;
      CachHelper.putBoolCachDark(key: 'isDark', value: isDark).then((value) {
        emit(ChangeDarkModeState());
      });
    }
  }
}
