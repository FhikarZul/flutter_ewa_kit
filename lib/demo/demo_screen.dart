import 'package:ewa_kit/ewa_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Import the HTTP example screen
import 'http_example.dart';

// Import permission utilities
import 'package:permission_handler/permission_handler.dart';
import 'package:ewa_kit/utils/utils.dart';

class DemoScreen extends StatefulWidget {
  final VoidCallback? onThemeToggle;

  const DemoScreen({super.key, this.onThemeToggle});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EWA Kit Demo'),
        backgroundColor: EwaColorFoundation.getPrimary(context),
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: widget.onThemeToggle,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Typography Examples
              Text('Typography Examples', style: EwaTypography.headingLg()),
              const SizedBox(height: 16),

              Text('Heading 3XL', style: EwaTypography.heading3Xl()),
              const SizedBox(height: 8),

              Text('Heading 2XL', style: EwaTypography.heading2Xl()),
              const SizedBox(height: 8),

              Text('Heading XL', style: EwaTypography.headingXl()),
              const SizedBox(height: 8),

              Text('Heading LG', style: EwaTypography.headingLg()),
              const SizedBox(height: 8),

              Text('Heading MD', style: EwaTypography.heading()),
              const SizedBox(height: 8),

              Text('Heading SM', style: EwaTypography.headingSm()),
              const SizedBox(height: 8),

              Text('Heading XS', style: EwaTypography.headingXs()),
              const SizedBox(height: 16),

              Text('Body LG', style: EwaTypography.bodyLg()),
              const SizedBox(height: 8),

              Text('Body MD', style: EwaTypography.body()),
              const SizedBox(height: 8),

              Text('Body SM', style: EwaTypography.bodySm()),
              const SizedBox(height: 8),

              Text('Body XS', style: EwaTypography.bodyXs()),
              const SizedBox(height: 24),

              // Color Examples
              Text('Color Palette', style: EwaTypography.headingLg()),
              const SizedBox(height: 16),

              _buildColorRow('Primary Light', EwaColorFoundation.primaryLight),
              _buildColorRow('Primary Dark', EwaColorFoundation.primaryDark),
              _buildColorRow(
                'Secondary Light',
                EwaColorFoundation.secondaryLight,
              ),
              _buildColorRow(
                'Secondary Dark',
                EwaColorFoundation.secondaryDark,
              ),
              _buildColorRow('Error Light', EwaColorFoundation.errorLight),
              _buildColorRow('Error Dark', EwaColorFoundation.errorDark),
              const SizedBox(height: 24),

              // TextField Examples
              Text('TextField Variants', style: EwaTypography.headingLg()),
              const SizedBox(height: 16),

              EwaTextField.primary(hintText: 'Primary TextField'),
              const SizedBox(height: 16),

              EwaTextField.secondary(hintText: 'Secondary TextField'),
              const SizedBox(height: 16),

              EwaTextField.tertiary(hintText: 'Tertiary TextField'),
              const SizedBox(height: 16),

              EwaTextField.danger(hintText: 'Danger TextField'),
              const SizedBox(height: 16),

              EwaTextField.primary(
                hintText: 'Password Field',
                obscureText: true,
                prefixIcon: const Icon(Icons.lock),
              ),
              const SizedBox(height: 16),

              // Custom Border Radius Examples
              Text(
                'Custom Border Radius Examples',
                style: EwaTypography.headingLg(),
              ),
              const SizedBox(height: 16),

              EwaTextField.primary(
                hintText: 'Rounded TextField (20.0)',
                borderRadius: 20.0,
              ),
              const SizedBox(height: 16),

              EwaTextField.secondary(
                hintText: 'Pill-shaped TextField (30.0)',
                borderRadius: 30.0,
              ),
              const SizedBox(height: 16),

              EwaTextField.tertiary(
                hintText: 'Square TextField (0.0)',
                borderRadius: 0.0,
              ),
              const SizedBox(height: 24),

              // Validation Examples with EwaValidators
              Text(
                'Validation Examples with EwaValidators',
                style: EwaTypography.headingLg(),
              ),
              const SizedBox(height: 16),

              // Required Name Field with Validation
              EwaTextField.primary(
                hintText: 'Full Name (Required)',
                validator: (value) => EwaValidators.combine([
                  EwaValidators.required,
                  (val) => EwaValidators.minLength(2, val),
                ], value),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 16),

              // Required Email Field with Validation
              EwaTextField.secondary(
                hintText: 'Email (Required)',
                validator: (value) => EwaValidators.combine([
                  EwaValidators.required,
                  EwaValidators.email,
                ], value),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 16),

              // Phone Number Field
              EwaTextField.tertiary(
                hintText: 'Phone Number',
                validator: (value) => EwaValidators.phoneNumber(value),
              ),
              const SizedBox(height: 16),

              // Password Field
              EwaTextField.primary(
                hintText: 'Password',
                obscureText: true,
                prefixIcon: const Icon(Icons.lock),
                validator: (value) => EwaValidators.password(value),
              ),
              const SizedBox(height: 16),

              // Age Field with Min/Max
              EwaTextField.danger(
                hintText: 'Age (18-100)',
                validator: (value) => EwaValidators.combine([
                  EwaValidators.required,
                  EwaValidators.numeric,
                  (val) => EwaValidators.min(18, val),
                  (val) => EwaValidators.max(100, val),
                ], value),
              ),
              const SizedBox(height: 16),

              // Username Field with Length Constraints
              EwaTextField.primary(
                hintText: 'Username (3-20 chars)',
                validator: (value) => EwaValidators.combine([
                  EwaValidators.required,
                  (val) => EwaValidators.minLength(3, val),
                  (val) => EwaValidators.maxLength(20, val),
                ], value),
              ),
              const SizedBox(height: 16),

              // Currency Field with Formatter
              EwaTextField.primary(
                hintText: 'Amount',
                formatter: (value) => EwaFormatters.currencyFormatter(value),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Submit Button
              EwaButton.primary(
                label: 'Submit Form',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Form is valid, process the data
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Form submitted successfully!'),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 24),

              // Button Examples
              Text('Button Variants', style: EwaTypography.headingLg()),
              const SizedBox(height: 16),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  EwaButton.primary(label: 'Primary', onPressed: () async {}),
                  EwaButton.secondary(
                    label: 'Secondary',
                    onPressed: () async {},
                  ),
                  EwaButton.tertiary(label: 'Tertiary', onPressed: () async {}),
                  EwaButton.danger(label: 'Danger', onPressed: () async {}),
                ],
              ),
              const SizedBox(height: 24),

              // Custom Button Border Radius Examples
              Text(
                'Custom Button Border Radius',
                style: EwaTypography.headingLg(),
              ),
              const SizedBox(height: 16),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  EwaButton.primary(
                    label: 'Rounded (20)',
                    borderRadius: 20.0,
                    onPressed: () async {},
                  ),
                  EwaButton.secondary(
                    label: 'Pill (30)',
                    borderRadius: 30.0,
                    onPressed: () async {},
                  ),
                  EwaButton.tertiary(
                    label: 'Square (0)',
                    borderRadius: 0.0,
                    onPressed: () async {},
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Toast Examples
              Text('Toast Notifications', style: EwaTypography.headingLg()),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  EwaButton.primary(
                    label: 'Show Success',
                    onPressed: () async {
                      EwaToast.showSuccess(
                        context,
                        'Operation completed successfully!',
                      );
                    },
                  ),
                  EwaButton.secondary(
                    label: 'Show Error',
                    onPressed: () async {
                      EwaToast.showError(context, 'Something went wrong!');
                    },
                  ),
                  EwaButton.tertiary(
                    label: 'Show Info',
                    onPressed: () async {
                      EwaToast.showInfo(
                        context,
                        'This is an information message.',
                      );
                    },
                  ),
                  EwaButton.danger(
                    label: 'Show Warning',
                    onPressed: () async {
                      EwaToast.showWarning(
                        context,
                        'This is a warning message!',
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Dialog Examples
              Text('Dialog Examples', style: EwaTypography.headingLg()),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  EwaButton.primary(
                    label: 'Show Alert',
                    onPressed: () async {
                      if (!context.mounted) return;
                      EwaDialog.showAlert(
                        context: context,
                        title: 'Alert',
                        message: 'This is an alert dialog.',
                      );
                    },
                  ),
                  EwaButton.secondary(
                    label: 'Show Confirmation',
                    onPressed: () async {
                      if (!context.mounted) return;
                      final result = await EwaDialog.showConfirmation(
                        context: context,
                        title: 'Confirm',
                        message: 'Are you sure you want to proceed?',
                      );
                      if (!context.mounted) return;
                      if (result == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Confirmed!')),
                        );
                      }
                    },
                  ),
                  EwaButton.tertiary(
                    label: 'Show Custom Dialog',
                    onPressed: () async {
                      if (!context.mounted) return;
                      EwaDialog.show(
                        context: context,
                        title: 'Custom Dialog',
                        message: 'This is a custom dialog with custom actions.',
                        primaryAction: EwaDialogAction(
                          label: 'OK',
                          onPressed: () => Navigator.pop(context),
                        ),
                        secondaryAction: EwaDialogAction(
                          label: 'Cancel',
                          onPressed: () => Navigator.pop(context),
                        ),
                        tertiaryAction: EwaDialogAction(
                          label: 'More',
                          onPressed: () {
                            // Custom action
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Loading Examples
              Text('Loading Animations', style: EwaTypography.headingLg()),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  Column(
                    children: [
                      EwaLoading.bouncingDots(size: 30),
                      const SizedBox(height: 8),
                      Text('Bouncing Dots', style: EwaTypography.bodySm()),
                    ],
                  ),
                  Column(
                    children: [
                      EwaLoading.wave(size: 30),
                      const SizedBox(height: 8),
                      Text('Wave', style: EwaTypography.bodySm()),
                    ],
                  ),
                  Column(
                    children: [
                      EwaLoading.circularProgress(size: 30),
                      const SizedBox(height: 8),
                      Text('Circular Progress', style: EwaTypography.bodySm()),
                    ],
                  ),
                  Column(
                    children: [
                      EwaLoading.pulse(size: 30),
                      const SizedBox(height: 8),
                      Text('Pulse', style: EwaTypography.bodySm()),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              EwaLoading.bouncingDots(label: 'Loading data...', size: 40),
              const SizedBox(height: 24),

              // Bottom Sheet Examples
              Text('Bottom Sheet Examples', style: EwaTypography.headingLg()),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  EwaButton.primary(
                    label: 'Show Options',
                    onPressed: () async {
                      await EwaBottomSheet.showOptions(
                        context: context,
                        title: 'Choose an Option',
                        options: [
                          EwaBottomSheetOption(
                            title: 'Option 1',
                            subtitle: 'This is the first option',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Selected Option 1'),
                                ),
                              );
                            },
                          ),
                          EwaBottomSheetOption(
                            title: 'Option 2',
                            subtitle: 'This is the second option',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Selected Option 2'),
                                ),
                              );
                            },
                          ),
                          EwaBottomSheetOption(
                            title: 'Delete',
                            subtitle: 'This action cannot be undone',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Delete action selected'),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  EwaButton.secondary(
                    label: 'Show Custom',
                    onPressed: () async {
                      await EwaBottomSheet.show(
                        context: context,
                        title: 'Custom Content',
                        content: Container(
                          padding: EdgeInsets.all(16.sp),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'This is custom content in the bottom sheet',
                                style: EwaTypography.body(),
                              ),
                              const SizedBox(height: 16),
                              EwaTextField.primary(hintText: 'Enter some text'),
                            ],
                          ),
                        ),
                        actions: [
                          EwaBottomSheetAction(
                            label: 'Cancel',
                            onPressed: () => Navigator.pop(context),
                          ),
                          EwaBottomSheetAction(
                            label: 'Save',
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Saved!')),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Lazy Load Example
              Text('Lazy Load Example', style: EwaTypography.headingLg()),
              const SizedBox(height: 16),
              SizedBox(
                height: 300.h,
                child: EwaLazyLoad(
                  page: 1,
                  totalPage: 3,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        'Item ${index + 1}',
                        style: EwaTypography.body(),
                      ),
                      subtitle: Text(
                        'Subtitle for item ${index + 1}',
                        style: EwaTypography.bodySm(),
                      ),
                      leading: Container(
                        width: 40.r,
                        height: 40.r,
                        color: EwaColorFoundation.primaryLight,
                        child: Center(child: Text('${index + 1}')),
                      ),
                    );
                  },
                  onChanged: (page) {
                    // Handle page change
                  },
                  isLoading: false,
                  onRefresh: () async {
                    // Handle refresh
                  },
                  emptyMessage: 'Tidak ada data tersedia',
                ),
              ),
              const SizedBox(height: 24),

              // DateTime Converter Example
              Text(
                'DateTime Converter Examples',
                style: EwaTypography.headingLg(),
              ),
              const SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: EwaColorFoundation.neutral50,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: EwaColorFoundation.neutral200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Time (International): ${EwaDateTimeConverter.formatToFullDateTime(DateTime.now())}',
                      style: EwaTypography.body(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Current Time (Indonesian): ${EwaDateTimeConverter.formatToFullIndonesianDateTime(DateTime.now())}',
                      style: EwaTypography.body(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Time Ago (English): ${EwaDateTimeConverter.getTimeAgo(DateTime.now().subtract(const Duration(hours: 2)))}',
                      style: EwaTypography.body(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Time Ago (Indonesian): ${EwaDateTimeConverter.getTimeAgo(DateTime.now().subtract(const Duration(hours: 2)), useIndonesian: true)}',
                      style: EwaTypography.body(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Parsed Date: ${EwaDateTimeConverter.parse("2023-12-25")?.toIso8601String() ?? "Invalid date"}',
                      style: EwaTypography.body(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Age Calculation: ${EwaDateTimeConverter.calculateAge(DateTime(1990, 1, 1))} years old',
                      style: EwaTypography.body(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Indonesian Day: ${EwaDateTimeConverter.getIndonesianDayName(DateTime.now())}',
                      style: EwaTypography.body(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Indonesian Month: ${EwaDateTimeConverter.getIndonesianMonthName(DateTime.now())}',
                      style: EwaTypography.body(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Logger Example
              Text('Logger Examples', style: EwaTypography.headingLg()),
              const SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: EwaColorFoundation.neutral50,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: EwaColorFoundation.neutral200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Check the console output for logged messages',
                      style: EwaTypography.body(),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        EwaButton.primary(
                          label: 'Log Info',
                          onPressed: () async {
                            EwaLogger.info('This is an info message');
                          },
                        ),
                        EwaButton.secondary(
                          label: 'Log Warning',
                          onPressed: () async {
                            EwaLogger.warn('This is a warning message');
                          },
                        ),
                        EwaButton.danger(
                          label: 'Log Error',
                          onPressed: () async {
                            EwaLogger.error('This is an error message');
                          },
                        ),
                        EwaButton.tertiary(
                          label: 'Log Debug',
                          onPressed: () async {
                            EwaLogger.debug('This is a debug message');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Image Examples
              const SizedBox(height: 32),
              Text('Image Examples', style: EwaTypography.headingLg()),
              const SizedBox(height: 16),
              // Network image with caching
              Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: EwaColorFoundation.neutral200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: EwaImage.network(
                    imageUrl: 'https://picsum.photos/536/354',
                    width: 150,
                    height: 150,
                    borderRadius: 12.0,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Network image with custom placeholder and error widgets
              Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: EwaColorFoundation.neutral200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: EwaImage.network(
                    imageUrl: 'https://invalid-url-for-test.com/image.jpg',
                    width: 150,
                    height: 150,
                    placeholder: Container(
                      width: 150,
                      height: 150,
                      color: EwaColorFoundation.neutral100,
                      child: const Icon(Icons.image, color: Colors.grey),
                    ),
                    errorWidget: Container(
                      width: 150,
                      height: 150,
                      color: EwaColorFoundation.errorLight.withOpacity(0.1),
                      child: const Icon(Icons.broken_image, color: Colors.red),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Asset image
              Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: EwaColorFoundation.neutral200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: EwaImage.asset(
                    assetPath:
                        'assets/images/placeholder.png', // This will show error widget since asset doesn't exist
                    width: 150,
                    height: 150,
                    borderRadius: 8.0,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Network image with no progress indicator
              Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: EwaColorFoundation.neutral200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: EwaImage.network(
                    imageUrl:
                        'https://via.placeholder.com/150/4a86e8/FFFFFF?text=No+Progress',
                    width: 150,
                    height: 150,
                    showProgressIndicator: false,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text('HTTP Client Example', style: EwaTypography.headingLg()),
              const SizedBox(height: 16),
              EwaButton.primary(
                label: 'Open HTTP Client Demo',
                onPressed: () async {
                  // Navigate to HTTP client example
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HttpExampleScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),

              // Permission Utilities Example
              Text(
                'Permission Utilities Example',
                style: EwaTypography.headingLg(),
              ),
              const SizedBox(height: 16),
              // Permission widget for camera
              Container(
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: EwaColorFoundation.neutral200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: EwaPermissionWidget(
                    permission: Permission.camera,
                    title: 'Camera Access',
                    description: 'This app needs camera access to take photos',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Permission widget for storage
              Container(
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: EwaColorFoundation.neutral200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: EwaPermissionWidget(
                    permission: Permission.storage,
                    title: 'Storage Access',
                    description: 'This app needs storage access to save files',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Button to request multiple permissions
              EwaButton.primary(
                label: 'Request Multiple Permissions',
                onPressed: () async {
                  await EwaPermissionHelper.requestPermissions([
                    Permission.camera,
                    Permission.storage,
                    Permission.location,
                  ], context: context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorRow(String name, Color color) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey),
          ),
        ),
        const SizedBox(width: 12),
        Text(name, style: EwaTypography.body()),
      ],
    );
  }
}
