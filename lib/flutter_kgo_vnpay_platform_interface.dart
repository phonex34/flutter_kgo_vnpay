import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_kgo_vnpay_method_channel.dart';

abstract class FlutterKgoVnpayPlatform extends PlatformInterface {
  /// Constructs a FlutterKgoVnpayPlatform.
  FlutterKgoVnpayPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterKgoVnpayPlatform _instance =
      MethodChannelFlutterKgoVnpay.instance;

  /// The default instance of [FlutterKgoVnpayPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterKgoVnpay].
  static FlutterKgoVnpayPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterKgoVnpayPlatform] when
  /// they register themselves.
  static set instance(FlutterKgoVnpayPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<int?> show({
    required String paymentUrl,
    required String tmnCode,
    String scheme = '',
    bool isSandbox = true,
    String backAlert = 'Bạn có chắc chắn trở lại ko?',
    String title = 'Nạp tiền qua VNPay',
    String iconBackName = 'ic_back',
    String beginColor = '#00B14F',
    String endColor = '#00B14F',
    String titleColor = '#FFFFFF',
  }) {
    throw UnimplementedError('show() has not been implemented.');
  }
}
