import 'dart:math' as math;

import 'package:ewa_kit/foundations/color/color.dart';
import 'package:ewa_kit/foundations/size/size.dart';
import 'package:ewa_kit/ui/button/button.dart';
import 'package:ewa_kit/ui/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

/// A customizable dialog component for the EWA Kit
///
/// Example usage:
/// ```dart
/// EwaDialog.show(
///   context: context,
///   title: 'Confirmation',
///   message: 'Are you sure you want to proceed?',
///   primaryAction: EwaDialogAction(
///     label: 'Yes',
///     onPressed: () {
///       // Handle confirmation
///     },
///   ),
///   secondaryAction: EwaDialogAction(
///     label: 'No',
///     onPressed: () {
///       Navigator.pop(context);
///     },
///   ),
/// );
/// ```
class EwaDialog {
  /// Shows a customizable dialog
  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    String? message,
    Widget? content,
    EwaDialogAction? primaryAction,
    EwaDialogAction? secondaryAction,
    EwaDialogAction? tertiaryAction,
    bool barrierDismissible = true,
    bool showCloseButton = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return _EwaDialogWidget(
          title: title,
          message: message,
          content: content,
          primaryAction: primaryAction,
          secondaryAction: secondaryAction,
          tertiaryAction: tertiaryAction,
          showCloseButton: showCloseButton,
        );
      },
    );
  }

  /// Shows a simple alert dialog with OK button
  static Future<void> showAlert({
    required BuildContext context,
    required String title,
    required String message,
    String okLabel = 'OK',
  }) {
    return show(
      context: context,
      title: title,
      message: message,
      primaryAction: EwaDialogAction(
        label: okLabel,
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  /// Shows a confirmation dialog with Yes/No buttons
  static Future<bool?> showConfirmation({
    required BuildContext context,
    required String title,
    required String message,
    String yesLabel = 'Yes',
    String noLabel = 'No',
  }) {
    return show<bool>(
      context: context,
      title: title,
      message: message,
      primaryAction: EwaDialogAction(
        label: yesLabel,
        onPressed: () => Navigator.pop(context, true),
      ),
      secondaryAction: EwaDialogAction(
        label: noLabel,
        onPressed: () => Navigator.pop(context, false),
      ),
    );
  }
}

/// Represents an action button in the dialog
class EwaDialogAction {
  final String label;
  final VoidCallback onPressed;
  final bool isDestructive;

  EwaDialogAction({
    required this.label,
    required this.onPressed,
    this.isDestructive = false,
  });
}

/// Internal widget that implements the dialog UI
class _EwaDialogWidget<T> extends StatelessWidget {
  final String? title;
  final String? message;
  final Widget? content;
  final EwaDialogAction? primaryAction;
  final EwaDialogAction? secondaryAction;
  final EwaDialogAction? tertiaryAction;
  final bool showCloseButton;

  const _EwaDialogWidget({
    this.title,
    this.message,
    this.content,
    this.primaryAction,
    this.secondaryAction,
    this.tertiaryAction,
    this.showCloseButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final closeIconColor = EwaColorFoundation.resolveColor(
      context,
      EwaColorFoundation.neutral500,
      EwaColorFoundation.neutral400,
    );
    final closeButtonBgColor = EwaColorFoundation.resolveColor(
      context,
      EwaColorFoundation.neutral200,
      EwaColorFoundation.neutral700,
    );

    return Dialog(
      backgroundColor: surfaceColor,
      elevation: 24,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Container(
        width: math.min(300.w, 400),
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and optional close button
            if (title != null || showCloseButton) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (title != null)
                    Expanded(
                      child: Text(title!, style: EwaTypography.headingSm()),
                    )
                  else if (showCloseButton)
                    const Spacer(),
                  if (showCloseButton)
                    IconButton(
                      icon: Icon(Icons.close, size: 20.sp, color: closeIconColor),
                      onPressed: () => Navigator.pop(context),
                      style: IconButton.styleFrom(
                        backgroundColor: closeButtonBgColor,
                        shape: const CircleBorder(),
                        minimumSize: Size(32.r, 32.r),
                        padding: EdgeInsets.all(6.r),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      tooltip: 'Close',
                    ),
                ],
              ),
              SizedBox(height: 12.h),
            ],

            // Message
            if (message != null) ...[
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 240.h),
                child: SingleChildScrollView(
                  child: Text(message!, style: EwaTypography.body()),
                ),
              ),
              SizedBox(height: 16.h),
            ],

            // Custom content
            if (content != null) ...[content!, SizedBox(height: 16.h)],

            // Action buttons
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  /// Builds the action buttons row
  Widget _buildActions(BuildContext context) {
    final actions = [
      if (tertiaryAction != null) tertiaryAction!,
      if (secondaryAction != null) secondaryAction!,
      if (primaryAction != null) primaryAction!,
    ];

    if (actions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: actions.length == 1
          ? MainAxisAlignment.end
          : MainAxisAlignment.spaceBetween,
      children: [
        // Tertiary action (left aligned)
        if (tertiaryAction != null)
          _buildActionButton(context, tertiaryAction!, isTertiary: true),

        // Spacer for alignment when there are 2 actions
        if (actions.length == 2) const Spacer(),

        // Secondary and primary actions (right aligned) with spacing
        if (secondaryAction != null) ...[
          _buildActionButton(context, secondaryAction!, isSecondary: true),
          if (primaryAction != null) Gap(EwaDimension.size12),
        ],
        if (primaryAction != null) _buildActionButton(context, primaryAction!),
      ],
    );
  }

  /// Builds a single action button
  Widget _buildActionButton(
    BuildContext context,
    EwaDialogAction action, {
    bool isSecondary = false,
    bool isTertiary = false,
  }) {
    if (isTertiary) {
      return EwaButton.tertiary(
        label: action.label,
        onPressed: () async {
          action.onPressed();
        },
        size: EwaButtonSize.sm,
      );
    } else if (isSecondary) {
      return EwaButton.secondary(
        label: action.label,
        onPressed: () async {
          action.onPressed();
        },
        size: EwaButtonSize.sm,
      );
    } else if (action.isDestructive) {
      return EwaButton.danger(
        label: action.label,
        onPressed: () async {
          action.onPressed();
        },
        size: EwaButtonSize.sm,
      );
    } else {
      return EwaButton.primary(
        label: action.label,
        onPressed: () async {
          action.onPressed();
        },
        size: EwaButtonSize.sm,
      );
    }
  }
}
