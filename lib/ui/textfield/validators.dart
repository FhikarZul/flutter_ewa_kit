/// A collection of reusable validators for EWA TextFields
class EwaValidators {
  EwaValidators._();

  /// Validates that the input is not empty
  static String? required(
    String? value, [
    String errorMessage = 'This field is required',
  ]) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    return null;
  }

  /// Validates email format
  static String? email(
    String? value, [
    String errorMessage = 'Please enter a valid email',
  ]) {
    if (value == null || value.isEmpty) {
      return null; // Let required() handle empty fields if needed
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return errorMessage;
    }
    return null;
  }

  /// Validates minimum length
  static String? minLength(
    int minLength,
    String? value, [
    String? errorMessage,
  ]) {
    if (value == null || value.isEmpty) {
      return null; // Let required() handle empty fields if needed
    }

    if (value.length < minLength) {
      return errorMessage ?? 'Minimum length is $minLength characters';
    }
    return null;
  }

  /// Validates maximum length
  static String? maxLength(
    int maxLength,
    String? value, [
    String? errorMessage,
  ]) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if (value.length > maxLength) {
      return errorMessage ?? 'Maximum length is $maxLength characters';
    }
    return null;
  }

  /// Validates exact length
  static String? exactLength(
    int length,
    String? value, [
    String? errorMessage,
  ]) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if (value.length != length) {
      return errorMessage ?? 'Must be exactly $length characters';
    }
    return null;
  }

  /// Validates password strength (minimum 8 chars, at least one uppercase, one lowercase, one digit)
  static String? password(
    String? value, [
    String errorMessage =
        'Password must be at least 8 characters and contain uppercase, lowercase, and numeric characters',
  ]) {
    if (value == null || value.isEmpty) {
      return null; // Let required() handle empty fields if needed
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    final hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
    final hasLowercase = RegExp(r'[a-z]').hasMatch(value);
    final hasDigits = RegExp(r'[0-9]').hasMatch(value);

    if (!hasUppercase || !hasLowercase || !hasDigits) {
      return errorMessage;
    }

    return null;
  }

  /// Validates phone number format (basic international format)
  static String? phoneNumber(
    String? value, [
    String errorMessage = 'Please enter a valid phone number',
  ]) {
    if (value == null || value.isEmpty) {
      return null; // Let required() handle empty fields if needed
    }

    // Basic international phone number regex
    final phoneRegex = RegExp(r'^[\+]?[1-9][\d]{0,15}$');
    if (!phoneRegex.hasMatch(value)) {
      return errorMessage;
    }
    return null;
  }

  /// Validates numeric input
  static String? numeric(
    String? value, [
    String errorMessage = 'Please enter a valid number',
  ]) {
    if (value == null || value.isEmpty) {
      return null; // Let required() handle empty fields if needed
    }

    final numericRegex = RegExp(r'^-?[0-9]+\.?[0-9]*$');
    if (!numericRegex.hasMatch(value)) {
      return errorMessage;
    }
    return null;
  }

  /// Validates that value is greater than a minimum
  static String? min(double minValue, String? value, [String? errorMessage]) {
    if (value == null || value.isEmpty) {
      return null; // Let required() handle empty fields if needed
    }

    final numericRegex = RegExp(r'^-?[0-9]+\.?[0-9]*$');
    if (!numericRegex.hasMatch(value)) {
      return 'Please enter a valid number';
    }

    final numValue = double.tryParse(value);
    if (numValue == null || numValue < minValue) {
      return errorMessage ?? 'Value must be at least $minValue';
    }
    return null;
  }

  /// Validates that value is less than a maximum
  static String? max(double maxValue, String? value, [String? errorMessage]) {
    if (value == null || value.isEmpty) {
      return null; // Let required() handle empty fields if needed
    }

    final numericRegex = RegExp(r'^-?[0-9]+\.?[0-9]*$');
    if (!numericRegex.hasMatch(value)) {
      return 'Please enter a valid number';
    }

    final numValue = double.tryParse(value);
    if (numValue == null || numValue > maxValue) {
      return errorMessage ?? 'Value must be no more than $maxValue';
    }
    return null;
  }

  /// Validates URL format
  static String? url(
    String? value, [
    String errorMessage = 'Please enter a valid URL',
  ]) {
    if (value == null || value.isEmpty) {
      return null; // Let required() handle empty fields if needed
    }

    final urlRegex = RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
      caseSensitive: false,
    );
    if (!urlRegex.hasMatch(value)) {
      return errorMessage;
    }
    return null;
  }

  /// Validates credit card number using Luhn algorithm
  static String? creditCard(
    String? value, [
    String errorMessage = 'Please enter a valid credit card number',
  ]) {
    if (value == null || value.isEmpty) {
      return null; // Let required() handle empty fields if needed
    }

    // Remove spaces and dashes
    final cleanValue = value.replaceAll(RegExp(r'[\s\-]'), '');

    // Check if all characters are digits and length is between 13-19
    if (!RegExp(r'^\d{13,19}$').hasMatch(cleanValue)) {
      return errorMessage;
    }

    // Luhn algorithm
    bool isValid = false;
    try {
      int sum = 0;
      bool isEven = false;

      for (int i = cleanValue.length - 1; i >= 0; i--) {
        int digit = int.parse(cleanValue[i]);

        if (isEven) {
          digit *= 2;
          if (digit > 9) {
            digit -= 9;
          }
        }

        sum += digit;
        isEven = !isEven;
      }

      isValid = sum % 10 == 0;
    } catch (e) {
      isValid = false;
    }

    return isValid ? null : errorMessage;
  }

  /// Combines multiple validators
  static String? combine(
    List<String? Function(String?)> validators,
    String? value,
  ) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}
