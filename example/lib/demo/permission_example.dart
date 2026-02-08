import 'package:ewa_kit/ewa_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionExampleScreen extends StatelessWidget {
  const PermissionExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permission Demo'),
        backgroundColor: EwaColorFoundation.getPrimary(context),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Single Permission (EwaPermissionWidget)',
              style: EwaTypography.headingLg(),
            ),
            SizedBox(height: 12.h),
            EwaPermissionWidget(
              permission: Permission.camera,
              title: 'Camera',
              description:
                  'This app needs camera access to take photos and scan QR codes.',
              onStatusChanged: (status) {
                EwaToast.showInfo(
                  context,
                  'Camera permission: ${status.name}',
                );
              },
            ),
            SizedBox(height: 24.h),
            Text(
              'Multiple Permissions (EwaPermissionsWidget)',
              style: EwaTypography.headingLg(),
            ),
            SizedBox(height: 12.h),
            EwaPermissionsWidget(
              title: 'Required Permissions',
              description:
                  'The following permissions are needed for the app to work properly.',
              permissions: [
                EwaPermissionData(
                  permission: Permission.camera,
                  title: 'Camera',
                  description: 'Take photos and scan QR codes',
                ),
                EwaPermissionData(
                  permission: Permission.photos,
                  title: 'Photos',
                  description: 'Access your photo library',
                ),
                EwaPermissionData(
                  permission: Permission.notification,
                  title: 'Notifications',
                  description: 'Send you important updates',
                ),
              ],
              onStatusChanged: (statuses) {
                final granted = statuses.values
                    .where((s) => s == PermissionStatus.granted)
                    .length;
                EwaToast.showInfo(
                  context,
                  '$granted of ${statuses.length} permissions granted',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
