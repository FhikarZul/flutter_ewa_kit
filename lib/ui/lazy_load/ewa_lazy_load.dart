import 'package:ewa_kit/foundations/color/color.dart';
import 'package:ewa_kit/ui/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EwaLazyLoad extends StatefulWidget {
  final int page;
  final int totalPage;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;
  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;
  final Function(int) onChanged;
  final bool isLoading;
  final Function()? onRefresh;
  final String? emptyMessage;

  const EwaLazyLoad({
    super.key,
    this.controller,
    required this.page,
    required this.totalPage,
    required this.itemCount,
    required this.itemBuilder,
    required this.isLoading,
    required this.onChanged,
    this.padding,
    this.onRefresh,
    this.emptyMessage,
  });

  @override
  State<EwaLazyLoad> createState() => _EwaLazyLoadState();
}

class _EwaLazyLoadState extends State<EwaLazyLoad> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _scrollController = ScrollController();
    } else {
      _scrollController = widget.controller!;
    }

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _scrollController
        ..removeListener(_onScroll)
        ..dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 800));
        widget.onRefresh?.call();
      },
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          if (widget.itemCount == 0)
            SliverToBoxAdapter(
              child: Padding(
                padding: widget.padding ?? EdgeInsets.zero,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: EwaColorFoundation.neutral100,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.r),
                    child: Text(
                      widget.emptyMessage ?? 'Tidak ada data',
                      style: EwaTypography.bodySm().copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: widget.padding ?? EdgeInsets.zero,
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  widget.itemBuilder,
                  childCount: widget.itemCount,
                ),
              ),
            ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 4.h),
                if (resolvePage() != resolveTotalPage())
                  SizedBox(
                    height: 30.h,
                    child: widget.isLoading
                        ? Center(
                            child: SizedBox(
                              width: 30.r,
                              height: 30.r,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : const SizedBox(),
                  ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int resolveTotalPage() {
    return widget.totalPage == 0 ? 1 : widget.totalPage;
  }

  int resolvePage() {
    return widget.page == 0 ? 1 : widget.page;
  }

  void _onScroll() {
    if (_isBottom) {
      int page = resolvePage();
      int totalPage = resolveTotalPage();
      if (page != totalPage) {
        widget.onChanged.call(page + 1);
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    return currentScroll >= (maxScroll);
  }
}
