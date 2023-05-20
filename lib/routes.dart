import 'package:admin_helper/pages/home_page.dart';
import 'package:admin_helper/pages/welcome_user_page.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class RouterHelper {
  static const welcome = '/welcome';
  static const home = '/';
  static const login = '/login';
  static const adminLogin = '/adminLogin';
  static const work = '/work';
  static const rowTasks = '/rowTasks';
  static const greenhouseTasks = '/greenhouseTasks';

  static List<GetPage> routes = [
    GetPage(
        name: welcome,
        page: () => const WelcomeUserPage(),
        curve: Curves.easeIn,
        transition: Transition.fadeIn,
        transitionDuration: const Duration(seconds: 2)),
    GetPage(
        name: home,
        page: () => const HomePage(),
        curve: Curves.easeIn,
        transition: Transition.topLevel,
        transitionDuration: const Duration(milliseconds: 1500)),
  ];
}
