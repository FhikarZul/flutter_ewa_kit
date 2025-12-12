import 'package:ewa_kit/foundations/color/color.dart';
import 'package:ewa_kit/foundations/size/size.dart';
import 'package:ewa_kit/ui/button/button.dart';
import 'package:ewa_kit/ui/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A customizable bottom sheet component for the EWA Kit
///
/// Example usage:
/// ```dart
/// EwaBottomSheet.show(
///   context: context,
///   title: 'Options',
///   children: [
///     ListTile(
///       title: Text('Option 1'),
///       onTap: () {
///         Navigator.pop(context);
///         // Handle option 1
///       },
///     ),
///     ListTile(
///       title: Text('Option 2'),
///       onTap: () {
///         Navigator.pop(context);
///         // Handle option 2
///       },
///     ),
///   ],
/// );
/// ```
class EwaBottomSheet {
  /// Shows a customizable bottom sheet
  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    List<Widget>? children,
    Widget? content,
    List<EwaBottomSheetAction>? actions,
    bool isDismissible = true,
    bool enableDrag = true,
    double? maxHeight,
    Color? backgroundColor,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return _EwaBottomSheetWidget(
          title: title,
          content: content,
          actions: actions,
          maxHeight: maxHeight,
          backgroundColor: backgroundColor,
          children: children,
        );
      },
    );
  }

  /// Shows a simple bottom sheet with a list of options
  static Future<T?> showOptions<T>({
    required BuildContext context,
    required String title,
    required List<EwaBottomSheetOption> options,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return show<T>(
      context: context,
      title: title,
      children: [
        for (int i = 0; i < options.length; i++) ...[
          ListTile(
            title: Text(options[i].title, style: EwaTypography.body()),
            subtitle: options[i].subtitle != null
                ? Text(
                    options[i].subtitle!,
                    style: EwaTypography.bodySm().copyWith(
                      color: EwaColorFoundation.neutral500,
                    ),
                  )
                : null,
            leading: options[i].icon,
            onTap: () {
              Navigator.pop(context);
              options[i].onTap();
            },
          ),
          if (i < options.length - 1)
            Divider(
              height: 1.h,
              thickness: 1.h,
              color: EwaColorFoundation.neutral200,
            ),
        ],
      ],
      isDismissible: isDismissible,
      enableDrag: enableDrag,
    );
  }
}

/// Represents an option in the bottom sheet
class EwaBottomSheetOption {
  final String title;
  final String? subtitle;
  final Widget? icon;
  final VoidCallback onTap;

  EwaBottomSheetOption({
    required this.title,
    this.subtitle,
    this.icon,
    required this.onTap,
  });
}

/// Represents an action button in the bottom sheet
class EwaBottomSheetAction {
  final String label;
  final VoidCallback onPressed;
  final bool isDestructive;

  EwaBottomSheetAction({
    required this.label,
    required this.onPressed,
    this.isDestructive = false,
  });
}

/// Internal widget that implements the bottom sheet UI
class _EwaBottomSheetWidget extends StatelessWidget {
  final String? title;
  final List<Widget>? children;
  final Widget? content;
  final List<EwaBottomSheetAction>? actions;
  final double? maxHeight;
  final Color? backgroundColor;

  const _EwaBottomSheetWidget({
    this.title,
    this.children,
    this.content,
    this.actions,
    this.maxHeight,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor =
        backgroundColor ?? EwaColorFoundation.getBackground(context);

    Widget bottomSheetContent = Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: EwaColorFoundation.neutral300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Header with title and close button
          if (title != null) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title!,
                      style: EwaTypography.headingSm(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 20.sp,
                      color: EwaColorFoundation.neutral500,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
          ],

          // Custom content
          if (content != null) ...[
            Flexible(child: content!),
            SizedBox(height: 16.h),
          ],

          // Children list
          if (children != null && children!.isNotEmpty) ...[
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: children!,
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],

          // Action buttons
          if (actions != null && actions!.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ).copyWith(bottom: 16.h),
              child: Row(
                children: [
                  for (int i = 0; i < actions!.length; i++) ...[
                    Expanded(child: _buildActionButton(context, actions![i])),
                    if (i < actions!.length - 1) SizedBox(width: 8.w),
                  ],
                ],
              ),
            ),
          ] else if ((content == null ||
              children == null ||
              children!.isEmpty)) ...[
            SizedBox(height: 16.h),
          ],
        ],
      ),
    );

    // Apply max height constraint if specified
    if (maxHeight != null) {
      bottomSheetContent = ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight!),
        child: bottomSheetContent,
      );
    }

    return bottomSheetContent;
  }

  /// Builds an action button
  Widget _buildActionButton(BuildContext context, EwaBottomSheetAction action) {
    if (action.isDestructive) {
      return EwaButton.danger(
        label: action.label,
        onPressed: () async {
          action.onPressed();
        },
        size: EwaButtonSize.md,
      );
    } else {
      return EwaButton.primary(
        label: action.label,
        onPressed: () async {
          action.onPressed();
        },
        size: EwaButtonSize.md,
      );
    }
  }
}
