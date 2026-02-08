import 'package:ewa_kit/ewa_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Demo images from picsum.photos (placeholder images)
const _sampleUrls = [
  'https://picsum.photos/200/300',
  'https://picsum.photos/300/200',
  'https://picsum.photos/250/250',
  'https://picsum.photos/400/300',
];

class ImageExampleScreen extends StatelessWidget {
  const ImageExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Example'),
        backgroundColor: EwaColorFoundation.getPrimary(context),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Network Image with Cache',
              style: EwaTypography.headingLg(),
            ),
            SizedBox(height: 8.h),
            Text(
              'EwaImage loads and caches network images with placeholder and error handling.',
              style: EwaTypography.bodySm().copyWith(
                color: EwaColorFoundation.neutral600,
              ),
            ),
            SizedBox(height: 24.h),
            Text('Single Image', style: EwaTypography.headingSm()),
            SizedBox(height: 12.h),
            EwaImage.network(
              imageUrl: _sampleUrls[0],
              width: double.infinity,
              height: 200.h,
              fit: BoxFit.cover,
              borderRadius: 12,
            ),
            SizedBox(height: 24.h),
            Text('Image Grid', style: EwaTypography.headingSm()),
            SizedBox(height: 12.h),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 0.75,
              ),
              itemCount: _sampleUrls.length,
              itemBuilder: (context, index) {
                return EwaImage.network(
                  imageUrl: _sampleUrls[index],
                  fit: BoxFit.cover,
                  borderRadius: 8,
                );
              },
            ),
            SizedBox(height: 24.h),
            Text('Invalid URL (Error State)', style: EwaTypography.headingSm()),
            SizedBox(height: 12.h),
            EwaImage.network(
              imageUrl: 'https://invalid-url-that-will-fail.com/image.jpg',
              width: double.infinity,
              height: 150.h,
              fit: BoxFit.cover,
              borderRadius: 8,
            ),
          ],
        ),
      ),
    );
  }
}
