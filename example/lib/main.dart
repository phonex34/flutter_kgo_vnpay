import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_kgo_vnpay/flutter_kgo_vnpay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _flutterKgoVnpayPlugin = FlutterKgoVnpay();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _flutterKgoVnpayPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    _flutterKgoVnpayPlugin.show(
                      paymentUrl:
                          'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html?vnp_Amount=93830000&vnp_Command=pay&vnp_CreateDate=20220713172638&vnp_CurrCode=VND&vnp_IpAddr=27.72.98.245&vnp_Locale=vn&vnp_OrderInfo=Mua+bh+tnds+cho+xe+%2C+ma+don%3A+220713LNZHKU&vnp_ReturnUrl=httpsO://kgo.life&vnp_TmnCode=xxx&vnp_TxnRef=1000013&vnp_Version=2.1.0&vnp_SecureHash=xxxx',
                      tmnCode: 'kgoxxx',
                      scheme: 'kgo-vnpay',
                    );
                  },
                  child: Text('Nạp tiền')),
              Text('Running on: $_platformVersion\n'),
            ],
          ),
        ),
      ),
    );
  }
}
