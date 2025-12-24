import 'package:ewa_kit/ui/button/button.dart';
import 'package:ewa_kit/ui/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'ewa_permission_helper.dart';

/// A widget that displays permission status and provides UI for requesting permissions
class EwaPermissionWidget extends StatefulWidget {
  /// The permission to manage
  final Permission permission;

  /// Title to display for the permission
  final String title;

  /// Description of what the permission is for
  final String description;

  /// Callback when permission status changes
  final void Function(PermissionStatus)? onStatusChanged;

  /// Icon to display for the permission
  final IconData? icon;

  /// Color for the permission widget
  final Color? color;

  /// Button text when permission is not granted
  final String buttonText;

  /// Whether to show the permission status text
  final bool showStatusText;

  const EwaPermissionWidget({
    super.key,
    required this.permission,
    required this.title,
    required this.description,
    this.onStatusChanged,
    this.icon,
    this.color,
    this.buttonText = 'Allow',
    this.showStatusText = true,
  });

  @override
  State<EwaPermissionWidget> createState() => _EwaPermissionWidgetState();
}

class _EwaPermissionWidgetState extends State<EwaPermissionWidget> {
  PermissionStatus _status = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();
    _checkPermissionStatus();
  }

  Future<void> _checkPermissionStatus() async {
    final status = await widget.permission.status;
    if (mounted) {
      setState(() {
        _status = status;
      });
    }
    widget.onStatusChanged?.call(status);
  }

  Future<void> _requestPermission() async {
    if (!mounted) return;

    final context = this.context;
    await EwaPermissionHelper.requestPermission(
      widget.permission,
      context: context,
      title: widget.title,
      message: widget.description,
    );

    if (mounted) {
      final newStatus = await widget.permission.status;
      setState(() {
        _status = newStatus;
      });
      widget.onStatusChanged?.call(newStatus);
    }
  }

  String _getStatusText() {
    switch (_status) {
      case PermissionStatus.granted:
        return 'Allowed';
      case PermissionStatus.denied:
        return 'Not allowed';
      case PermissionStatus.permanentlyDenied:
        return 'Permanently denied';
      case PermissionStatus.restricted:
        return 'Restricted';
      case PermissionStatus.limited:
        return 'Limited';
      default:
        return 'Unknown';
    }
  }

  Color _getStatusColor() {
    switch (_status) {
      case PermissionStatus.granted:
        return Colors.green;
      case PermissionStatus.denied:
      case PermissionStatus.permanentlyDenied:
        return Colors.red;
      case PermissionStatus.restricted:
        return Colors.orange;
      case PermissionStatus.limited:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final icon = widget.icon ?? _getDefaultIcon();
    final color = widget.color ?? Theme.of(context).primaryColor;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: _getStatusColor().withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 12),
              Expanded(child: Text(widget.title, style: EwaTypography.body())),
              if (widget.showStatusText)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _getStatusText(),
                    style: TextStyle(
                      color: _getStatusColor(),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.description,
            style: EwaTypography.bodySm()?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 12),
          if (_status != PermissionStatus.granted)
            EwaButton.primary(
              label: widget.buttonText,
              size: EwaButtonSize.sm,
              onPressed: () async {
                await _requestPermission();
              },
            ),
        ],
      ),
    );
  }

  IconData _getDefaultIcon() {
    switch (widget.permission) {
      case Permission.camera:
        return Icons.camera_alt;
      case Permission.storage:
      case Permission.photos:
      case Permission.videos:
        return Icons.folder;
      case Permission.location:
        return Icons.location_on;
      case Permission.microphone:
        return Icons.mic;
      case Permission.notification:
        return Icons.notifications;
      case Permission.bluetooth:
        return Icons.bluetooth;
      case Permission.contacts:
        return Icons.contacts;
      case Permission.calendar:
        return Icons.calendar_today;
      case Permission.sensors:
        return Icons.sensors;
      default:
        return Icons.settings;
    }
  }
}

/// A widget that manages multiple permissions at once
class EwaPermissionsWidget extends StatefulWidget {
  /// List of permissions to manage
  final List<EwaPermissionData> permissions;

  /// Title for the permissions widget
  final String title;

  /// Description for the permissions widget
  final String description;

  /// Callback when any permission status changes
  final void Function(Map<Permission, PermissionStatus>)? onStatusChanged;

  /// Whether to show the header section
  final bool showHeader;

  const EwaPermissionsWidget({
    super.key,
    required this.permissions,
    this.title = 'Permissions Required',
    this.description =
        'The following permissions are required for this app to function properly',
    this.onStatusChanged,
    this.showHeader = true,
  });

  @override
  State<EwaPermissionsWidget> createState() => _EwaPermissionsWidgetState();
}

class _EwaPermissionsWidgetState extends State<EwaPermissionsWidget> {
  Map<Permission, PermissionStatus> _statuses = {};

  @override
  void initState() {
    super.initState();
    _initializePermissions();
  }

  Future<void> _initializePermissions() async {
    final statuses = <Permission, PermissionStatus>{};
    for (final permissionData in widget.permissions) {
      final status = await permissionData.permission.status;
      statuses[permissionData.permission] = status;
    }

    if (mounted) {
      setState(() {
        _statuses = statuses;
      });
    }
    widget.onStatusChanged?.call(statuses);
  }

  void _onStatusChanged(Permission permission, PermissionStatus status) {
    setState(() {
      _statuses[permission] = status;
    });
    final updatedStatuses = Map<Permission, PermissionStatus>.from(_statuses);
    updatedStatuses[permission] = status;
    widget.onStatusChanged?.call(updatedStatuses);
  }

  bool get _allGranted {
    return _statuses.values.every(
      (status) => status == PermissionStatus.granted,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.showHeader) ...[
            Text(widget.title, style: EwaTypography.headingLg()),
            const SizedBox(height: 8),
            Text(
              widget.description,
              style: EwaTypography.body()?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
          ],
          ...widget.permissions.map(
            (permissionData) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: EwaPermissionWidget(
                permission: permissionData.permission,
                title: permissionData.title,
                description: permissionData.description,
                icon: permissionData.icon,
                color: permissionData.color,
                buttonText: permissionData.buttonText,
                onStatusChanged: (status) =>
                    _onStatusChanged(permissionData.permission, status),
              ),
            ),
          ),
          if (!_allGranted) const SizedBox(height: 16),
          if (!_allGranted)
            EwaButton.primary(
              label: 'Request All Permissions',
              onPressed: () async {
                for (final permissionData in widget.permissions) {
                  if (_statuses[permissionData.permission] !=
                      PermissionStatus.granted) {
                    final context = this.context;
                    if (!context.mounted) continue;
                    await EwaPermissionHelper.requestPermission(
                      permissionData.permission,
                      context: context,
                      title: permissionData.title,
                      message: permissionData.description,
                    );
                  }
                }
                // Refresh all statuses after requesting all permissions
                await _initializePermissions();
              },
            ),
        ],
      ),
    );
  }
}

/// Data class for permission configuration
class EwaPermissionData {
  /// The permission to request
  final Permission permission;

  /// Title for the permission
  final String title;

  /// Description for the permission
  final String description;

  /// Icon to display for the permission
  final IconData? icon;

  /// Color for the permission widget
  final Color? color;

  /// Button text for the permission
  final String buttonText;

  const EwaPermissionData({
    required this.permission,
    required this.title,
    required this.description,
    this.icon,
    this.color,
    this.buttonText = 'Allow',
  });
}
