import 'package:audio_player_full_flutter_course/screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'register_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = "home_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              color: Colors.green,
              child: Text("Login"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, RegisterScreen.id);
              },
              color: Colors.blue,
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
