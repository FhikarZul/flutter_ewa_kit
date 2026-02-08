import 'package:ewa_kit/ewa_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'connectivity_example.dart';
import 'http_example.dart';
import 'image_example.dart';
import 'lazy_load_example.dart';
import 'login_example.dart';
import 'permission_example.dart';
import 'select_example.dart';

class DemoScreen extends StatefulWidget {
  final VoidCallback? onThemeToggle;

  const DemoScreen({super.key, this.onThemeToggle});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedCountry;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _navigateTo(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EWA Kit Demo'),
        backgroundColor: EwaColorFoundation.getPrimary(context),
        foregroundColor: Colors.white,
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
        padding: EdgeInsets.all(16.r),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Section(
                title: 'Typography',
                children: [
                  Text('Heading 3XL', style: EwaTypography.heading3Xl()),
                  SizedBox(height: 8.h),
                  Text('Heading LG', style: EwaTypography.headingLg()),
                  SizedBox(height: 8.h),
                  Text('Body', style: EwaTypography.body()),
                  SizedBox(height: 8.h),
                  Text('Body Small', style: EwaTypography.bodySm()),
                ],
              ),
              _Section(
                title: 'Button Variants',
                children: [
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      EwaButton.primary(label: 'Primary', onPressed: () async {}),
                      EwaButton.secondary(
                        label: 'Secondary',
                        onPressed: () async {},
                      ),
                      EwaButton.tertiary(
                        label: 'Tertiary',
                        onPressed: () async {},
                      ),
                      EwaButton.danger(
                        label: 'Danger',
                        onPressed: () async {},
                      ),
                    ],
                  ),
                ],
              ),
              _Section(
                title: 'Button Sizes',
                children: [
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      EwaButton.primary(
                        label: 'XS',
                        size: EwaButtonSize.xs,
                        onPressed: () async {},
                      ),
                      EwaButton.primary(
                        label: 'SM',
                        size: EwaButtonSize.sm,
                        onPressed: () async {},
                      ),
                      EwaButton.primary(
                        label: 'MD',
                        size: EwaButtonSize.md,
                        onPressed: () async {},
                      ),
                      EwaButton.primary(
                        label: 'LG',
                        size: EwaButtonSize.lg,
                        onPressed: () async {},
                      ),
                      EwaButton.primary(
                        label: 'XL',
                        size: EwaButtonSize.xl,
                        onPressed: () async {},
                      ),
                    ],
                  ),
                ],
              ),
              _Section(
                title: 'TextField',
                children: [
                  EwaTextField.primary(
                    hintText: 'Primary - Enter email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(Icons.email_outlined, size: 20.sp),
                  ),
                  SizedBox(height: 12.h),
                  EwaTextField.secondary(
                    hintText: 'Secondary variant',
                  ),
                  SizedBox(height: 12.h),
                  EwaTextField.tertiary(
                    hintText: 'Tertiary variant',
                  ),
                  SizedBox(height: 12.h),
                  EwaTextField.primary(
                    hintText: 'Password (obscure)',
                    controller: _passwordController,
                    obscureText: true,
                    suffixIcon: Icon(Icons.lock_outline, size: 20.sp),
                    validator: (v) =>
                        (v == null || v.length < 6)
                            ? 'Min 6 characters'
                            : null,
                  ),
                ],
              ),
              _Section(
                title: 'Select',
                children: [
                  EwaSelect<String>(
                    labelText: 'Country',
                    hintText: 'Pilih negara',
                    items: const [
                      EwaSelectItem(value: 'id', label: 'Indonesia'),
                      EwaSelectItem(value: 'my', label: 'Malaysia'),
                      EwaSelectItem(value: 'sg', label: 'Singapore'),
                    ],
                    value: _selectedCountry,
                    onChanged: (v) => setState(() => _selectedCountry = v),
                  ),
                ],
              ),
              _Section(
                title: 'Loading',
                children: [
                  Wrap(
                    spacing: 24.w,
                    runSpacing: 16.h,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Column(
                        children: [
                          EwaLoading.bouncingDots(),
                          SizedBox(height: 4.h),
                          Text('Bouncing', style: EwaTypography.bodyXs()),
                        ],
                      ),
                      Column(
                        children: [
                          EwaLoading.wave(),
                          SizedBox(height: 4.h),
                          Text('Wave', style: EwaTypography.bodyXs()),
                        ],
                      ),
                      Column(
                        children: [
                          EwaLoading.circularProgress(),
                          SizedBox(height: 4.h),
                          Text('Circular', style: EwaTypography.bodyXs()),
                        ],
                      ),
                      Column(
                        children: [
                          EwaLoading.pulse(),
                          SizedBox(height: 4.h),
                          Text('Pulse', style: EwaTypography.bodyXs()),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              _Section(
                title: 'Toast',
                children: [
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      EwaButton.primary(
                        label: 'Success',
                        size: EwaButtonSize.sm,
                        onPressed: () async {
                          EwaToast.showSuccess(
                            context,
                            'Operation completed successfully!',
                          );
                        },
                      ),
                      EwaButton.secondary(
                        label: 'Error',
                        size: EwaButtonSize.sm,
                        onPressed: () async {
                          EwaToast.showError(context, 'Something went wrong!');
                        },
                      ),
                      EwaButton.tertiary(
                        label: 'Info',
                        size: EwaButtonSize.sm,
                        onPressed: () async {
                          EwaToast.showInfo(
                            context,
                            'Here is some information.',
                          );
                        },
                      ),
                      EwaButton.tertiary(
                        label: 'Warning',
                        size: EwaButtonSize.sm,
                        onPressed: () async {
                          EwaToast.showWarning(
                            context,
                            'Please be careful!',
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              _Section(
                title: 'Dialog',
                children: [
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      EwaButton.primary(
                        label: 'Alert',
                        size: EwaButtonSize.sm,
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
                        label: 'Confirmation',
                        size: EwaButtonSize.sm,
                        onPressed: () async {
                          if (!context.mounted) return;
                          final result = await EwaDialog.showConfirmation(
                            context: context,
                            title: 'Confirm',
                            message: 'Do you want to proceed?',
                          );
                          if (!context.mounted) return;
                          EwaToast.showInfo(
                            context,
                            'You selected: ${result == true ? "Yes" : "No"}',
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              _Section(
                title: 'Bottom Sheet',
                children: [
                  EwaButton.primary(
                    label: 'Show Bottom Sheet',
                    size: EwaButtonSize.sm,
                    onPressed: () async {
                      if (!context.mounted) return;
                      EwaBottomSheet.showOptions(
                        context: context,
                        title: 'Choose an option',
                        options: [
                          EwaBottomSheetOption(
                            title: 'Option 1',
                            subtitle: 'First option',
                            icon: Icon(Icons.star, size: 20.sp),
                            onTap: () {
                              EwaToast.showSuccess(context, 'Option 1 selected');
                            },
                          ),
                          EwaBottomSheetOption(
                            title: 'Option 2',
                            icon: Icon(Icons.favorite, size: 20.sp),
                            onTap: () {
                              EwaToast.showSuccess(context, 'Option 2 selected');
                            },
                          ),
                          EwaBottomSheetOption(
                            title: 'Option 3',
                            icon: Icon(Icons.settings, size: 20.sp),
                            onTap: () {
                              EwaToast.showSuccess(context, 'Option 3 selected');
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              _Section(
                title: 'Full Demos',
                children: [
                  EwaButton.primary(
                    label: 'Login Form Demo',
                    onPressed: () async {
                      _navigateTo(const LoginExampleScreen());
                    },
                  ),
                  SizedBox(height: 8.h),
                  EwaButton.primary(
                    label: 'Select Demo (Static & Lazy)',
                    onPressed: () async {
                      _navigateTo(const SelectExampleScreen());
                    },
                  ),
                  SizedBox(height: 8.h),
                  EwaButton.primary(
                    label: 'HTTP Client Demo',
                    onPressed: () async {
                      _navigateTo(const HttpExampleScreen());
                    },
                  ),
                  SizedBox(height: 8.h),
                  EwaButton.primary(
                    label: 'Lazy Load Demo',
                    onPressed: () async {
                      _navigateTo(const LazyLoadExampleScreen());
                    },
                  ),
                  SizedBox(height: 8.h),
                  EwaButton.primary(
                    label: 'Image Demo',
                    onPressed: () async {
                      _navigateTo(const ImageExampleScreen());
                    },
                  ),
                  SizedBox(height: 8.h),
                  EwaButton.primary(
                    label: 'Connectivity Demo',
                    onPressed: () async {
                      _navigateTo(const ConnectivityExampleScreen());
                    },
                  ),
                  SizedBox(height: 8.h),
                  EwaButton.primary(
                    label: 'Permission Demo',
                    onPressed: () async {
                      _navigateTo(const PermissionExampleScreen());
                    },
                  ),
                ],
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _Section({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: EwaTypography.headingLg()),
        SizedBox(height: 12.h),
        ...children,
        SizedBox(height: 24.h),
      ],
    );
  }
}
