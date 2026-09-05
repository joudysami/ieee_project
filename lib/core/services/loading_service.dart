
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..maskType = EasyLoadingMaskType.black
    ..backgroundColor = Colors.white60
    ..textColor = Colors.white60
    ..indicatorColor = Colors.brown
    ..userInteractions = false
    ..dismissOnTap = false;
}