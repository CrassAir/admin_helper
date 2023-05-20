import 'package:admin_helper/routes.dart';
import 'package:admin_helper/store/api_client.dart';
import 'package:admin_helper/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;
  FlutterSecureStorage storage = const FlutterSecureStorage();
  final ApiClient apiClient = Get.put(ApiClient());

  @override
  void initState() {
    super.initState();

    var brightness = SchedulerBinding.instance.window.platformBrightness;
    storage.read(key: 'isDarkMode').then((value) {
      if (value != null) {
        isDarkMode = value == 'true';
      } else {
        isDarkMode = brightness == Brightness.dark;
      }
      Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Admin Helper',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 200),
      theme: Styles.lightMode(context),
      darkTheme: Styles.darkMode(context),
      initialRoute: RouterHelper.welcome,
      getPages: RouterHelper.routes,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ru'), Locale('en')],
    );
  }
}
