import 'package:admin_helper/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icmp_ping/flutter_icmp_ping.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:tcp_scanner/tcp_scanner.dart';

class NetworkScanPage extends StatefulWidget {
  const NetworkScanPage({Key? key}) : super(key: key);

  @override
  State<NetworkScanPage> createState() => _NetworkScanPageState();
}

class _NetworkScanPageState extends State<NetworkScanPage> {
  GlobalKey<SliverAnimatedListState> globalKey = GlobalKey<SliverAnimatedListState>();
  final info = NetworkInfo();
  String address = '192.168.1.12';
  List<Map<String, String>> foundAddress = [];
  bool stopFor = false;
  bool isScan = false;
  String? wifiName;
  String? wifiIP;
  String? wifiSubmask;
  String? wifiGateway;

  @override
  void initState() {
    super.initState();
    getNetwork();
  }

  void getNetwork() async {
    wifiName = await info.getWifiName();
    wifiIP = await info.getWifiIP();
    wifiSubmask = await info.getWifiSubmask();
    wifiGateway = await info.getWifiGatewayIP();
    setState(() {});
  }

  void scanAddress(String adr) async {
    List<int> ports = List.generate(1000, (i) => 0 + i);
    Stopwatch stopwatch = Stopwatch();

    try {
      await TcpScannerTask(adr, ports, shuffle: false, parallelism: 2).start().then((report) {
        print('Host ${report.host} scan completed\n'
            'Scanned ports:\t${report.ports.length}\n'
            'Open ports:\t${report.openPorts}\n'
            'Status:\t${report.status}\n'
            'Elapsed:\t${stopwatch.elapsed}\n');
      })
          // Catch errors during the scan
          .catchError((error) {
        print(error);
      });
    } catch (e) {
      // Here you can catch exceptions threw in the constructor
      print(e.toString());
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
          foundAddress.add({'adr': curAdr});
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
            floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: pingAdr,
              child: Icon(Icons.add),
            ),
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                    expandedHeight: 50.0,
                    floating: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: const Text('Network Scan'),
                      background: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          isScan
                              ? const CircularProgressIndicator(
                                  color: Colors.green,
                                )
                              : Container(),
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
                            title: Text(adr['adr']!),
                          ),
                        ),
                      );
                    })
              ],
            ),
            bottomNavigationBar: wifiIP != null && wifiSubmask != null && wifiGateway != null
                ? BottomAppBar(
                    height: 80,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: const CircularNotchedRectangle(),
                    child: Column(
                      children: [
                        const Text('Состояние сети'),
                        Text('SSID: ${wifiName}'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('IP: ${wifiIP!}'),
                            Text('Маска: ${wifiSubmask!}'),
                            Text('Шлюз: ${wifiGateway!}'),
                          ],
                        ),
                      ],
                    ),
                  )
                : Container()));
  }
}
