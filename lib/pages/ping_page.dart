import 'dart:io';

import 'package:admin_helper/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icmp_ping/flutter_icmp_ping.dart';
import 'package:get/get.dart';
import 'package:tcp_scanner/tcp_scanner.dart';

class PingPage extends StatefulWidget {
  const PingPage({Key? key}) : super(key: key);

  @override
  State<PingPage> createState() => _PingPageState();
}

class _PingPageState extends State<PingPage> {
  GlobalKey<SliverAnimatedListState> globalKey = GlobalKey<SliverAnimatedListState>();
  String address = '192.168.1.12';
  List<String> foundAddress = [];
  bool stopFor = false;
  bool isScan = false;

  void scanAddress() async {
    List<int> ports = List.generate(1000, (i) => 0 + i);
    Stopwatch stopwatch = Stopwatch();
    loadingSnack();

    foundAddress.clear();
    globalKey.currentState!.removeAllItems((context, animation) => SizeTransition(
          sizeFactor: animation,
          child: const Card(
            child: ListTile(),
          ),
        ));

    try {
      await TcpScannerTask(address, ports, shuffle: false, parallelism: 2).start().then((report) {
        foundAddress.add(report.host);
        globalKey.currentState!.insertItem(foundAddress.length - 1);
        print('Host ${report.host} scan completed\n'
            'Scanned ports:\t${report.ports.length}\n'
            'Open ports:\t${report.openPorts}\n'
            'Status:\t${report.status}\n'
            'Elapsed:\t${stopwatch.elapsed}\n');
      })
          // Catch errors during the scan
          .catchError((error) {
        printError(info: error);
      });
    } catch (e) {
      // Here you can catch exceptions threw in the constructor
      printError(info: e.toString());
    }
  }

  void pingAdr() async {
    setState(() {
      isScan = true;
    });
    foundAddress.clear();
    globalKey.currentState!.removeAllItems((context, animation) => SizeTransition(
          sizeFactor: animation,
          child: const Card(
            child: ListTile(),
          ),
        ));

    for (int i = 1; i < 255; i++) {
      if (stopFor) return;
      String curAdr = address.substring(0, address.lastIndexOf('.') + 1) + i.toString();
      print(curAdr);
      Ping ping = Ping(
        curAdr,
        count: 1,
        timeout: 2,
        interval: 0.2,
      );
      ping.stream.listen((event) {
        if (event.summary != null && event.summary!.received == event.summary!.transmitted) {
          foundAddress.add(curAdr);
          globalKey.currentState!.insertItem(foundAddress.length - 1);
        }
      });
      await Future.delayed(const Duration(milliseconds: 10));
    }
    setState(() {
      isScan = false;
    });
  }

  @override
  void dispose() {
    stopFor = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: pingAdr,
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                  expandedHeight: 50.0,
                  floating: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: const Text('Все задачи'),
                    background: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        isScan ? const CircularProgressIndicator(
                          color: Colors.green,
                        ) : Container(),
                        const Icon(
                          Icons.network_ping,
                          color: Colors.redAccent,
                          size: 60,
                        ),
                      ],
                    ),
                  )),
              SliverAnimatedList(
                  key: globalKey,
                  initialItemCount: foundAddress.length,
                  itemBuilder: (context, index, animation) {
                    var adr = foundAddress[index];
                    GlobalKey cardKey = GlobalKey();
                    return SizeTransition(
                      sizeFactor: animation,
                      child: Card(
                        key: cardKey,
                        child: ListTile(
                          title: Text(adr),
                        ),
                      ),
                    );
                  })
            ],
          )),
    );
  }
}
