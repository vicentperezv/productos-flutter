import 'package:flutter/material.dart';

class NotificationService{

  static GlobalKey<ScaffoldMessengerState> messagerKey = new GlobalKey<ScaffoldMessengerState>();

  static showSnackBar( String message){
    final snackBar = new SnackBar(
      content: Text( message, style: TextStyle(color: Colors.white, fontSize: 20) ),
    );
    messagerKey.currentState!.showSnackBar(snackBar);
  }
}