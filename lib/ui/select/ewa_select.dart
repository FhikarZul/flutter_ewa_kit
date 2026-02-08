import 'dart:async';

import 'package:ewa_kit/foundations/color/ewa_color_foundation.dart';
import 'package:ewa_kit/ui/loading/loading.dart';
import 'package:ewa_kit/ui/select/ewa_select_item.dart';
import 'package:ewa_kit/ui/textfield/ewa_textfield.dart';
import 'package:ewa_kit/ui/textfield/enums/ewa_textfield_variant.dart';
import 'package:ewa_kit/ui/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Constants for EWA Select configuration (matches EwaTextFieldConstants)
class EwaSelectConstants {
  const EwaSelectConstants._();

  static const defaultBorderRadius = 8.0;
  static const borderWidth = 1.0;
  static const defaultPaddingHorizontal = 16.0;
  static const defaultPaddingVertical = 12.0;
}

/// A select/dropdown component that supports both static items and lazy loading.
///
/// **Static mode** — pass [items] with all options:
/// ```dart
/// EwaSelect<String>(
///   items: [
///     EwaSelectItem(value: 'a', label: 'Option A'),
///     EwaSelectItem(value: 'b', label: 'Option B'),
///   ],
///   value: selectedValue,
///   onChanged: (v) => setState(() => selectedValue = v),
/// )
/// ```
///
/// **Lazy load mode** — pass [itemCount], [itemBuilder], [onLoadMore]:
/// ```dart
/// EwaSelect<String>.lazy(
///   itemCount: items.length,
///   itemBuilder: (context, index) => EwaSelectItem(value: items[index].id, label: items[index].name),
///   onLoadMore: () async => await loadNextPage(),
///   isLoading: isLoading,
///   value: selectedValue,
///   selectedLabel: selectedLabel, // for display when value set
///   onChanged: (v) => ...,
/// )
/// ```
class EwaSelect<T> extends StatelessWidget {
  /// Creates a select with static items.
  const EwaSelect({
    required this.items,
    required this.value,
    required this.onChanged,
    this.hintText = 'Pilih',
    this.labelText,
    this.helperText,
    this.enabled = true,
    this.variant = EwaTextFieldVariant.primary,
    this.borderRadius = EwaSelectConstants.defaultBorderRadius,
    this.prefixIcon,
    this.validator,
    this.emptyMessage,
    this.itemCountNotifier,
    this.isLoadingNotifier,
    this.searchHint,
    super.key,
  })  : itemCount = null,
        itemBuilder = null,
        onLoadMore = null,
        isLoading = null,
        selectedLabel = null,
        onSearch = null;

  /// Creates a select with lazy loading.
  const EwaSelect.lazy({
    required this.itemCount,
    required this.itemBuilder,
    required this.onLoadMore,
    required this.isLoading,
    required this.value,
    required this.onChanged,
    this.selectedLabel,
    this.hintText = 'Pilih',
    this.labelText,
    this.helperText,
    this.enabled = true,
    this.variant = EwaTextFieldVariant.primary,
    this.borderRadius = EwaSelectConstants.defaultBorderRadius,
    this.prefixIcon,
    this.validator,
    this.emptyMessage = 'Tidak ada data',
    this.itemCountNotifier,
    this.isLoadingNotifier,
    this.searchHint,
    this.onSearch,
    super.key,
  })  : items = null;

  final List<EwaSelectItem<T>>? items;
  final int? itemCount;
  final EwaSelectItem<T> Function(BuildContext context, int index)? itemBuilder;
  final Future<void> Function()? onLoadMore;
  final bool? isLoading;

  final T? value;
  final String? selectedLabel;
  final ValueChanged<T?> onChanged;

  final String hintText;
  final String? labelText;
  final String? helperText;
  final ValueNotifier<int>? itemCountNotifier;
  final ValueNotifier<bool>? isLoadingNotifier;
  final bool enabled;
  final EwaTextFieldVariant variant;
  final double borderRadius;
  final Widget? prefixIcon;
  final String? Function(T?)? validator;
  final String? emptyMessage;

  /// Hint text for search bar. When non-null, a search bar is shown in the modal.
  /// Static mode: filters items by label (client-side).
  /// Lazy mode: calls [onSearch] when text changes (server-side).
  final String? searchHint;

  /// For lazy mode only. Called when search text changes (debounced ~300ms).
  /// Parent should reload data with the query and update itemCount/itemCountNotifier.
  final void Function(String query)? onSearch;

  bool get _isLazy => itemBuilder != null && onLoadMore != null;

  @override
  Widget build(BuildContext context) {
    return FormField<T?>(
      key: ValueKey('$value-$selectedLabel'),
      initialValue: value,
      validator: (_) => validator?.call(value),
      builder: (formState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (labelText != null) ...[
              Text(
                labelText!,
                style: EwaTypography.bodySm().copyWith(
                  color: variant.data(context).textColor,
                ),
              ),
              SizedBox(height: 6.h),
            ],
            GestureDetector(
              onTap: enabled ? () => _showOptions(context, formState) : null,
              child: _buildTrigger(context, formState),
            ),
            if (helperText != null) ...[
              SizedBox(height: 4.h),
              Text(
                helperText!,
                style: EwaTypography.bodyXs().copyWith(
                  color: EwaColorFoundation.resolveColor(
                    context,
                    EwaColorFoundation.neutral500,
                    EwaColorFoundation.neutral400,
                  ),
                ),
              ),
            ],
            if (formState.hasError) ...[
              SizedBox(height: 4.h),
              Text(
                formState.errorText!,
                style: EwaTypography.bodyXs().copyWith(
                  color: EwaColorFoundation.getError(context),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildTrigger(BuildContext context, FormFieldState<T?> formState) {
    final variantData = variant.data(context);
    final fontSize = 16.sp.clamp(12.0, 20.0);
    final hasError = formState.hasError;

    final displayText = _getDisplayText(context);

    final isEmpty = displayText == hintText;
    final content = InputDecorator(
      decoration: InputDecoration(
        hintText: isEmpty ? hintText : null,
        hintStyle: TextStyle(color: variantData.hintColor, fontSize: fontSize),
        prefixIcon: prefixIcon,
        suffixIcon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: variantData.hintColor,
          size: 24.sp,
        ),
        filled: true,
        fillColor: variantData.fillColor,
        contentPadding: EdgeInsets.symmetric(
          horizontal: EwaSelectConstants.defaultPaddingHorizontal.w,
          vertical: EwaSelectConstants.defaultPaddingVertical.h,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: BorderSide(
            color: hasError
                ? EwaColorFoundation.getError(context)
                : variantData.enabledBorderColor,
            width: EwaSelectConstants.borderWidth.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: BorderSide(
            color: hasError
                ? EwaColorFoundation.getError(context)
                : variantData.focusedBorderColor,
            width: EwaSelectConstants.borderWidth.w,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: BorderSide(
            color: EwaColorFoundation.getError(context),
            width: EwaSelectConstants.borderWidth.w,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: BorderSide(
            color: EwaColorFoundation.getError(context),
            width: EwaSelectConstants.borderWidth.w,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: BorderSide(
            color: EwaColorFoundation.resolveColor(
              context,
              EwaColorFoundation.neutral300,
              EwaColorFoundation.neutral600,
            ),
            width: EwaSelectConstants.borderWidth.w,
          ),
        ),
      ),
      isEmpty: isEmpty,
      child: Text(
        isEmpty ? '' : displayText,
        style: EwaTypography.body().copyWith(
          color: displayText == hintText
              ? variantData.hintColor
              : variantData.textColor,
          fontSize: fontSize,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );

    return Opacity(opacity: enabled ? 1 : 0.5, child: content);
  }

  String _getDisplayText(BuildContext context) {
    if (value == null) return hintText;
    if (selectedLabel != null && selectedLabel!.isNotEmpty) return selectedLabel!;

    if (items != null) {
      final item = items!.cast<EwaSelectItem<T>?>().firstWhere(
            (i) => i?.value == value,
            orElse: () => null,
          );
      return item?.label ?? value.toString();
    }

    return value.toString();
  }

  void _showOptions(BuildContext context, FormFieldState<T?> formState) {
    if (_isLazy) {
      _showLazyOptions(context, formState);
    } else {
      _showStaticOptions(context, formState);
    }
  }

  void _showStaticOptions(BuildContext context, FormFieldState<T?> formState) {
    final options = items ?? [];

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => _StaticSelectContent<T>(
        options: options,
        value: value,
        onSelected: (v) {
          formState.didChange(v);
          onChanged(v);
          Navigator.pop(ctx);
        },
        labelText: labelText,
        emptyMessage: emptyMessage,
        searchHint: searchHint,
      ),
    );
  }

  void _showLazyOptions(BuildContext context, FormFieldState<T?> formState) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => _LazySelectContent<T>(
        itemCount: itemCount!,
        itemCountNotifier: itemCountNotifier,
        isLoadingNotifier: isLoadingNotifier,
        itemBuilder: itemBuilder!,
        onLoadMore: onLoadMore!,
        isLoading: isLoading ?? false,
        value: value,
        onSelected: (v) {
          formState.didChange(v);
          onChanged(v);
          Navigator.pop(ctx);
        },
        labelText: labelText,
        emptyMessage: emptyMessage,
        searchHint: searchHint,
        onSearch: onSearch,
      ),
    );
  }
}

class _StaticSelectContent<T> extends StatefulWidget {
  const _StaticSelectContent({
    required this.options,
    required this.value,
    required this.onSelected,
    this.labelText,
    this.emptyMessage,
    this.searchHint,
  });

  final List<EwaSelectItem<T>> options;
  final T? value;
  final ValueChanged<T?> onSelected;
  final String? labelText;
  final String? emptyMessage;
  final String? searchHint;

  @override
  State<_StaticSelectContent<T>> createState() => _StaticSelectContentState<T>();
}

class _StaticSelectContentState<T> extends State<_StaticSelectContent<T>> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<EwaSelectItem<T>> get _filteredOptions {
    final q = _searchController.text.trim().toLowerCase();
    if (q.isEmpty) return widget.options;
    return widget.options
        .where((i) => i.label.toLowerCase().contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _searchController,
      builder: (context, _) {
        final filtered = _filteredOptions;
        return Container(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
          decoration: BoxDecoration(
            color: EwaColorFoundation.resolveColor(
              context,
              EwaColorFoundation.neutral50,
              EwaColorFoundation.neutral900,
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(top: 12.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: EwaColorFoundation.resolveColor(
                    context,
                    EwaColorFoundation.neutral300,
                    EwaColorFoundation.neutral600,
                  ),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              if (widget.labelText != null) ...[
                Padding(
                  padding: EdgeInsets.fromLTRB(16.r, 16.r, 16.r, 0),
                  child: Text(widget.labelText!, style: EwaTypography.headingSm()),
                ),
              ],
              if (widget.searchHint != null) ...[
                Padding(
                  padding: EdgeInsets.all(16.r),
                  child: EwaTextField(
                    controller: _searchController,
                    hintText: widget.searchHint!,
                    borderRadius: 12,
                    prefixIcon: Icon(Icons.search, size: 20.sp, color: EwaColorFoundation.neutral500),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear, size: 20.sp, color: EwaColorFoundation.neutral500),
                            onPressed: () => _searchController.clear(),
                          )
                        : null,
                    onChanged: (_) {},
                  ),
                ),
              ] else if (widget.labelText != null)
                SizedBox(height: 16.h),
              Flexible(
                child: filtered.isEmpty
                    ? Padding(
                        padding: EdgeInsets.all(24.r),
                        child: Text(
                          widget.emptyMessage ?? 'Tidak ada data',
                          style: EwaTypography.bodySm(),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: filtered.length,
                        itemBuilder: (ctx, i) {
                          final item = filtered[i];
                          return _OptionTile<T>(
                            item: item,
                            isSelected: item.value == widget.value,
                            onTap: () => widget.onSelected(item.value),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _OptionTile<T> extends StatelessWidget {
  const _OptionTile({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final EwaSelectItem<T> item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: item.child ?? Text(item.label),
      trailing: isSelected ? Icon(Icons.check, color: EwaColorFoundation.getPrimary(context), size: 20.sp) : null,
      onTap: onTap,
    );
  }
}

class _LazySelectContent<T> extends StatefulWidget {
  const _LazySelectContent({
    required this.itemCount,
    this.itemCountNotifier,
    this.isLoadingNotifier,
    required this.itemBuilder,
    required this.onLoadMore,
    required this.isLoading,
    required this.value,
    required this.onSelected,
    this.labelText,
    this.emptyMessage,
    this.searchHint,
    this.onSearch,
  });

  final int itemCount;
  final ValueNotifier<int>? itemCountNotifier;
  final ValueNotifier<bool>? isLoadingNotifier;
  final EwaSelectItem<T> Function(BuildContext context, int index) itemBuilder;
  final Future<void> Function() onLoadMore;
  final bool isLoading;
  final T? value;
  final ValueChanged<T?> onSelected;
  final String? labelText;
  final String? emptyMessage;
  final String? searchHint;
  final void Function(String query)? onSearch;

  @override
  State<_LazySelectContent<T>> createState() => _LazySelectContentState<T>();
}

class _LazySelectContentState<T> extends State<_LazySelectContent<T>> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    if (widget.searchHint != null && widget.onSearch != null) {
      _searchController.addListener(_onSearchChanged);
    }
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 300), () {
      widget.onSearch?.call(_searchController.text.trim());
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients || _isLoading) return;
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 80) {
      widget.onLoadMore();
    }
  }

  Widget _buildContent(int count) {
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
      decoration: BoxDecoration(
        color: EwaColorFoundation.resolveColor(
          context,
          EwaColorFoundation.neutral50,
          EwaColorFoundation.neutral900,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: EwaColorFoundation.resolveColor(
                context,
                EwaColorFoundation.neutral300,
                EwaColorFoundation.neutral600,
              ),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          if (widget.labelText != null) ...[
            Padding(
              padding: EdgeInsets.fromLTRB(16.r, 16.r, 16.r, 0),
              child: Text(widget.labelText!, style: EwaTypography.headingSm()),
            ),
          ],
          if (widget.searchHint != null && widget.onSearch != null) ...[
            Padding(
              padding: EdgeInsets.all(16.r),
              child: EwaTextField(
                controller: _searchController,
                hintText: widget.searchHint!,
                borderRadius: 12,
                prefixIcon: Icon(Icons.search, size: 20.sp, color: EwaColorFoundation.neutral500),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, size: 20.sp, color: EwaColorFoundation.neutral500),
                        onPressed: () {
                          _searchController.clear();
                          widget.onSearch?.call('');
                        },
                      )
                    : null,
                onChanged: (_) {},
              ),
            ),
          ] else if (widget.labelText != null)
            SizedBox(height: 16.h),
          Flexible(
            child: count == 0 && !_isLoading
                ? Padding(
                    padding: EdgeInsets.all(24.r),
                    child: Text(
                      widget.emptyMessage ?? 'Tidak ada data',
                      style: EwaTypography.bodySm(),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: count + (_isLoading ? 1 : 0),
                    itemBuilder: (ctx, i) {
                      if (i >= count) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: Center(
                            child: EwaLoading.circularProgress(size: 24),
                          ),
                        );
                      }
                      final item = widget.itemBuilder(context, i);
                      return _OptionTile<T>(
                        item: item,
                        isSelected: item.value == widget.value,
                        onTap: () => widget.onSelected(item.value),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  bool get _isLoading => widget.isLoadingNotifier?.value ?? widget.isLoading;

  @override
  Widget build(BuildContext context) {
    final listenables = <Listenable>[
      if (widget.itemCountNotifier != null) widget.itemCountNotifier!,
      if (widget.isLoadingNotifier != null) widget.isLoadingNotifier!,
      if (widget.searchHint != null && widget.onSearch != null) _searchController,
    ];
    if (listenables.isEmpty) {
      return _buildContent(widget.itemCount);
    }
    return ListenableBuilder(
      listenable: Listenable.merge(listenables),
      builder: (context, _) => _buildContent(
        widget.itemCountNotifier?.value ?? widget.itemCount,
      ),
    );
  }
}
