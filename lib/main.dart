import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_esc/app.dart';
import 'package:get/get.dart';

void main() {
  if (GetPlatform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(const EscApp());
}
