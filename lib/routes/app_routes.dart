import 'package:flutter_esc/pages/main/main_bindings.dart';
import 'package:flutter_esc/pages/main/main_page.dart';
import 'package:flutter_esc/pages/page404.dart';
import 'package:get/get.dart';

enum RoutesEnum {
  notFound("/notFound"),
  mainPage("/mainPage");

  const RoutesEnum(this.path);

  final String path;
}

final unknownRoute = GetPage(name: RoutesEnum.notFound.path, page: () => const Page404());

List<GetPage> appPages = [
  /// 主页面
  GetPage(
    name: RoutesEnum.mainPage.path,
    page: () => const MainPage(),
    binding: MainBindings(),
  ),
];
