import '../models/payment.dart';

/// Utility class to manage assets paths from the package
class IpayAssets {
  static const String _basePath = 'packages/ipay_money_flutter_sdk/lib/assets';

  // Payment providers logos
  static const String airtel = '$_basePath/airtel.jpeg';
  static const String alizza = '$_basePath/alizza.png';
  static const String amanata = '$_basePath/amanata.png';
  static const String boa = '$_basePath/boa.png';
  static const String mastercard = '$_basePath/mastercard.jpg';
  static const String moovAfrica = '$_basePath/moov-africa.jpeg';
  static const String mtn = '$_basePath/mtn.png';
  static const String mynita = '$_basePath/mynita.png';
  static const String visa = '$_basePath/visa.png';
  static const String zamaniCash = '$_basePath/zamani-cash.png';

  // Payment type asset groups
  static const List<String> mobileMoneyAssets = [
    airtel,
    mtn,
    moovAfrica,
    zamaniCash,
  ];

  static const List<String> bankCardAssets = [
    visa,
    mastercard,
  ];

  static const List<String> alizzaAssets = [alizza];
  static const List<String> boaAssets = [boa];
  static const List<String> amanataAssets = [amanata];
  static const List<String> mynitaAssets = [mynita];

  /// Get assets by payment type
  static List<String> getAssetsByPaymentType(PaymentType paymentType) {
    switch (paymentType) {
      case PaymentType.mobile:
        return mobileMoneyAssets;
      case PaymentType.card:
        return bankCardAssets;
      case PaymentType.alizza:
        return alizzaAssets;
      case PaymentType.boa:
        return boaAssets;
      case PaymentType.amanata:
        return amanataAssets;
      case PaymentType.myNita:
        return mynitaAssets;
    }
  }

  /// Get payment method label by type
  static String getPaymentTypeLabel(PaymentType paymentType) {
    switch (paymentType) {
      case PaymentType.mobile:
        return 'Mobile Money';
      case PaymentType.card:
        return 'Carte Bancaire';
      case PaymentType.alizza:
        return 'AlIzza money';
      case PaymentType.boa:
        return 'BOA';
      case PaymentType.amanata:
        return 'AmanaTa';
      case PaymentType.myNita:
        return 'MyNITA';
    }
  }
}
