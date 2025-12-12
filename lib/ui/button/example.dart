import 'package:ewa_kit/ewa_kit.dart';
import 'package:flutter/material.dart';

class ButtonExample extends StatelessWidget {
  const ButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Button Variants')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Default Buttons
            const Text('Default Buttons'),
            const SizedBox(height: 16),

            EwaButton.primary(label: 'Primary Button', onPressed: () async {}),
            const SizedBox(height: 16),

            EwaButton.secondary(
              label: 'Secondary Button',
              onPressed: () async {},
            ),
            const SizedBox(height: 16),

            EwaButton.tertiary(
              label: 'Tertiary Button',
              onPressed: () async {},
            ),
            const SizedBox(height: 16),

            EwaButton.danger(label: 'Danger Button', onPressed: () async {}),
            const SizedBox(height: 24),

            // Custom Border Radius Examples
            const Text('Custom Border Radius Examples'),
            const SizedBox(height: 16),

            // Rounded Buttons
            EwaButton.primary(
              label: 'Rounded Primary (20.0)',
              borderRadius: 20.0,
              onPressed: () async {},
            ),
            const SizedBox(height: 16),

            EwaButton.secondary(
              label: 'Pill Secondary (30.0)',
              borderRadius: 30.0,
              onPressed: () async {},
            ),
            const SizedBox(height: 16),

            EwaButton.tertiary(
              label: 'Square Tertiary (0.0)',
              borderRadius: 0.0,
              onPressed: () async {},
            ),
            const SizedBox(height: 16),

            EwaButton.danger(
              label: 'Custom Danger (15.0)',
              borderRadius: 15.0,
              onPressed: () async {},
            ),
            const SizedBox(height: 24),

            // Different Sizes with Custom Border Radius
            const Text('Different Sizes with Custom Border Radius'),
            const SizedBox(height: 16),

            EwaButton.primary(
              label: 'XS Rounded',
              size: EwaButtonSize.xs,
              borderRadius: 20.0,
              onPressed: () async {},
            ),
            const SizedBox(height: 16),

            EwaButton.primary(
              label: 'SM Rounded',
              size: EwaButtonSize.sm,
              borderRadius: 20.0,
              onPressed: () async {},
            ),
            const SizedBox(height: 16),

            EwaButton.primary(
              label: 'MD Rounded',
              size: EwaButtonSize.md,
              borderRadius: 20.0,
              onPressed: () async {},
            ),
            const SizedBox(height: 16),

            EwaButton.primary(
              label: 'LG Rounded',
              size: EwaButtonSize.lg,
              borderRadius: 20.0,
              onPressed: () async {},
            ),
            const SizedBox(height: 16),

            EwaButton.primary(
              label: 'XL Rounded',
              size: EwaButtonSize.xl,
              borderRadius: 20.0,
              onPressed: () async {},
            ),
          ],
        ),
      ),
    );
  }
}
