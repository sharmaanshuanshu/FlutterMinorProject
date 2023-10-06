import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
successMessage(dynamic context,String message){
    return Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      gravity: ToastGravity.TOP,
    );
}
errorMessage(dynamic context,String message){
  return Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    gravity: ToastGravity.TOP,
  );
}