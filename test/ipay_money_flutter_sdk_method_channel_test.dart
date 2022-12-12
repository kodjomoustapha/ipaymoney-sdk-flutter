// import 'package:flutter/services.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:ipay_money_flutter_sdk/ipay_money_flutter_sdk_method_channel.dart';

// void main() {
//   MethodChannelIpayMoneyFlutterSdk platform = MethodChannelIpayMoneyFlutterSdk();
//   const MethodChannel channel = MethodChannel('ipay_money_flutter_sdk');

//   TestWidgetsFlutterBinding.ensureInitialized();

//   setUp(() {
//     channel.setMockMethodCallHandler((MethodCall methodCall) async {
//       return '42';
//     });
//   });

//   tearDown(() {
//     channel.setMockMethodCallHandler(null);
//   });

//   test('getPlatformVersion', () async {
//     expect(await platform.getPlatformVersion(), '42');
//   });
// }
