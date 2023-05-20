import 'dart:math';
import 'package:admin_helper/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeUserPage extends StatefulWidget {
  const WelcomeUserPage({Key? key}) : super(key: key);

  @override
  State<WelcomeUserPage> createState() => _WelcomeUserPageState();
}

class _WelcomeUserPageState extends State<WelcomeUserPage> {
  bool animated = false;
  Duration duration = const Duration(milliseconds: 300);
  List<String> welcomeTextList = [
    'Добро пожаловать',
    'Здраствуйте',
    'Приятного дня',
    'Доброго здоровья',
    'Сердечно приветствую',
  ];
  List<String> welcomePhotoList = [
    'assets/Photo_00070.jpg',
    'assets/Photo_00139.jpg',
    'assets/Photo_00063.jpg',
  ];
  String welcomeText = '';
  String welcomePhoto = '';

  @override
  void initState() {
    super.initState();
    welcomeText = welcomeTextList[Random().nextInt(welcomeTextList.length)];
    welcomePhoto = welcomePhotoList[Random().nextInt(welcomePhotoList.length)];
    Future.delayed(const Duration(milliseconds: 1000), startAnimation);
  }

  void startAnimation() async {
    setState(() {
      animated = !animated;
    });
    Future.delayed(const Duration(seconds: 2), () => Get.offAllNamed(RouterHelper.home));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        // Image.asset(
        //   welcomePhoto,
        //   colorBlendMode: BlendMode.softLight,
        //   color: Colors.black,
        //   fit: BoxFit.fitHeight,
        //   width: double.infinity,
        //   height: double.infinity,
        // ),
        Container(color: Colors.black45),
        AnimatedPositioned(
            duration: duration,
            top: animated ? 150 : 50,
            curve: Curves.easeOut,
            child: AnimatedOpacity(
              duration: duration,
              opacity: animated ? 1 : 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: Text(
                  textAlign: TextAlign.center,
                  welcomeText,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white),
                ),
              ),
            )),
      ]),
    ));
  }
}
