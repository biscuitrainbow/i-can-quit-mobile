import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UiUtil {
  static void showMessage([String message = '']) {
    Fluttertoast.showToast(
    
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 5,
    );
  }
}
