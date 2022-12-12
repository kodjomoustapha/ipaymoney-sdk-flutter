// import 'package:flutter_test/flutter_test.dart';
// import 'package:ipay_money_flutter_sdk/ipay_money_flutter_sdk.dart';
// import 'package:ipay_money_flutter_sdk/ipay_money_flutter_sdk_platform_interface.dart';
// import 'package:ipay_money_flutter_sdk/ipay_money_flutter_sdk_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockIpayMoneyFlutterSdkPlatform
//     with MockPlatformInterfaceMixin
//     implements IpayMoneyFlutterSdkPlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

// void main() {
//   final IpayMoneyFlutterSdkPlatform initialPlatform = IpayMoneyFlutterSdkPlatform.instance;

//   test('$MethodChannelIpayMoneyFlutterSdk is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelIpayMoneyFlutterSdk>());
//   });

//   test('getPlatformVersion', () async {
//     IpayMoneyFlutterSdk ipayMoneyFlutterSdkPlugin = IpayMoneyFlutterSdk();
//     MockIpayMoneyFlutterSdkPlatform fakePlatform = MockIpayMoneyFlutterSdkPlatform();
//     IpayMoneyFlutterSdkPlatform.instance = fakePlatform;

//     expect(await ipayMoneyFlutterSdkPlugin.getPlatformVersion(), '42');
//   });
// }
