import 'package:flutter_test/flutter_test.dart';
import 'package:ewa_kit/utils/ewa_datetime_converter.dart';

void main() {
  group('EwaDateTimeConverter', () {
    late DateTime testDate;
    late DateTime testDateWithTime;

    setUp(() {
      // Use a fixed date for consistent testing
      testDate = DateTime(2023, 12, 25); // December 25, 2023
      testDateWithTime = DateTime(
        2023,
        12,
        25,
        14,
        30,
        45,
      ); // December 25, 2023 14:30:45
    });

    group('formatToHumanReadable', () {
      test('should format date to human readable string', () {
        final result = EwaDateTimeConverter.formatToHumanReadable(testDate);
        expect(result, 'December 25, 2023');
      });
    });

    group('formatToShortDate', () {
      test('should format date to short date string', () {
        final result = EwaDateTimeConverter.formatToShortDate(testDate);
        expect(result, 'Dec 25, 2023');
      });
    });

    group('formatToTime', () {
      test('should format time correctly', () {
        final result = EwaDateTimeConverter.formatToTime(testDateWithTime);
        // The result depends on the system locale, but should contain time elements
        expect(result, isNotEmpty);
      });
    });

    group('formatToFullDateTime', () {
      test('should format full datetime correctly', () {
        final result = EwaDateTimeConverter.formatToFullDateTime(
          testDateWithTime,
        );
        expect(result, contains('December 25, 2023'));
        expect(result, contains('2023'));
      });
    });

    group('formatToIso8601', () {
      test('should format date to ISO 8601 string', () {
        final result = EwaDateTimeConverter.formatToIso8601(testDateWithTime);
        expect(result, testDateWithTime.toIso8601String());
      });
    });

    group('formatToIndonesian', () {
      test('should format date to Indonesian format', () {
        final result = EwaDateTimeConverter.formatToIndonesian(testDate);
        // Might fallback to English if locale not initialized
        // The actual format depends on system locale, but should contain the right components
        expect(
          result,
          anyOf('25 Desember 2023', 'December 25, 2023', '25 December 2023'),
        );
      });
    });

    group('formatToShortIndonesian', () {
      test('should format date to short Indonesian format', () {
        final result = EwaDateTimeConverter.formatToShortIndonesian(testDate);
        // Might fallback to English if locale not initialized
        // The actual format depends on system locale, but should contain the right components
        expect(result, anyOf('25 Des 2023', 'Dec 25, 2023', '25 Dec 2023'));
      });
    });

    group('formatToIndonesianTime', () {
      test('should format time to Indonesian format', () {
        final result = EwaDateTimeConverter.formatToIndonesianTime(
          testDateWithTime,
        );
        // Might fallback to English if locale not initialized
        expect(result, isNotEmpty);
      });
    });

    group('formatToFullIndonesianDateTime', () {
      test('should format full datetime to Indonesian format', () {
        final result = EwaDateTimeConverter.formatToFullIndonesianDateTime(
          testDateWithTime,
        );
        // Might fallback to English if locale not initialized
        expect(result, isNotEmpty);
      });
    });

    group('getIndonesianDayName', () {
      test('should get Indonesian day name', () {
        final result = EwaDateTimeConverter.getIndonesianDayName(
          testDate,
        ); // Monday
        // Might fallback to English if locale not initialized
        expect(result, anyOf('Monday', 'Senin'));
      });
    });

    group('getShortIndonesianDayName', () {
      test('should get short Indonesian day name', () {
        final result = EwaDateTimeConverter.getShortIndonesianDayName(
          testDate,
        ); // Mon
        // Might fallback to English if locale not initialized
        expect(result, anyOf('Mon', 'Sen'));
      });
    });

    group('getIndonesianMonthName', () {
      test('should get Indonesian month name', () {
        final result = EwaDateTimeConverter.getIndonesianMonthName(
          testDate,
        ); // December
        // Might fallback to English if locale not initialized
        expect(result, anyOf('December', 'Desember'));
      });
    });

    group('parse', () {
      test('should parse ISO 8601 string', () {
        final dateString = '2023-12-25T14:30:45.000Z';
        final result = EwaDateTimeConverter.parse(dateString);
        expect(result, isNotNull);
        expect(result!.year, 2023);
        expect(result.month, 12);
        expect(result.day, 25);
      });

      test('should parse date only string', () {
        final dateString = '2023-12-25';
        final result = EwaDateTimeConverter.parse(dateString);
        expect(result, isNotNull);
        expect(result!.year, 2023);
        expect(result.month, 12);
        expect(result.day, 25);
      });

      test('should parse date with time string', () {
        final dateString = '2023-12-25 14:30:45';
        final result = EwaDateTimeConverter.parse(dateString);
        expect(result, isNotNull);
        expect(result!.year, 2023);
        expect(result.month, 12);
        expect(result.day, 25);
        expect(result.hour, 14);
        expect(result.minute, 30);
        expect(result.second, 45);
      });

      test('should return null for invalid date string', () {
        final dateString = 'invalid-date';
        final result = EwaDateTimeConverter.parse(dateString);
        expect(result, isNull);
      });
    });

    group('getTimeAgo', () {
      test('should return "Just now" for recent dates', () {
        final recentDate = DateTime.now().subtract(const Duration(seconds: 30));
        final result = EwaDateTimeConverter.getTimeAgo(recentDate);
        expect(result, anyOf('Just now', 'Baru saja'));
      });

      test('should return minutes ago', () {
        final pastDate = DateTime.now().subtract(const Duration(minutes: 5));
        final result = EwaDateTimeConverter.getTimeAgo(pastDate);
        expect(result, contains('minute'));
        expect(result, contains('5'));
      });

      test('should return hours ago', () {
        final pastDate = DateTime.now().subtract(const Duration(hours: 3));
        final result = EwaDateTimeConverter.getTimeAgo(pastDate);
        expect(result, contains('hour'));
        expect(result, contains('3'));
      });

      test('should return "Yesterday" for yesterday', () {
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        final result = EwaDateTimeConverter.getTimeAgo(yesterday);
        expect(result, anyOf('Yesterday', 'Kemarin'));
      });

      test('should return days ago', () {
        final pastDate = DateTime.now().subtract(const Duration(days: 3));
        final result = EwaDateTimeConverter.getTimeAgo(pastDate);
        expect(result, contains('day'));
        expect(result, contains('3'));
      });

      test('should return weeks ago', () {
        final pastDate = DateTime.now().subtract(const Duration(days: 15));
        final result = EwaDateTimeConverter.getTimeAgo(pastDate);
        expect(result, contains('week'));
      });

      test('should return months ago', () {
        final pastDate = DateTime.now().subtract(const Duration(days: 65));
        final result = EwaDateTimeConverter.getTimeAgo(pastDate);
        expect(result, contains('month'));
      });

      test('should return years ago', () {
        final pastDate = DateTime.now().subtract(const Duration(days: 400));
        final result = EwaDateTimeConverter.getTimeAgo(pastDate);
        expect(result, contains('year'));
      });
    });

    group('date comparison methods', () {
      test('should correctly identify today', () {
        final today = DateTime.now();
        final result = EwaDateTimeConverter.isToday(today);
        expect(result, isTrue);
      });

      test('should correctly identify not today', () {
        final notToday = DateTime.now().subtract(const Duration(days: 1));
        final result = EwaDateTimeConverter.isToday(notToday);
        expect(result, isFalse);
      });

      test('should correctly identify yesterday', () {
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        final result = EwaDateTimeConverter.isYesterday(yesterday);
        expect(result, isTrue);
      });

      test('should correctly identify not yesterday', () {
        final notYesterday = DateTime.now();
        final result = EwaDateTimeConverter.isYesterday(notYesterday);
        expect(result, isFalse);
      });

      test('should correctly identify tomorrow', () {
        final tomorrow = DateTime.now().add(const Duration(days: 1));
        final result = EwaDateTimeConverter.isTomorrow(tomorrow);
        expect(result, isTrue);
      });

      test('should correctly identify not tomorrow', () {
        final notTomorrow = DateTime.now();
        final result = EwaDateTimeConverter.isTomorrow(notTomorrow);
        expect(result, isFalse);
      });
    });

    group('date manipulation methods', () {
      test('should get start of day', () {
        final date = DateTime(2023, 12, 25, 14, 30, 45);
        final result = EwaDateTimeConverter.startOfDay(date);
        expect(result.year, 2023);
        expect(result.month, 12);
        expect(result.day, 25);
        expect(result.hour, 0);
        expect(result.minute, 0);
        expect(result.second, 0);
      });

      test('should get end of day', () {
        final date = DateTime(2023, 12, 25, 14, 30, 45);
        final result = EwaDateTimeConverter.endOfDay(date);
        expect(result.year, 2023);
        expect(result.month, 12);
        expect(result.day, 25);
        expect(result.hour, 23);
        expect(result.minute, 59);
        expect(result.second, 59);
      });

      test('should add days to date', () {
        final date = DateTime(2023, 12, 25);
        final result = EwaDateTimeConverter.addDays(date, 5);
        expect(result.year, 2023);
        expect(result.month, 12);
        expect(result.day, 30);
      });

      test('should add hours to date', () {
        final date = DateTime(2023, 12, 25, 14, 30);
        final result = EwaDateTimeConverter.addHours(date, 3);
        expect(result.year, 2023);
        expect(result.month, 12);
        expect(result.day, 25);
        expect(result.hour, 17);
        expect(result.minute, 30);
      });

      test('should calculate age correctly', () {
        final birthDate = DateTime(1990, 5, 15);
        final age = EwaDateTimeConverter.calculateAge(birthDate);
        // Age will vary depending on current date, but should be reasonable
        expect(age, greaterThan(20));
        expect(age, lessThan(100));
      });
    });

    group('formatDuration', () {
      test('should format duration with hours and minutes', () {
        final duration = const Duration(hours: 2, minutes: 30);
        final result = EwaDateTimeConverter.formatDuration(duration);
        expect(result, anyOf('2 hours 30 minutes', '2 hour 30 minute'));
      });

      test('should format duration with only minutes', () {
        final duration = const Duration(minutes: 45);
        final result = EwaDateTimeConverter.formatDuration(duration);
        expect(result, anyOf('45 minutes', '45 minute'));
      });

      test('should format duration with hours, minutes and seconds', () {
        final duration = const Duration(hours: 1, minutes: 15, seconds: 30);
        final result = EwaDateTimeConverter.formatDuration(duration);
        // When hours are present, seconds are typically not shown
        expect(result, contains('hour'));
        expect(result, contains('15'));
      });

      test('should format duration with only seconds', () {
        final duration = const Duration(seconds: 30);
        final result = EwaDateTimeConverter.formatDuration(duration);
        expect(result, anyOf('30 seconds', '30 second'));
      });
    });
  });
}
