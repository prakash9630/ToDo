
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt= GetIt.instance;
Future<void> serviceLocator()async{
  var sp= await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sp);

}