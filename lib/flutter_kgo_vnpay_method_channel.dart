import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'flutter_kgo_vnpay_platform_interface.dart';

/// An implementation of [FlutterKgoVnpayPlatform] that uses method channels.
class MethodChannelFlutterKgoVnpay extends FlutterKgoVnpayPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_kgo_vnpay');
  final StreamController<MethodCall> _methodStreamController =
      StreamController.broadcast();
  Stream<MethodCall> get _methodStream => _methodStreamController.stream;

  MethodChannelFlutterKgoVnpay._() {
    methodChannel.setMethodCallHandler((MethodCall call) async {
      debugPrint('[setMethodCallHandler] call = $call');
      _methodStreamController.add(call);
    });
  }

  static final MethodChannelFlutterKgoVnpay _instance =
      MethodChannelFlutterKgoVnpay._();
  static MethodChannelFlutterKgoVnpay get instance => _instance;

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<int?> show({
    required String paymentUrl,
    required String tmnCode,
    String scheme = '',
    bool isSandbox = true,
    String backAlert = 'Bạn có chắc chắn trở lại ko?',
    String title = 'Nạp tiền qua VNPay',
    String iconBackName = 'ic_back',
    String beginColor = '#438ff5',
    String endColor = '#438ff5',
    String titleColor = '#FFFFFF',
  }) async {
    final params = <String, dynamic>{
      "scheme": scheme,
      "isSandbox": isSandbox,
      "paymentUrl": paymentUrl,
      "tmn_code": tmnCode,
      "backAlert": backAlert,
      "title": title,
      "iconBackName": iconBackName,
      "beginColor": beginColor,
      "endColor": endColor,
      "titleColor": titleColor,
    };
    await methodChannel.invokeMethod('show', params);
    await for (MethodCall m in _methodStream) {
      if (m.method == "PaymentBack") {
        return m.arguments['resultCode'] as int?;
      }
    }
    return null;
  }
}
