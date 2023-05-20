import 'package:admin_helper/pages/network_scan_page.dart';
import 'package:admin_helper/pages/ping_page.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            OpenContainer(
              openColor: Theme.of(context).canvasColor,
              closedColor: Theme.of(context).canvasColor,
              closedBuilder: (context, action) => const Card(
                child: ListTile(
                  title: Text('Ping'),
                ),
              ),
              openBuilder: (context, action) => const PingPage(),
            ),
            OpenContainer(
              openColor: Theme.of(context).canvasColor,
              closedColor: Theme.of(context).canvasColor,
              closedBuilder: (context, action) => const Card(
                child: ListTile(
                  title: Text('Network scan'),
                ),
              ),
              openBuilder: (context, action) => const NetworkScanPage(),
            )
          ]))
        ]),
      ),
    );
  }
}
