import 'package:chat/moduls/login/login_screen.dart';
import 'package:chat/shared/icon_broken.dart';
import 'package:chat/shared/network/local/cach_helper.dart';
import 'package:chat/shared/themes.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

void Signout(context) {
  CachHelper.removeData(key: 'uId');
  navigatorTOAndEnd(context, LoginScreen());
}

Widget defaultButton({
  double width = double.infinity,
  Color color = Colors.blue,
  bool isUppercase = true,
  double radis = 0.0,
  required String text,
  required Function function,
}) =>
    Container(
        width: width,
        height: 40.0,
        child: MaterialButton(
          onPressed: () {
            function();
          },
          child: Text(
            isUppercase ? text.toUpperCase() : text,
            style: TextStyle(color: Colors.white, fontSize: 10.0),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: defoultColor,
        ));

Widget defaultFromField({
  required TextEditingController control,
  required TextInputType inputType,
  required String textlabel,
  required IconData prefix,
  Function(dynamic value)? onFieldSubmitted,
  Function(dynamic value)? onChanged,
  required String? Function(dynamic value) validator,
  IconData? suffix,
  bool showPassword = false,
  Function? suffixPressed,
  Function()? ispassWord,
  Function()? onTap,
  bool showKeyborad = true,
  context,
}) =>
    TextFormField(
      keyboardType: inputType,
      controller: control,
      obscureText: showPassword,

      ///onFieldSubmitted --> print String when ypu end the text
      // onFieldSubmitted: (value) => print(value),
      onFieldSubmitted: onFieldSubmitted,

      // /// onChanged --> print String  first on first
      // onChanged: (value) => print(value),
      onChanged: onChanged,
      validator: validator,
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     return 'email must not be empty';
      //   }
      //   return null;
      // },

      //  ontap فتح الساعه لكي تختار منها الساعه بدل ما تكتب الوقت بايدكوهذه مسوله من ال
      onTap: onTap,
      enabled: showKeyborad,
      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
      decoration: InputDecoration(
        //hintText:'Email  Address',
        labelText: textlabel,
        // labelStyle: TextStyle(color: defoultColor, fontSize: 18.0),
        // contentPadding: EdgeInsets.all(15),
        // prefixIconColor: defoultColor,

        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: ispassWord,
              )
            : null,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.blue, width: 2),
        // ),
      ),
    );

Future navigatorTO(context, Widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Widget,
    ));
//  عندما تنتقل للصفحه هذه يتم محو كل الفات  ولا يمكن العوده منها
Future navigatorTOAndEnd(context, Widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
      (Route<dynamic> route) => false,
    );

//   enum وبعد كدا بنحدد اللون عن طريق  toastهنا بنعمل
void shoowtoast({
  required String message,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorToastStates(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCEESS, ERROR, WARNING }

Color ColorToastStates(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCEESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}

PreferredSizeWidget defoultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(IconBroken.Arrow___Left_2)),
      title: Text(title!),
      titleSpacing: 0.0,
      actions: actions,
    );
