import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_kgo_vnpay/flutter_kgo_vnpay_method_channel.dart';

void main() {
  MethodChannelFlutterKgoVnpay platform = MethodChannelFlutterKgoVnpay.instance;
  const MethodChannel channel = MethodChannel('flutter_kgo_vnpay');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
