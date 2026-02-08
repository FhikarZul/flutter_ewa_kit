import 'package:flutter/material.dart';

/// Represents an option item for [EwaSelect].
///
/// [value] is the underlying value, [label] is the display text.
/// Use [child] for custom widget display (overrides label when non-null).
@immutable
class EwaSelectItem<T> {
  const EwaSelectItem({
    required this.value,
    required this.label,
    this.child,
  });

  final T value;
  final String label;
  final Widget? child;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EwaSelectItem<T> &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
