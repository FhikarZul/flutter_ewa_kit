import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../foundations/color/ewa_color_foundation.dart';

/// EWA Kit Image component with caching, placeholder, and error handling
class EwaImage extends StatelessWidget {
  /// Network image URL
  final String? imageUrl;

  /// Asset image path (if using local asset)
  final String? assetPath;

  /// Width of the image
  final double? width;

  /// Height of the image
  final double? height;

  /// BoxFit for the image
  final BoxFit? fit;

  /// Border radius of the image container
  final double borderRadius;

  /// Placeholder widget when image is loading
  final Widget? placeholder;

  /// Error widget when image fails to load
  final Widget? errorWidget;

  /// Whether to show a circular progress indicator during loading
  final bool showProgressIndicator;

  /// Whether to show the image in the widget (for API consistency)
  final bool useCache;

  /// Custom placeholder color
  final Color placeholderColor;

  /// Custom error color
  final Color errorColor;

  const EwaImage.network({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 8.0,
    this.placeholder,
    this.errorWidget,
    this.showProgressIndicator = true,
    this.useCache = true,
    this.placeholderColor = const Color(0xFFE0E0E0),
    this.errorColor = const Color(0xFFBDBDBD),
  }) : assetPath = null;

  const EwaImage.asset({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 8.0,
    this.placeholder,
    this.errorWidget,
    this.showProgressIndicator = true,
    this.useCache = true,
    this.placeholderColor = const Color(0xFFE0E0E0),
    this.errorColor = const Color(0xFFBDBDBD),
  }) : imageUrl = null;

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (assetPath != null) {
      // Asset image
      imageWidget = Image.asset(
        assetPath!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      );
    } else {
      // Network image with caching
      imageWidget = CachedNetworkImage(
        imageUrl: imageUrl!,
        width: width,
        height: height,
        fit: fit,
        useOldImageOnUrlChange: true,
        cacheKey: imageUrl,
        placeholder: (context, url) => _buildPlaceholder(),
        errorWidget: (context, url, error) => _buildErrorWidget(),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: imageWidget,
    );
  }

  Widget _buildPlaceholder() {
    if (placeholder != null) {
      return placeholder!;
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: placeholderColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: showProgressIndicator
          ? Center(
              child: Container(
                width: 24.0,
                height: 24.0,
                padding: const EdgeInsets.all(4.0),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    EwaColorFoundation.primaryLight,
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildErrorWidget() {
    if (errorWidget != null) {
      return errorWidget!;
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: errorColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Icon(
        Icons.broken_image,
        color: Colors.white,
        size: width != null ? width! * 0.3 : 40.0,
      ),
    );
  }
}
