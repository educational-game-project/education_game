import 'package:education_game/route/app_route_name.dart';
import 'package:education_game/views/pages/home/home_page.dart';
import 'package:get/route_manager.dart';

class AppRoute {
  static get pageRoute => [
        GetPage(
          name: AppRouteName.home,
          page: () => HomePage(),
        ),
      ];
}
