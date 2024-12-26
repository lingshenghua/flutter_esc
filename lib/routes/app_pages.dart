import 'package:flutter_esc/pages/main/main_page.dart';
import 'package:flutter_esc/routes/app_routes.dart';
import 'package:get/get.dart';

List<GetPage> appPages = [
  GetPage(name: RoutesEnum.mainPage.path, page: () => const MainPage()),
];
