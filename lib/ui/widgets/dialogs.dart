//flushbar
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showFlush(BuildContext context, String message) {
  Flushbar(
    message: message,
    duration: Duration(seconds: 7),
    flushbarStyle: FlushbarStyle.GROUNDED,
  ).show(context);
}
