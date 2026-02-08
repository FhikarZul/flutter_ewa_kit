import 'package:ewa_kit/ewa_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConnectivityExampleScreen extends StatelessWidget {
  const ConnectivityExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connectivity Demo'),
        backgroundColor: EwaColorFoundation.getPrimary(context),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'EwaConnectivityWidget',
              style: EwaTypography.headingLg(),
            ),
            SizedBox(height: 12.h),
            Text(
              'English (default)',
              style: EwaTypography.bodySm().copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 8.h),
            const EwaConnectivityWidget(useIndonesian: false),
            SizedBox(height: 24.h),
            Text(
              'Indonesian',
              style: EwaTypography.bodySm().copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 8.h),
            const EwaConnectivityWidget(useIndonesian: true),
            SizedBox(height: 24.h),
            Text(
              'Compact mode',
              style: EwaTypography.bodySm().copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 8.h),
            const EwaConnectivityWidget(compact: true, useIndonesian: true),
            SizedBox(height: 32.h),
            Text(
              'EwaConnectivityBanner',
              style: EwaTypography.headingLg(),
            ),
            SizedBox(height: 12.h),
            Text(
              'Banner shows when offline. Content below:',
              style: EwaTypography.bodySm().copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              height: 200.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: EwaConnectivityBanner(
                useIndonesian: true,
                child: Center(
                  child: Text(
                    'Your content here',
                    style: EwaTypography.body(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
