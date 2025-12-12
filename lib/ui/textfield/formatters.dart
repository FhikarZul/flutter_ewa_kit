/// A collection of reusable formatters for EWA TextFields
class EwaFormatters {
  EwaFormatters._();

  /// Formats input as currency (e.g., 1000 becomes Rp 1.000)
  /// Works with Indonesian Rupiah by default
  static String formatCurrency(
    String value, {
    String currencySymbol = 'Rp',
    String thousandSeparator = '.',
    String decimalSeparator = ',',
    int decimalDigits = 0,
  }) {
    if (value.isEmpty) return '';

    // Extract only digits from the input (ignore currency symbols and separators)
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');

    if (digitsOnly.isEmpty) return '';

    // Handle decimal places
    if (decimalDigits > 0 && digitsOnly.length > decimalDigits) {
      final integerPart = digitsOnly.substring(
        0,
        digitsOnly.length - decimalDigits,
      );
      final decimalPart = digitsOnly.substring(
        digitsOnly.length - decimalDigits,
      );

      // Format integer part with thousand separators
      final formattedInteger = _formatWithThousandSeparator(
        integerPart.isNotEmpty ? integerPart : '0',
        thousandSeparator,
      );

      return '$currencySymbol $formattedInteger$decimalSeparator$decimalPart';
    } else {
      // Format as integer
      final formattedValue = _formatWithThousandSeparator(
        digitsOnly,
        thousandSeparator,
      );

      return '$currencySymbol $formattedValue';
    }
  }

  /// Helper method to add thousand separators
  static String _formatWithThousandSeparator(String value, String separator) {
    if (value.isEmpty) return '';

    // Remove leading zeros
    final cleanValue = value.replaceFirst(RegExp(r'^0+(?=\d)'), '');

    if (cleanValue.isEmpty) return '0';

    // Add thousand separators
    final buffer = StringBuffer();
    final length = cleanValue.length;

    for (int i = 0; i < length; i++) {
      if (i > 0 && (length - i) % 3 == 0) {
        buffer.write(separator);
      }
      buffer.write(cleanValue[i]);
    }

    return buffer.toString();
  }

  /// Formatter function that can be used with TextField's formatter
  static String currencyFormatter(
    String value, {
    String currencySymbol = 'Rp',
    String thousandSeparator = '.',
    String decimalSeparator = ',',
    int decimalDigits = 0,
  }) {
    return formatCurrency(
      value,
      currencySymbol: currencySymbol,
      thousandSeparator: thousandSeparator,
      decimalSeparator: decimalSeparator,
      decimalDigits: decimalDigits,
    );
  }
}
