# ipay_money_flutter_sdk

A payment method flutter package from the i-pay.money platform.

## Getting Started

Add this to your package's pubspec.yaml file:
```yaml
dependencies:
  ipay_money_flutter_sdk:
  ```

## Usage

Then you just have to import the package with

```dart
import 'package:ipay_money_flutter_sdk/ipay_money_flutter_sdk.dart';
```

## Example

#### For card payment only for live environment

```dart
IpayPayments(
timeOut: 10,
amount: '100',
authorization: 'XXXXXXXXXXXXXXXXXXXXXXX',
country: Country.ne,
currency: 'XOF',
exp: '01/10',
pan: "1234567XXXXXX",
cvv: '1XX',
msisdn: '90XXXXXX',
name: 'John Doe',
targetEnvironment: TargetEnvironment.live,
paymentType: PaymentType.card,
).ipayPayment( context: context,
callback: (callback) async {
//callback
if (jsonDecode(callback)['status'] == 'success') {
  if (mounted) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(
      content:
          Text('Paiement effectuer avec succès , reférence du paiement : ${jsonDecode(callback)['reference']}'),
      duration: Duration(seconds: 3),
    ));
  }
}else if(jsonDecode(callback)['status'] == 'failed'){
if (mounted) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(
      content:
          Text('Paiement non effectuer'),
      duration: Duration(seconds: 3),
    ));
  }
}
});
```

#### For mobile money payment for live and sandbox environment

```dart
IpayPayments(
timeOut: 10,
amount: '100',
authorization: 'XXXXXXXXXXXXXXXXXXXXXXX',
country: Country.ne,
msisdn: '90XXXXXX',
name: 'John Doe',
targetEnvironment: TargetEnvironment.sandbox,
paymentType: PaymentType.mobile,
).ipayPayment( context: context,
callback: (callback) async {
//callback
if (jsonDecode(callback)['status'] == 'success') {
  if (mounted) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(
      content:
          Text('Paiement effectuer avec succès , reférence du paiement : ${jsonDecode(callback)['reference']}'),
      duration: Duration(seconds: 3),
    ));
  }
}else if(jsonDecode(callback)['status'] == 'failed'){
if (mounted) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(
      content:
          Text('Paiement non effectuer'),
      duration: Duration(seconds: 3),
    ));
  }
}
});
```

#### For alIzza payment only for live environment

```dart
IpayPayments(
timeOut: 10,
amount: '100',
authorization: 'XXXXXXXXXXXXXXXXXXXXXXX',
country: Country.ne,
currency: 'XOF',
msisdn: '90XXXXXX',
name: 'John Doe',
targetEnvironment: TargetEnvironment.live,
paymentType: PaymentType.alizza,
).ipayPayment( context: context,
callback: (callback) async {
//callback
if (jsonDecode(callback)['status'] == 'success') {
  if (mounted) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(
      content:
          Text('Paiement effectuer avec succès , reférence du paiement : ${jsonDecode(callback)['reference']}'),
      duration: Duration(seconds: 3),
    ));
  }
}else if(jsonDecode(callback)['status'] == 'failed'){
if (mounted) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(
      content:
          Text('Paiement non effectuer'),
      duration: Duration(seconds: 3),
    ));
  }
}
});
```

### IpayMoneySdk Property:

| Property          | Type                   | Required | Description                                                               |
| :---------------- | :---------------------:| :------: |:-------------------------------------------------------------------------:|
| authorization     | String?                | true     | Your i-pay.money account secret key.                                      |
| name              | String?                | true     | The name of the person making the payment.                                |
| amount            | String?                | true     | The payment amount.                                                       |
| currency          | String?                | true     | The currency.                                                     |
| country           | enum Country           | true     | The country in which the payment is made (ne,bn)                          |
| msisdn            | String?                | true     | The phone number.                                                         |
| paymentType       | enum PaymentType       | true     | The type of payment (mobile, alizza, card)                                |
| pan               | String?                | false    | The credit card number.                                                   |
| cvv               | String?                | false    | The credit card code.                                                     |
| exp               | String?                | false    | The expiration date of the credit card.                                   |
| timeOut           | int?                   | false    | The maximum delay in seconds for the payment enquiry.                     |
| targetEnvironment | enum TargetEnvironment | true     | The target environment for the payment (live , sandbox)                   |
| callback          | Function(String)       | true     | This function return the status and reference of payment into Json object |

### The Country enumeration:

| Value   | Description |
| :------ |:-----------:|
| ne      | Niger       |
| bj      | Benin       |


### The PaymentType enumeration

| Value   | Description              |
| :------ |:------------------------:|
| mobile  | Payment by mobile phone. |
| alizza  | Payment by Alizza.       |
| card    | Payment by credit card.  |


### The TargetEnvironment enumeration:

| Value   | Description                 |
| :------ |:---------------------------:|
| live    | for production environment. |
| sandbox | for testing environment.    |
