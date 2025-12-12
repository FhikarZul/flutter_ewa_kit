import 'package:ewa_kit/ewa_kit.dart';
import 'package:flutter/material.dart';

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
