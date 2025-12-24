import 'package:ewa_kit/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  group('EwaPermissionHelper Tests', () {
    test('EwaPermissionHelper should be defined', () {
      expect(EwaPermissionHelper, isNotNull);
    });

    test('Permission helper methods should be accessible', () {
      expect(EwaPermissionHelper.isPermissionGranted, isNotNull);
      expect(EwaPermissionHelper.isPermissionDenied, isNotNull);
      expect(EwaPermissionHelper.isPermissionPermanentlyDenied, isNotNull);
      expect(EwaPermissionHelper.isPermissionRestricted, isNotNull);
      expect(EwaPermissionHelper.requestCameraPermission, isNotNull);
      expect(EwaPermissionHelper.requestStoragePermission, isNotNull);
      expect(EwaPermissionHelper.requestLocationPermission, isNotNull);
      expect(EwaPermissionHelper.requestMicrophonePermission, isNotNull);
      expect(EwaPermissionHelper.requestNotificationPermission, isNotNull);
    });

    test('Permission data class should be properly defined', () {
      final permissionData = EwaPermissionData(
        permission: Permission.camera,
        title: 'Camera',
        description: 'Need camera access',
        buttonText: 'Allow',
      );

      expect(permissionData.permission, Permission.camera);
      expect(permissionData.title, 'Camera');
      expect(permissionData.description, 'Need camera access');
      expect(permissionData.buttonText, 'Allow');
    });
  });

  group('EwaPermissionWidget Tests', () {
    test('Permission helper methods should be defined', () {
      expect(EwaPermissionHelper.requestPermission, isNotNull);
      expect(EwaPermissionHelper.requestPermissions, isNotNull);
    });

    test('EwaPermissionData should be properly defined', () {
      final permissionData = EwaPermissionData(
        permission: Permission.camera,
        title: 'Camera',
        description: 'Need camera access',
      );

      expect(permissionData.permission, Permission.camera);
      expect(permissionData.title, 'Camera');
      expect(permissionData.description, 'Need camera access');
    });
  });
}
