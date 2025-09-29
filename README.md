# ipay_money_flutter_sdk

A comprehensive Flutter payment SDK for the i-pay.money platform, supporting multiple payment methods including Mobile Money, Credit Cards, Alizza, Amanata, BOA, and MyNita.

## Getting Started

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  ipay_money_flutter_sdk:
```

Then run:

```bash
flutter pub get
```

## Usage

Import the package:

```dart
import 'package:ipay_money_flutter_sdk/ipay_money_flutter_sdk.dart';
```

## Payment Methods

This SDK supports the following payment methods:

- **Mobile Money**: Pay using mobile money services
- **Credit/Debit Cards**: Visa, Mastercard payments
- **Alizza**: Alizza payment service
- **Amanata**: Amanata online payment
- **BOA**: Bank of Africa payment
- **MyNita**: Nita online payment

## Two Ways to Integrate

### 1. Programmatic Integration (IpayPayments)

For direct programmatic payment initiation:

```dart
// Card Payment
IpayPayments(
  amount: '100',
  authorization: 'Your secret key',
  country: Country.ne,
  currency: 'XOF',
  msisdn: '90000000',
  name: 'John Doe',
  paymentType: PaymentType.card,
  pan: '4111111111111111',
  exp: '12/25',
  cvv: '123',
  targetEnvironment: TargetEnvironment.live,
  timeOut: 60,
  referencePrefix: 'myapp',
  paymentSucceededMsg: 'Payment successful!',
  paymentFailedMsg: 'Payment failed. Please try again.',
).ipayPayment(
  context: context,
  callback: (callback) {
    final response = jsonDecode(callback);
    if (response['status'] == 'success') {
      // Handle success
      print('Payment successful: ${response['reference']}');
    } else {
      // Handle failure
      print('Payment failed');
    }
  },
);

// Mobile Money Payment
IpayPayments(
  amount: '100',
  authorization: 'Your secret key',
  country: Country.ne,
  currency: 'XOF',
  msisdn: '90000000',
  name: 'John Doe',
  paymentType: PaymentType.mobile,
  targetEnvironment: TargetEnvironment.live,
  timeOut: 60,
  referencePrefix: 'myapp',
).ipayPayment(
  context: context,
  callback: (callback) {
    final response = jsonDecode(callback);
    if (response['status'] == 'success') {
      // Handle success
    } else {
      // Handle failure
    }
  },
);

// Alizza Payment
IpayPayments(
  amount: '100',
  authorization: 'Your secret key',
  country: Country.ne,
  currency: 'XOF',
  msisdn: '90000000',
  name: 'John Doe',
  paymentType: PaymentType.alizza,
  targetEnvironment: TargetEnvironment.live,
  timeOut: 60,
  referencePrefix: 'myapp',
).ipayPayment(
  context: context,
  callback: (callback) {
    // Handle callback
  },
);

// Amanata Payment
IpayPayments(
  amount: '100',
  authorization: 'Your secret key',
  country: Country.ne,
  currency: 'XOF',
  msisdn: '90000000',
  name: 'John Doe',
  paymentType: PaymentType.amanata,
  targetEnvironment: TargetEnvironment.live,
  timeOut: 60,
  referencePrefix: 'myapp',
).ipayPayment(
  context: context,
  callback: (callback) {
    // Handle callback
  },
);

// BOA Payment
IpayPayments(
  amount: '100',
  authorization: 'Your secret key',
  country: Country.ne,
  currency: 'XOF',
  msisdn: '90000000',
  name: 'John Doe',
  paymentType: PaymentType.boa,
  targetEnvironment: TargetEnvironment.live,
  timeOut: 60,
  referencePrefix: 'myapp',
).ipayPayment(
  context: context,
  callback: (callback) {
    // Handle callback
  },
);

// MyNita Payment
IpayPayments(
  amount: '100',
  authorization: 'Your secret key',
  country: Country.ne,
  currency: 'XOF',
  msisdn: '90000000',
  name: 'John Doe',
  paymentType: PaymentType.myNita,
  targetEnvironment: TargetEnvironment.live,
  timeOut: 60,
  referencePrefix: 'myapp',
).ipayPayment(
  context: context,
  callback: (callback) {
    // Handle callback
  },
);
```

### 2. UI Widget Integration (IpayPaymentsWidget)

For a complete payment UI with payment method selection:

```dart
class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payment')),
      body: IpayPaymentsWidget(
        authorization: 'Your secret key',
        country: Country.ne,
        currency: 'XOF',
        targetEnvironment: TargetEnvironment.live,
        timeOut: 60,
        referencePrefix: 'myapp',
        // Optional: pre-fill amount
        amount: '100',
        // Optional: customize messages
        paymentSucceededMsg: 'Payment completed successfully!',
        paymentFailedMsg: 'Payment failed. Please try again.',
        // Optional: control which payment methods to show
        showMobileMoneyProvider: true,
        showCardProvider: true,
        showAlIzzaProvider: true,
        showAmanaTaProvider: true,
        showBoaProvider: true,
        showNitaOnlineProvider: true,
        callback: (callback, context) {
          final response = jsonDecode(callback);
          if (response['status'] == 'success') {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Payment successful! Reference: ${response['reference']}'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          } else {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Payment failed. Please try again.'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
```

## API Reference

### IpayPayments Properties

| Property              | Type                   | Required | Description |
|----------------------|------------------------|----------|-------------|
| authorization        | String                 | true     | Your i-pay.money account secret key |
| name                 | String                 | true     | The name of the person making the payment |
| amount               | String                 | true     | The payment amount |
| currency             | String                 | true     | The currency (e.g., 'XOF') |
| country              | Country                | true     | The country (Country.ne, Country.bj) |
| msisdn               | String                 | true     | The phone number |
| paymentType          | PaymentType            | true     | The payment method |
| targetEnvironment    | TargetEnvironment      | true     | Environment (live/sandbox) |
| timeOut              | int                    | false    | Payment enquiry timeout in seconds (default: 60) |
| referencePrefix      | String                 | false    | Prefix for transaction reference (default: 'ipay') |
| transactionId        | String?                | false    | Custom transaction ID |
| paymentSucceededMsg  | String?                | false    | Custom success message |
| paymentFailedMsg     | String?                | false    | Custom failure message |
| pan                  | String                 | false    | Credit card number (required for card payments) |
| exp                  | String                 | false    | Card expiration date (MM/YY) (required for card payments) |
| cvv                  | String                 | false    | Card CVV (required for card payments) |

### IpayPaymentsWidget Properties

| Property                  | Type                   | Required | Description |
|---------------------------|------------------------|----------|-------------|
| authorization             | String                 | true     | Your i-pay.money account secret key |
| country                   | Country                | true     | The country |
| currency                  | String                 | true     | The currency |
| targetEnvironment         | TargetEnvironment      | true     | Environment setting |
| callback                  | Function(String, BuildContext) | true | Payment result callback |
| amount                    | String?                | false    | Pre-filled payment amount |
| timeOut                   | int                    | false    | Timeout in seconds (default: 60) |
| referencePrefix           | String                 | false    | Reference prefix (default: 'ipay') |
| transactionId             | String?                | false    | Custom transaction ID |
| paymentSucceededMsg       | String?                | false    | Custom success message |
| paymentFailedMsg          | String?                | false    | Custom failure message |
| showMobileMoneyProvider   | bool                   | false    | Show mobile money option (default: true) |
| showCardProvider          | bool                   | false    | Show card payment option (default: true) |
| showAlIzzaProvider        | bool                   | false    | Show Alizza option (default: true) |
| showAmanaTaProvider       | bool                   | false    | Show Amanata option (default: true) |
| showBoaProvider           | bool                   | false    | Show BOA option (default: true) |
| showNitaOnlineProvider    | bool                   | false    | Show MyNita option (default: true) |

## Enumerations

### Country

| Value | Description |
|-------|-------------|
| ne    | Niger       |
| bj    | Benin       |

### PaymentType

| Value    | Description |
|----------|-------------|
| mobile   | Mobile Money payment |
| card     | Credit/Debit card payment |
| alizza   | Alizza payment service |
| amanata  | Amanata online payment |
| boa      | Bank of Africa payment |
| myNita   | Nita online payment |

### TargetEnvironment

| Value   | Description |
|---------|-------------|
| live    | Production environment |
| sandbox | Testing environment |

## Callback Response

The callback function receives a JSON string with the following structure:

```json
{
  "status": "success", // or "failed"
  "reference": "transaction-reference",
  "public_reference": "public-reference" // for some payment types
}
```

## License

This package is licensed under the MIT License.

## Support

For support and questions, please visit [i-pay.money](https://i-pay.money) or create an issue in the GitHub repository.
