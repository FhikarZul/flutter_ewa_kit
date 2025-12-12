import 'package:ewa_kit/foundations/color/color.dart';
import 'package:ewa_kit/ui/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Custom animated loading indicators for the EWA Kit
///
/// Example usage:
/// ```dart
/// // Simple rotating logo
/// EwaLoading.rotatingLogo();
///
/// // Three bouncing dots
/// EwaLoading.bouncingDots();
///
/// // Wave animation
/// EwaLoading.wave();
///
/// // Circular progress with label
/// EwaLoading.circularProgress(label: 'Loading...');
/// ```
class EwaLoading extends StatelessWidget {
  final String? label;
  final Color? color;
  final double size;
  final EwaLoadingType type;

  const EwaLoading({
    super.key,
    this.label,
    this.color,
    this.size = 40,
    required this.type,
  });

  /// Factory constructor for bouncing dots animation
  factory EwaLoading.bouncingDots({
    String? label,
    Color? color,
    double size = 40,
  }) => EwaLoading(
    label: label,
    color: color,
    size: size,
    type: EwaLoadingType.bouncingDots,
  );

  /// Factory constructor for wave animation
  factory EwaLoading.wave({String? label, Color? color, double size = 40}) =>
      EwaLoading(
        label: label,
        color: color,
        size: size,
        type: EwaLoadingType.wave,
      );

  /// Factory constructor for circular progress animation
  factory EwaLoading.circularProgress({
    String? label,
    Color? color,
    double size = 40,
  }) => EwaLoading(
    label: label,
    color: color,
    size: size,
    type: EwaLoadingType.circularProgress,
  );

  /// Factory constructor for pulse animation
  factory EwaLoading.pulse({String? label, Color? color, double size = 40}) =>
      EwaLoading(
        label: label,
        color: color,
        size: size,
        type: EwaLoadingType.pulse,
      );

  @override
  Widget build(BuildContext context) {
    final loadingColor = color ?? EwaColorFoundation.getPrimary(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLoadingWidget(loadingColor, context),
        if (label != null) ...[
          SizedBox(height: 12.h),
          Text(
            label!,
            style: EwaTypography.bodySm().copyWith(
              color: EwaColorFoundation.getText(context),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildLoadingWidget(Color loadingColor, BuildContext context) {
    switch (type) {
      case EwaLoadingType.bouncingDots:
        return _BouncingDots(size: size, color: loadingColor);
      case EwaLoadingType.wave:
        return _WaveAnimation(size: size, color: loadingColor);
      case EwaLoadingType.circularProgress:
        return _CircularProgress(size: size, color: loadingColor);
      case EwaLoadingType.pulse:
        return _PulseAnimation(size: size, color: loadingColor);
    }
  }
}

/// Enum defining the different types of loading animations
enum EwaLoadingType { bouncingDots, wave, circularProgress, pulse }

/// Bouncing dots animation
class _BouncingDots extends StatefulWidget {
  final double size;
  final Color color;

  const _BouncingDots({required this.size, required this.color});

  @override
  State<_BouncingDots> createState() => _BouncingDotsState();
}

class _BouncingDotsState extends State<_BouncingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _animation1 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.4, curve: Curves.easeInOut),
      ),
    );

    _animation2 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.6, curve: Curves.easeInOut),
      ),
    );

    _animation3 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeInOut),
      ),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ScaleTransition(
          scale: _animation1,
          child: Container(
            width: widget.size / 4,
            height: widget.size / 4,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
            ),
          ),
        ),
        SizedBox(width: widget.size / 6),
        ScaleTransition(
          scale: _animation2,
          child: Container(
            width: widget.size / 4,
            height: widget.size / 4,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
            ),
          ),
        ),
        SizedBox(width: widget.size / 6),
        ScaleTransition(
          scale: _animation3,
          child: Container(
            width: widget.size / 4,
            height: widget.size / 4,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}

/// Wave animation
class _WaveAnimation extends StatefulWidget {
  final double size;
  final Color color;

  const _WaveAnimation({required this.size, required this.color});

  @override
  State<_WaveAnimation> createState() => _WaveAnimationState();
}

class _WaveAnimationState extends State<_WaveAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;
  late Animation<double> _animation4;
  late Animation<double> _animation5;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation1 = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.2, curve: Curves.easeInOut),
      ),
    );

    _animation2 = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.3, curve: Curves.easeInOut),
      ),
    );

    _animation3 = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.4, curve: Curves.easeInOut),
      ),
    );

    _animation4 = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.5, curve: Curves.easeInOut),
      ),
    );

    _animation5 = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.6, curve: Curves.easeInOut),
      ),
    );

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ScaleTransition(
          scale: _animation1,
          child: Container(
            width: widget.size / 8,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(widget.size / 16),
            ),
          ),
        ),
        SizedBox(width: widget.size / 12),
        ScaleTransition(
          scale: _animation2,
          child: Container(
            width: widget.size / 8,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(widget.size / 16),
            ),
          ),
        ),
        SizedBox(width: widget.size / 12),
        ScaleTransition(
          scale: _animation3,
          child: Container(
            width: widget.size / 8,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(widget.size / 16),
            ),
          ),
        ),
        SizedBox(width: widget.size / 12),
        ScaleTransition(
          scale: _animation4,
          child: Container(
            width: widget.size / 8,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(widget.size / 16),
            ),
          ),
        ),
        SizedBox(width: widget.size / 12),
        ScaleTransition(
          scale: _animation5,
          child: Container(
            width: widget.size / 8,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(widget.size / 16),
            ),
          ),
        ),
      ],
    );
  }
}

/// Circular progress animation
class _CircularProgress extends StatefulWidget {
  final double size;
  final Color color;

  const _CircularProgress({required this.size, required this.color});

  @override
  State<_CircularProgress> createState() => _CircularProgressState();
}

class _CircularProgressState extends State<_CircularProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(widget.color),
        strokeWidth: widget.size / 10,
      ),
    );
  }
}

/// Pulse animation
class _PulseAnimation extends StatefulWidget {
  final double size;
  final Color color;

  const _PulseAnimation({required this.size, required this.color});

  @override
  State<_PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<_PulseAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
      ),
    );
  }
}
