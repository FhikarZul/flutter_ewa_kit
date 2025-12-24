import 'package:ewa_kit/ui/dialog/ewa_dialog.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// EWA Kit Permission Helper for handling device permissions with UI
class EwaPermissionHelper {
  /// Request a single permission with EWA Kit UI
  static Future<bool> requestPermission(
    Permission permission, {
    required BuildContext context,
    String title = 'Permission Required',
    String message = 'This app needs permission to access this feature',
    String okButton = 'Allow',
    String cancelButton = 'Cancel',
  }) async {
    // Check current permission status
    var status = await permission.status;

    if (status == PermissionStatus.granted) {
      return true;
    }

    // If permission is denied, show rationale dialog
    if (status == PermissionStatus.denied) {
      status = await permission.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else if (status == PermissionStatus.denied) {
        // Permission still denied
        return false;
      } else if (status == PermissionStatus.permanentlyDenied) {
        if (context.mounted) {
          // Show dialog to guide user to settings
          final result = await EwaDialog.showConfirmation(
            context: context,
            title: title,
            message: message,
            yesLabel: 'Open Settings',
            noLabel: 'Cancel',
          );

          if (result == true) {
            await openAppSettings();
            // Check permission again after opening settings
            final newStatus = await permission.status;
            return newStatus == PermissionStatus.granted;
          }
        }
      }
    }

    return false;
  }

  /// Request multiple permissions with EWA Kit UI
  static Future<Map<Permission, bool>> requestPermissions(
    List<Permission> permissions, {
    required BuildContext context,
    String title = 'Permissions Required',
    String message = 'This app needs several permissions to function properly',
    String okButton = 'Allow All',
    String cancelButton = 'Cancel',
  }) async {
    final results = <Permission, bool>{};

    for (final permission in permissions) {
      results[permission] = await requestPermission(
        permission,
        context: context,
        title: title,
        message: message,
        okButton: okButton,
        cancelButton: cancelButton,
      );
    }

    return results;
  }

  /// Check if a permission is granted
  static Future<bool> isPermissionGranted(Permission permission) async {
    final status = await permission.status;
    return status == PermissionStatus.granted;
  }

  /// Check if a permission is denied
  static Future<bool> isPermissionDenied(Permission permission) async {
    final status = await permission.status;
    return status == PermissionStatus.denied;
  }

  /// Check if a permission is permanently denied
  static Future<bool> isPermissionPermanentlyDenied(
    Permission permission,
  ) async {
    final status = await permission.status;
    return status == PermissionStatus.permanentlyDenied;
  }

  /// Check if a permission is in restricted state
  static Future<bool> isPermissionRestricted(Permission permission) async {
    final status = await permission.status;
    return status == PermissionStatus.restricted;
  }

  /// Request camera permission with EWA Kit UI
  static Future<bool> requestCameraPermission({
    required BuildContext context,
  }) async {
    return await requestPermission(
      Permission.camera,
      context: context,
      title: 'Camera Permission Required',
      message: 'This app needs access to your camera to take photos',
    );
  }

  /// Request gallery/storage permission with EWA Kit UI
  static Future<bool> requestStoragePermission({
    required BuildContext context,
  }) async {
    return await requestPermission(
      Permission.storage,
      context: context,
      title: 'Storage Permission Required',
      message: 'This app needs access to your storage to save files',
    );
  }

  /// Request location permission with EWA Kit UI
  static Future<bool> requestLocationPermission({
    required BuildContext context,
  }) async {
    return await requestPermission(
      Permission.location,
      context: context,
      title: 'Location Permission Required',
      message: 'This app needs access to your location',
    );
  }

  /// Request microphone permission with EWA Kit UI
  static Future<bool> requestMicrophonePermission({
    required BuildContext context,
  }) async {
    return await requestPermission(
      Permission.microphone,
      context: context,
      title: 'Microphone Permission Required',
      message: 'This app needs access to your microphone',
    );
  }

  /// Request notification permission with EWA Kit UI
  static Future<bool> requestNotificationPermission({
    required BuildContext context,
  }) async {
    return await requestPermission(
      Permission.notification,
      context: context,
      title: 'Notification Permission Required',
      message: 'This app needs permission to send notifications',
    );
  }
}
