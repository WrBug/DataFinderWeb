import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ToastUtils {
  static void show(BuildContext context, String message) {
    Toast.show(message, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
  }

  static void showLong(BuildContext context, String message) {
    Toast.show(message, context,
        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
  }
}
