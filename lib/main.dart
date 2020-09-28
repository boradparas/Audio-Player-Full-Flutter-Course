import 'screens/audios_list_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/player_screen.dart';
import 'screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utilities/result_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool loginState;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  loginState = await _checkLogin();
  runApp(MyApp());
}

Future<bool> _checkLogin() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool isLoggedIn = preferences.getBool("isLoggedin") ?? false;
  return isLoggedIn;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ResultData(),
      child: MaterialApp(
        initialRoute: loginState ? CategoriesScreen.id : HomeScreen.id,
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          CategoriesScreen.id: (context) => CategoriesScreen(),
          AudiosListScreen.id: (context) => AudiosListScreen(),
          PlayerScreen.id: (context) => PlayerScreen(),
        },
      ),
    );
  }
}
