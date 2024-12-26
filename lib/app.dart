import 'package:flutter/material.dart';
import 'package:flutter_esc/routes/app_routes.dart';
import 'package:get/get.dart';

class EscApp extends StatefulWidget {
  const EscApp({super.key});

  @override
  State<StatefulWidget> createState() => _EscAppState();
}

class _EscAppState extends State<EscApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      getPages: appPages,
      initialRoute: RoutesEnum.mainPage.path,
      unknownRoute: unknownRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
