import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_kgo_vnpay/flutter_kgo_vnpay.dart';
import 'package:flutter_kgo_vnpay/flutter_kgo_vnpay_platform_interface.dart';
import 'package:flutter_kgo_vnpay/flutter_kgo_vnpay_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterKgoVnpayPlatform
    with MockPlatformInterfaceMixin
    implements FlutterKgoVnpayPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<int?> show(
      {required String paymentUrl,
      required String tmnCode,
      String scheme = '',
      bool isSandbox = true,
      String backAlert = 'Bạn có chắc chắn trở lại ko?',
      String title = 'Nạp tiền qua VNPay',
      String iconBackName = 'AppIcon',
      String beginColor = '#00B14F',
      String endColor = '#00B14F',
      String titleColor = '#FFFFFF'}) {
    throw UnimplementedError();
  }
}

void main() {
  final FlutterKgoVnpayPlatform initialPlatform =
      FlutterKgoVnpayPlatform.instance;

  test('$MethodChannelFlutterKgoVnpay is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterKgoVnpay>());
  });

  test('getPlatformVersion', () async {
    FlutterKgoVnpay flutterKgoVnpayPlugin = FlutterKgoVnpay();
    MockFlutterKgoVnpayPlatform fakePlatform = MockFlutterKgoVnpayPlatform();
    FlutterKgoVnpayPlatform.instance = fakePlatform;

    expect(await flutterKgoVnpayPlugin.getPlatformVersion(), '42');
  });
}
