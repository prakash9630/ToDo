
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/splash_screen/splash_screen.dart';
import 'package:todo/to_do/screen/to_do_screen.dart';

class AppStarter extends StatelessWidget {
   const AppStarter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 921),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
        title: 'ToDo',
        debugShowCheckedModeBanner: false,
          builder: FToastBuilder(),
          theme: ThemeData(
            brightness: Brightness.dark,
          ),
        home:  const SplashScreen(),
      );
    },
    );
  }
}
