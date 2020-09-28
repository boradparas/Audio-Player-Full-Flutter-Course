import 'package:audio_player_full_flutter_course/screens/categories_screen.dart';
import 'package:audio_player_full_flutter_course/services/network_services.dart';
import 'package:audio_player_full_flutter_course/utilities/result_data.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showSpinner = false;
  String _email;
  String _password;
  bool _validateEmailInput = false;
  bool _validatePasswordInput = false;
  final _textEmailInput = TextEditingController();
  final _textPasswordInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    _email = value;
                  },
                  controller: _textEmailInput,
                  decoration: new InputDecoration(
                      errorText:
                          _validateEmailInput ? 'Value Can\'t Be Empty' : null,
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      hintText: "Enter Email",
                      labelText: 'Enter Email',
                      suffixStyle: const TextStyle(color: Colors.green)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                child: TextField(
                  obscureText: true,
                  onChanged: (value) {
                    _password = value;
                  },
                  controller: _textPasswordInput,
                  decoration: new InputDecoration(
                      errorText: _validatePasswordInput
                          ? 'Value Can\'t Be Empty'
                          : null,
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      hintText: 'Enter Password',
                      labelText: 'Enter Password',
                      suffixStyle: const TextStyle(color: Colors.green)),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                      child: FlatButton(
                        onPressed: () async {
                          setState(() {
                            _textEmailInput.text.isEmpty
                                ? _validateEmailInput = true
                                : _validateEmailInput = false;
                            _textPasswordInput.text.isEmpty
                                ? _validatePasswordInput = true
                                : _validatePasswordInput = false;
                          });
                          if (_textEmailInput.text.isEmpty ||
                              _textPasswordInput.text.isEmpty) {
                            return;
                          } else {
                            setState(() {
                              _showSpinner = true;
                            });
                            var rs = await NetworkServices()
                                .getLoginResponse(_email, _password);

                            if (rs == "error") {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text("User Not found please Register"),
                                  actions: [
                                    FlatButton(
                                      child: Text("Okay"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          _showSpinner = false;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              var uId = rs;
                              setState(() {
                                _showSpinner = false;
                              });
                              Provider.of<ResultData>(context, listen: false)
                                  .addUserId(uId);
//                              ResultData.userId = uId;
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              pref.setBool("isLoggedin", true);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CategoriesScreen(),
                                  ),
                                  (routes) => false);
                            }
                          }
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                        color: Colors.lightBlue[500],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
