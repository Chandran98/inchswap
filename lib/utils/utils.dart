
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class Utils {

  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message, backgroundColor: Colors.black, textColor: Colors.white);
  }

  static snackbar(message, context) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.green, content: Text(message)));
  }}