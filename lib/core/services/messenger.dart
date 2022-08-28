import 'package:flutter/material.dart';

class Messenger {
  Messenger._();


  static void showSuccessSnackBar (BuildContext context, {String? message}){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message ?? "Success"),
          margin:  const EdgeInsets.all(25),
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFF00704A),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        )
    );
  }


  static void showFailedSnackBar (BuildContext context, {String? message}){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message != null? message.length > 40 ? "Failed" : message : "Failed"),
          margin:  const EdgeInsets.all(25),
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFFB02D29),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        )
    );
  }
}