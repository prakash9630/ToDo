import 'package:flutter/material.dart';
import 'package:todo/const/app_asset.dart';
import 'package:todo/const/app_colors.dart';
import 'package:todo/to_do/screen/to_do_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initApp();
  }

  initApp() async {
   Future.delayed(const Duration(seconds: 2)).then((value){
     Navigator.pushReplacement(
       context,
       MaterialPageRoute(builder: (context) => const ToDoScreen()),
     );
   });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("ToDo App",style: TextStyle(fontSize: 50,color: AppColors.white),),
      ),
    );
  }
}
