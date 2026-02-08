import 'package:ewa_kit/ewa_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LazyLoadExampleScreen extends StatefulWidget {
  const LazyLoadExampleScreen({super.key});

  @override
  State<LazyLoadExampleScreen> createState() => _LazyLoadExampleScreenState();
}

class _LazyLoadExampleScreenState extends State<LazyLoadExampleScreen> {
  int _page = 1;
  final int _totalPage = 5;
  bool _isLoading = false;
  final List<int> _items = [];

  Future<void> _loadPage(int page) async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(milliseconds: 800));

    setState(() {
      final start = (page - 1) * 10;
      for (int i = 0; i < 10; i++) {
        _items.add(start + i + 1);
      }
      _page = page;
      _isLoading = false;
    });
  }

  void _onRefresh() {
    setState(() {
      _items.clear();
      _page = 1;
    });
    _loadPage(1);
  }

  @override
  void initState() {
    super.initState();
    _loadPage(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lazy Load Example'),
        backgroundColor: EwaColorFoundation.getPrimary(context),
        foregroundColor: Colors.white,
      ),
      body: EwaLazyLoad(
        page: _page,
        totalPage: _totalPage,
        itemCount: _items.length,
        isLoading: _isLoading,
        onChanged: _loadPage,
        onRefresh: _onRefresh,
        padding: EdgeInsets.all(16.r),
        emptyMessage: 'Pull to refresh to load items',
        itemBuilder: (context, index) {
          final item = _items[index];
          return Container(
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: EwaColorFoundation.resolveColor(
                context,
                EwaColorFoundation.neutral100,
                EwaColorFoundation.neutral800,
              ),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: EwaColorFoundation.neutral300,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: EwaColorFoundation.getPrimary(context),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Text(
                      '$item',
                      style: EwaTypography.headingLg().copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Item #$item',
                        style: EwaTypography.headingSm(),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Page ${((item - 1) / 10).floor() + 1} • Loaded on scroll',
                        style: EwaTypography.bodySm().copyWith(
                          color: EwaColorFoundation.neutral500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
