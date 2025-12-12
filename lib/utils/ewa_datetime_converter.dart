import 'package:intl/intl.dart';

/// A utility class for converting and formatting DateTime objects in the EWA Kit
/// Supports both international and Indonesian formatting standards
///
/// Example usage:
/// ```dart
/// // Format datetime to various formats
/// final formatted = EwaDateTimeConverter.formatToHumanReadable(DateTime.now());
///
/// // Format datetime using Indonesian standards
/// final indoFormatted = EwaDateTimeConverter.formatToIndonesian(DateTime.now());
///
/// // Parse string to datetime
/// final datetime = EwaDateTimeConverter.parse('2023-12-25');
///
/// // Calculate time difference
/// final difference = EwaDateTimeConverter.getTimeAgo(DateTime.now().subtract(Duration(days: 2)));
/// ```
class EwaDateTimeConverter {
  /// Private constructor to prevent instantiation
  EwaDateTimeConverter._();

  /// Formats a DateTime to a human-readable string (e.g., "December 25, 2023")
  static String formatToHumanReadable(DateTime dateTime) {
    final formatter = DateFormat('MMMM d, y');
    return formatter.format(dateTime);
  }

  /// Formats a DateTime to a short date string (e.g., "Dec 25, 2023")
  static String formatToShortDate(DateTime dateTime) {
    final formatter = DateFormat('MMM d, y');
    return formatter.format(dateTime);
  }

  /// Formats a DateTime to a time string (e.g., "2:30 PM")
  static String formatToTime(DateTime dateTime) {
    final formatter = DateFormat.jm();
    return formatter.format(dateTime);
  }

  /// Formats a DateTime to a full datetime string (e.g., "December 25, 2023 at 2:30 PM")
  static String formatToFullDateTime(DateTime dateTime) {
    final formatter = DateFormat('MMMM d, y \'at\' jm');
    return formatter.format(dateTime);
  }

  /// Formats a DateTime to ISO 8601 string
  static String formatToIso8601(DateTime dateTime) {
    return dateTime.toIso8601String();
  }

  /// Formats a DateTime according to Indonesian standards (e.g., "25 Desember 2023")
  static String formatToIndonesian(DateTime dateTime) {
    try {
      final formatter = DateFormat('d MMMM y', 'id_ID');
      return formatter.format(dateTime);
    } catch (e) {
      // Fallback to English format if locale not initialized
      final formatter = DateFormat('d MMMM y');
      return formatter.format(dateTime);
    }
  }

  /// Formats a DateTime to short Indonesian date (e.g., "25 Des 2023")
  static String formatToShortIndonesian(DateTime dateTime) {
    try {
      final formatter = DateFormat('d MMM y', 'id_ID');
      return formatter.format(dateTime);
    } catch (e) {
      // Fallback to English format if locale not initialized
      final formatter = DateFormat('d MMM y');
      return formatter.format(dateTime);
    }
  }

  /// Formats time according to Indonesian standards (e.g., "14.30")
  static String formatToIndonesianTime(DateTime dateTime) {
    try {
      final formatter = DateFormat.Hm('id_ID');
      return formatter.format(dateTime);
    } catch (e) {
      // Fallback to English format if locale not initialized
      final formatter = DateFormat.Hm();
      return formatter.format(dateTime);
    }
  }

  /// Formats a DateTime to full Indonesian datetime (e.g., "25 Desember 2023 pukul 14.30")
  static String formatToFullIndonesianDateTime(DateTime dateTime) {
    try {
      final formatter = DateFormat('d MMMM y \'pukul\' H.mm', 'id_ID');
      return formatter.format(dateTime);
    } catch (e) {
      // Fallback to English format if locale not initialized
      final formatter = DateFormat('d MMMM y \'at\' H:mm');
      return formatter.format(dateTime);
    }
  }

  /// Gets Indonesian day name (e.g., "Senin", "Selasa")
  static String getIndonesianDayName(DateTime dateTime) {
    try {
      final formatter = DateFormat.EEEE('id_ID');
      return formatter.format(dateTime);
    } catch (e) {
      // Fallback to English format if locale not initialized
      final formatter = DateFormat.EEEE();
      return formatter.format(dateTime);
    }
  }

  /// Gets short Indonesian day name (e.g., "Sen", "Sel")
  static String getShortIndonesianDayName(DateTime dateTime) {
    try {
      final formatter = DateFormat.E('id_ID');
      return formatter.format(dateTime);
    } catch (e) {
      // Fallback to English format if locale not initialized
      final formatter = DateFormat.E();
      return formatter.format(dateTime);
    }
  }

  /// Gets Indonesian month name (e.g., "Januari", "Februari")
  static String getIndonesianMonthName(DateTime dateTime) {
    try {
      final formatter = DateFormat.MMMM('id_ID');
      return formatter.format(dateTime);
    } catch (e) {
      // Fallback to English format if locale not initialized
      final formatter = DateFormat.MMMM();
      return formatter.format(dateTime);
    }
  }

  /// Parses a string to DateTime
  ///
  /// Supports formats:
  /// - ISO 8601: "2023-12-25T14:30:00.000Z"
  /// - Date only: "2023-12-25"
  /// - Date with time: "2023-12-25 14:30:00"
  static DateTime? parse(String dateString) {
    try {
      // Try ISO 8601 format first
      if (dateString.contains('T')) {
        return DateTime.parse(dateString);
      }

      // Try date only format
      if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(dateString)) {
        return DateFormat('yyyy-MM-dd').parse(dateString);
      }

      // Try date with time format
      if (RegExp(
        r'^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$',
      ).hasMatch(dateString)) {
        return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateString);
      }

      // Try other common formats
      return DateFormat.yMd().parseLoose(dateString);
    } catch (e) {
      return null;
    }
  }

  /// Calculates the time difference and returns a human-readable string
  ///
  /// Examples:
  /// - "Just now" / "Baru saja"
  /// - "2 minutes ago" / "2 menit yang lalu"
  /// - "1 hour ago" / "1 jam yang lalu"
  /// - "Yesterday" / "Kemarin"
  /// - "3 days ago" / "3 hari yang lalu"
  static String getTimeAgo(DateTime dateTime, {bool useIndonesian = false}) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (useIndonesian) {
      if (difference.inSeconds < 60) {
        return 'Baru saja';
      } else if (difference.inMinutes < 60) {
        final minutes = difference.inMinutes;
        return '$minutes menit yang lalu';
      } else if (difference.inHours < 24) {
        final hours = difference.inHours;
        return '$hours jam yang lalu';
      } else if (difference.inDays == 1) {
        return 'Kemarin';
      } else if (difference.inDays < 7) {
        final days = difference.inDays;
        return '$days hari yang lalu';
      } else if (difference.inDays < 30) {
        final weeks = (difference.inDays / 7).floor();
        return '$weeks minggu yang lalu';
      } else if (difference.inDays < 365) {
        final months = (difference.inDays / 30).floor();
        return '$months bulan yang lalu';
      } else {
        final years = (difference.inDays / 365).floor();
        return '$years tahun yang lalu';
      }
    } else {
      if (difference.inSeconds < 60) {
        return 'Just now';
      } else if (difference.inMinutes < 60) {
        final minutes = difference.inMinutes;
        return '$minutes minute${minutes > 1 ? 's' : ''} ago';
      } else if (difference.inHours < 24) {
        final hours = difference.inHours;
        return '$hours hour${hours > 1 ? 's' : ''} ago';
      } else if (difference.inDays == 1) {
        return 'Yesterday';
      } else if (difference.inDays < 7) {
        final days = difference.inDays;
        return '$days day${days > 1 ? 's' : ''} ago';
      } else if (difference.inDays < 30) {
        final weeks = (difference.inDays / 7).floor();
        return '$weeks week${weeks > 1 ? 's' : ''} ago';
      } else if (difference.inDays < 365) {
        final months = (difference.inDays / 30).floor();
        return '$months month${months > 1 ? 's' : ''} ago';
      } else {
        final years = (difference.inDays / 365).floor();
        return '$years year${years > 1 ? 's' : ''} ago';
      }
    }
  }

  /// Checks if a date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Checks if a date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  /// Checks if a date is tomorrow
  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }

  /// Gets the start of the day (00:00:00)
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Gets the end of the day (23:59:59)
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59);
  }

  /// Adds days to a date
  static DateTime addDays(DateTime date, int days) {
    return date.add(Duration(days: days));
  }

  /// Adds hours to a date
  static DateTime addHours(DateTime date, int hours) {
    return date.add(Duration(hours: hours));
  }

  /// Calculates age from birth date
  static int calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  /// Formats duration to human readable string
  ///
  /// Examples:
  /// - "2 hours 30 minutes"
  /// - "45 minutes"
  /// - "1 hour 15 minutes 30 seconds"
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    final parts = <String>[];

    if (hours > 0) {
      parts.add('$hours hour${hours > 1 ? 's' : ''}');
    }

    if (minutes > 0) {
      parts.add('$minutes minute${minutes > 1 ? 's' : ''}');
    }

    if (seconds > 0 && hours == 0) {
      parts.add('$seconds second${seconds > 1 ? 's' : ''}');
    }

    return parts.join(' ');
  }
}
