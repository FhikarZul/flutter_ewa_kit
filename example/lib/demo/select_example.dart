import 'package:ewa_kit/ewa_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Demo screen for EwaSelect with static and lazy load modes.
class SelectExampleScreen extends StatefulWidget {
  const SelectExampleScreen({super.key});

  @override
  State<SelectExampleScreen> createState() => _SelectExampleScreenState();
}

class _SelectExampleScreenState extends State<SelectExampleScreen> {
  String? _staticValue;
  int? _lazyValue;
  String? _lazyLabel;
  final List<EwaSelectItem<int>> _lazyItems = [];
  final ValueNotifier<int> _lazyItemCount = ValueNotifier(0);
  int _lazyPage = 1;
  bool _lazyLoading = false;
  static const int _pageSize = 10;
  static const int _totalItems = 50;

  Future<void> _loadLazyPage() async {
    if (_lazyLoading) return;
    _lazyLoading = true;
    setState(() {});

    await Future.delayed(const Duration(milliseconds: 500));

    final start = (_lazyPage - 1) * _pageSize;
    if (start < _totalItems) {
      final end = (start + _pageSize).clamp(0, _totalItems);
      for (var i = start; i < end; i++) {
        _lazyItems.add(EwaSelectItem(value: i + 1, label: 'Item ${i + 1}'));
      }
      _lazyPage++;
    }

    _lazyLoading = false;
    _lazyItemCount.value = _lazyItems.length;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadLazyPage();
  }

  @override
  void dispose() {
    _lazyItemCount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Example'),
        backgroundColor: EwaColorFoundation.getPrimary(context),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Static Mode', style: EwaTypography.headingLg()),
            SizedBox(height: 12.h),
            EwaSelect<String>(
              labelText: 'Country',
              hintText: 'Pilih negara',
              helperText: 'Contoh dengan daftar statis',
              items: const [
                EwaSelectItem(value: 'id', label: 'Indonesia'),
                EwaSelectItem(value: 'my', label: 'Malaysia'),
                EwaSelectItem(value: 'sg', label: 'Singapore'),
                EwaSelectItem(value: 'th', label: 'Thailand'),
                EwaSelectItem(value: 'vn', label: 'Vietnam'),
              ],
              value: _staticValue,
              onChanged: (v) => setState(() => _staticValue = v),
              validator: (v) => v == null ? 'Pilih salah satu' : null,
            ),
            SizedBox(height: 24.h),
            Text('Lazy Load Mode', style: EwaTypography.headingLg()),
            SizedBox(height: 12.h),
            EwaSelect<int>.lazy(
              labelText: 'Item (50 total)',
              hintText: 'Pilih item',
              helperText: 'Scroll untuk load more',
              itemCount: _lazyItems.length,
              itemCountNotifier: _lazyItemCount,
              itemBuilder: (context, index) => _lazyItems[index],
              onLoadMore: _loadLazyPage,
              isLoading: _lazyLoading,
              value: _lazyValue,
              selectedLabel: _lazyLabel,
              onChanged: (v) {
                final item = _lazyItems.cast<EwaSelectItem<int>?>().firstWhere(
                      (i) => i?.value == v,
                      orElse: () => null,
                    );
                setState(() {
                  _lazyValue = v;
                  _lazyLabel = item?.label;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
