import 'flutter_kgo_vnpay_platform_interface.dart';

class FlutterKgoVnpay {
  Future<String?> getPlatformVersion() {
    return FlutterKgoVnpayPlatform.instance.getPlatformVersion();
  }

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
    return FlutterKgoVnpayPlatform.instance.show(
        paymentUrl: paymentUrl,
        tmnCode: tmnCode,
        scheme: scheme,
        isSandbox: isSandbox,
        backAlert: backAlert,
        title: title,
        iconBackName: iconBackName,
        beginColor: beginColor,
        endColor: endColor,
        titleColor: titleColor);
  }
}
