import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nas_academy/core/modules/exceptions/server_error.dart';
import 'package:nas_academy/core/utils/color_plate.dart';


class ExceptionHandler {
  ExceptionHandler._();


  static void handleError (error, BuildContext context)async{
    if(error is ServerError){
      showFlushBar(
          title: error.title,
          context: context,
          message: error.body
      );
      return;
    }else if ((await Connectivity().checkConnectivity()) == ConnectivityResult.none){
      showFlushBar(
        title: "No Internet Connection",
        context: context,
        icon: const Icon(Icons.wifi_off_outlined, color: Colors.amber,),
        message: "Please, check your internet connection and try again",
      );
      return;
    }else if (error is SocketException){
      if(error.osError != null){
        showFlushBar(
          title: "OS Error : ${error.osError!.errorCode}",
          context: context,
          icon: const Icon(Icons.wifi_off_outlined, color: Colors.amber,),
          message: error.osError!.message,
        );
      }
      return;
    }else {
      // showFlushBar(message: error.toString(), context: context);
      return;
    }
  }





  static void showFlushBar(
      { required BuildContext context,
        String? title,
        String? message,
        int? duration,
        Icon? icon,
        bool? hasTitle
      }){
    Flushbar(
      duration: Duration(seconds: duration ?? 5),
      icon: icon ?? const Icon(LineIcons.exclamationCircle, color: ColorPlate.yellow70, size: 35,),
      barBlur: 8,
      routeBlur: 8,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      title: hasTitle != false? title ?? "Something went wrong" : null,
      message: message ?? "try again later",
      backgroundColor: Colors.white,
      borderRadius: BorderRadius.circular(5),
      padding: const EdgeInsets.only(left: 30, top: 15, right: 15, bottom: 15),
      titleColor: Colors.black,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      messageColor: Colors.black,
      leftBarIndicatorColor: ColorPlate.yellow70,
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
      animationDuration: const Duration(milliseconds: 900),
      forwardAnimationCurve: Curves.easeOutCirc,
    ).show(context);
  }



}