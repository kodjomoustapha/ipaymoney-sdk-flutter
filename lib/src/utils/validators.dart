class FormValidators {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Le nom est requis';
    }
    if (value.trim().length < 2) {
      return 'Le nom doit contenir au moins 2 caractères';
    }
    if (!RegExp(r'^[a-zA-ZÀ-ÿ\s]+$').hasMatch(value.trim())) {
      return 'Le nom ne doit contenir que des lettres';
    }
    return null;
  }

  static String? validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Le montant est requis';
    }

    final cleanValue = value.replaceAll(' ', '');
    final amount = int.tryParse(cleanValue);

    if (amount == null) {
      return 'Montant invalide';
    }

    if (amount < 100) {
      return 'Le montant minimum est de 100 FCFA';
    }

    if (amount > 1000000) {
      return 'Le montant maximum est de 1 000 000 FCFA';
    }

    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Le numéro de téléphone est requis';
    }

    final cleanValue = value.replaceAll(' ', '');

    if (!RegExp(r'^[0-9]{8}$').hasMatch(cleanValue)) {
      return 'Le numéro doit contenir exactement 8 chiffres';
    }

    if (!RegExp(r'^(9[0-9]|8[0-9]|7[0-9])').hasMatch(cleanValue)) {
      return 'Numéro de téléphone invalide';
    }

    return null;
  }

  static String? validateCardNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Le numéro de carte est requis';
    }

    final cleanValue = value.replaceAll(' ', '');

    if (!RegExp(r'^[0-9]{16}$').hasMatch(cleanValue)) {
      return 'Le numéro de carte doit contenir 16 chiffres';
    }

    if (!_isValidLuhn(cleanValue)) {
      return 'Numéro de carte invalide';
    }

    return null;
  }

  static String? validateExpiryDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'La date d\'expiration est requise';
    }

    if (!RegExp(r'^[0-9]{2}/[0-9]{2}$').hasMatch(value)) {
      return 'Format invalide (MM/AA)';
    }

    final parts = value.split('/');
    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);

    if (month == null || year == null) {
      return 'Date invalide';
    }

    if (month < 1 || month > 12) {
      return 'Mois invalide (01-12)';
    }

    final now = DateTime.now();
    final currentYear = now.year % 100;
    final currentMonth = now.month;

    if (year < currentYear || (year == currentYear && month < currentMonth)) {
      return 'Carte expirée';
    }

    return null;
  }

  static String? validateCVV(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Le CVV est requis';
    }

    if (!RegExp(r'^[0-9]{3}$').hasMatch(value)) {
      return 'Le CVV doit contenir 3 chiffres';
    }

    return null;
  }

  static bool _isValidLuhn(String cardNumber) {
    int sum = 0;
    bool isEven = false;

    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cardNumber[i]);

      if (isEven) {
        digit *= 2;
        if (digit > 9) {
          digit = digit ~/ 10 + digit % 10;
        }
      }

      sum += digit;
      isEven = !isEven;
    }

    return sum % 10 == 0;
  }
}
