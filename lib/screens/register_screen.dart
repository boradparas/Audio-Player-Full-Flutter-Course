import 'package:audio_player_full_flutter_course/services/network_services.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = "register_screen";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _showSpinner = false;
  String _name;
  String _email;
  String _password;
  bool _validateNameInput = false;
  bool _validateEmailInput = false;
  bool _validatePasswordInput = false;
  final _textNameInput = TextEditingController();
  final _textEmailInput = TextEditingController();
  final _textPasswordInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                  child: TextField(
                    onChanged: (value) {
                      _name = value;
                    },
                    controller: _textNameInput,
                    decoration: new InputDecoration(
                        errorText:
                            _validateNameInput ? 'Value Can\'t Be Empty' : null,
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        hintText: "Enter Name",
                        labelText: 'Enter Name',
                        suffixStyle: const TextStyle(color: Colors.green)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      _email = value;
                    },
                    controller: _textEmailInput,
                    decoration: new InputDecoration(
                        errorText: _validateEmailInput
                            ? 'Value Can\'t Be Empty'
                            : null,
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
                              _textNameInput.text.isEmpty
                                  ? _validateNameInput = true
                                  : _validateNameInput = false;
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
                                  .getRegisterResponse(
                                      _name, _email, _password);
                              if (rs == "error") {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text("User already exist"),
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
                                Navigator.pop(context);
                              }
                            }
                          },
                          child: Text(
                            "Register",
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
      ),
    );
  }
}
