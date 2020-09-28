import 'package:flutter/cupertino.dart';

class ResultData extends ChangeNotifier {
  static String _userId;

  String get userId {
    return _userId;
  }

  void addUserId(var uId) {
    _userId = uId;
    notifyListeners();
  }

  void clearResultData() {
    _userId = null;
    notifyListeners();
  }
}
