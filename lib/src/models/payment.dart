class Payment {
  const Payment({
    this.publicReference,
    this.reference,
    this.authorization,
    this.name,
    this.amount,
    this.country,
    this.msisdn,
    this.currency,
    this.paymentType,
    this.pan,
    this.exp,
    this.cvv,
    this.timeOut,
    this.referencePrefix,
    this.transactionId,
    this.targetEnvironment,
  });

  final String? publicReference;
  final String? reference;
  final String? authorization;
  final String? name;
  final String? amount;
  final Country? country;
  final String? msisdn;
  final String? currency;
  final PaymentType? paymentType;
  final String? pan;
  final String? exp;
  final String? cvv;
  final int? timeOut;
  final String? referencePrefix;
  final String? transactionId;
  final TargetEnvironment? targetEnvironment;

  Payment copyWith({
    String? publicReference,
    String? reference,
    String? authorization,
    String? name,
    String? amount,
    Country? country,
    String? msisdn,
    String? currency,
    PaymentType? paymentType,
    String? pan,
    String? exp,
    String? cvv,
    int? timeOut,
    String? referencePrefix,
    String? transactionId,
    TargetEnvironment? targetEnvironment,
  }) {
    return Payment(
      publicReference: publicReference ?? this.publicReference,
      reference: reference ?? this.reference,
      authorization: authorization ?? this.authorization,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      country: country ?? this.country,
      msisdn: msisdn ?? this.msisdn,
      currency: currency ?? this.currency,
      paymentType: paymentType ?? this.paymentType,
      pan: pan ?? this.pan,
      exp: exp ?? this.exp,
      cvv: cvv ?? this.cvv,
      timeOut: timeOut ?? this.timeOut,
      referencePrefix: referencePrefix ?? this.referencePrefix,
      transactionId: transactionId ?? this.transactionId,
      targetEnvironment: targetEnvironment ?? this.targetEnvironment,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Payment &&
        other.publicReference == publicReference &&
        other.reference == reference &&
        other.authorization == authorization &&
        other.name == name &&
        other.amount == amount &&
        other.country == country &&
        other.msisdn == msisdn &&
        other.currency == currency &&
        other.paymentType == paymentType &&
        other.pan == pan &&
        other.exp == exp &&
        other.cvv == cvv &&
        other.timeOut == timeOut &&
        other.referencePrefix == referencePrefix &&
        other.transactionId == transactionId &&
        other.targetEnvironment == targetEnvironment;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      publicReference,
      reference,
      authorization,
      name,
      amount,
      country,
      msisdn,
      currency,
      paymentType,
      pan,
      exp,
      cvv,
      timeOut,
      referencePrefix,
      transactionId,
      targetEnvironment,
    ]);
  }

  @override
  String toString() {
    return 'Payment(publicReference: $publicReference, reference: $reference, authorization: $authorization, name: $name, amount: $amount, country: $country, msisdn: $msisdn, currency: $currency, paymentType: $paymentType, pan: $pan, exp: $exp, cvv: $cvv, timeOut: $timeOut, referencePrefix: $referencePrefix, transactionId: $transactionId, targetEnvironment: $targetEnvironment)';
  }
}

// Define the `Country` enum
enum Country { ne, bj }

// Define the `PaymentType` enum
enum PaymentType { mobile, alizza, card, amanata, boa, myNita }

// Define the `TargetEnvironment` enum
enum TargetEnvironment { live, sandbox }

// Define the `TransactionStatus` enum
enum TransactionStatus {
  succeeded,
  failed,
  pending,
  initiated,
  connectionError
}
