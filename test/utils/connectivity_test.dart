import 'package:flutter_test/flutter_test.dart';
import 'package:ewa_kit/utils/connectivity/ewa_connectivity_checker.dart';

void main() {
  group('EwaConnectivityChecker', () {
    test('should be a singleton', () {
      final instance1 = EwaConnectivityChecker.instance;
      final instance2 = EwaConnectivityChecker.instance;
      expect(instance1, same(instance2));
    });

    test('should have initial offline status', () {
      final checker = EwaConnectivityChecker.instance;
      expect(checker.currentStatus, EwaConnectivityStatus.offline);
    });

    test('should provide connectivity stream', () {
      final checker = EwaConnectivityChecker.instance;
      expect(checker.connectivityStream, isNotNull);
      expect(checker.connectivityStream, isA<Stream<EwaConnectivityStatus>>());
    });

    group('Status Description', () {
      test('should return English descriptions by default', () {
        final checker = EwaConnectivityChecker.instance;

        expect(
          checker.getStatusDescription(EwaConnectivityStatus.wifi),
          'Connected to WiFi',
        );
        expect(
          checker.getStatusDescription(EwaConnectivityStatus.mobile),
          'Connected to Mobile Data',
        );
        expect(
          checker.getStatusDescription(EwaConnectivityStatus.ethernet),
          'Connected to Ethernet',
        );
        expect(
          checker.getStatusDescription(EwaConnectivityStatus.vpn),
          'Connected to VPN',
        );
        expect(
          checker.getStatusDescription(EwaConnectivityStatus.bluetooth),
          'Connected to Bluetooth',
        );
        expect(
          checker.getStatusDescription(EwaConnectivityStatus.noInternet),
          'No Internet Connection',
        );
        expect(
          checker.getStatusDescription(EwaConnectivityStatus.offline),
          'Offline',
        );
      });

      test('should return Indonesian descriptions when requested', () {
        final checker = EwaConnectivityChecker.instance;

        expect(
          checker.getStatusDescription(
            EwaConnectivityStatus.wifi,
            useIndonesian: true,
          ),
          'Terhubung ke WiFi',
        );
        expect(
          checker.getStatusDescription(
            EwaConnectivityStatus.mobile,
            useIndonesian: true,
          ),
          'Terhubung ke Data Seluler',
        );
        expect(
          checker.getStatusDescription(
            EwaConnectivityStatus.ethernet,
            useIndonesian: true,
          ),
          'Terhubung ke Ethernet',
        );
        expect(
          checker.getStatusDescription(
            EwaConnectivityStatus.vpn,
            useIndonesian: true,
          ),
          'Terhubung ke VPN',
        );
        expect(
          checker.getStatusDescription(
            EwaConnectivityStatus.bluetooth,
            useIndonesian: true,
          ),
          'Terhubung ke Bluetooth',
        );
        expect(
          checker.getStatusDescription(
            EwaConnectivityStatus.noInternet,
            useIndonesian: true,
          ),
          'Tidak Ada Koneksi Internet',
        );
        expect(
          checker.getStatusDescription(
            EwaConnectivityStatus.offline,
            useIndonesian: true,
          ),
          'Offline',
        );
      });
    });

    group('EwaConnectivityStatus', () {
      test('should have all expected status values', () {
        expect(EwaConnectivityStatus.values.length, 7);
        expect(
          EwaConnectivityStatus.values,
          contains(EwaConnectivityStatus.wifi),
        );
        expect(
          EwaConnectivityStatus.values,
          contains(EwaConnectivityStatus.mobile),
        );
        expect(
          EwaConnectivityStatus.values,
          contains(EwaConnectivityStatus.ethernet),
        );
        expect(
          EwaConnectivityStatus.values,
          contains(EwaConnectivityStatus.vpn),
        );
        expect(
          EwaConnectivityStatus.values,
          contains(EwaConnectivityStatus.bluetooth),
        );
        expect(
          EwaConnectivityStatus.values,
          contains(EwaConnectivityStatus.noInternet),
        );
        expect(
          EwaConnectivityStatus.values,
          contains(EwaConnectivityStatus.offline),
        );
      });
    });
  });
}
