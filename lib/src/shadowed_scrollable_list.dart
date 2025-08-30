import 'package:flutter/material.dart';
import 'package:shadowed_carded_list/src/tertiary_icon_button.dart';

class ShadowedScrollableList<T> extends StatefulWidget {
  const ShadowedScrollableList({
    super.key,
    required this.items,
    required this.listBuilder,
    this.emptyListMessage,
    this.separatorBuilder,
    this.shadowSize = 16.0,
    this.shadowColor,
    this.showScrollbar = true,
  });

  final List<T> items;
  final String? emptyListMessage;
  final Widget? Function(BuildContext context, int index) listBuilder;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final double shadowSize;
  final Color? shadowColor;
  final bool showScrollbar;

  @override
  State<ShadowedScrollableList<T>> createState() =>
      _ShadowedScrollableListState<T>();
}

class _ShadowedScrollableListState<T> extends State<ShadowedScrollableList<T>> {
  final ScrollController _scrollController = ScrollController();

  bool _showScrollButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkScrollOverflowed);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _checkScrollOverflowed(),
    );
  }

  void _checkScrollOverflowed() {
    if (!_scrollController.hasClients) return;
    final max = _scrollController.position.maxScrollExtent;
    final offset = _scrollController.offset;
    final canScroll = max > 0;
    setState(() {
      _showScrollButton =
          canScroll && offset < max - 4; // show when not at bottom
    });
  }

  @override
  void didUpdateWidget(covariant ShadowedScrollableList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }
      setState(() {
        _showScrollButton = false;
      });
    }
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _checkScrollOverflowed(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shadowColor = widget.shadowColor ?? Colors.black12;

    return Stack(
      children: [
        // Main scroll area with optional scrollbar
        widget.showScrollbar
            ? Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                child: _buildListView(),
              )
            : _buildListView(),

        // Top shadow
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          height: widget.shadowSize,
          child: IgnorePointer(
            child: AnimatedOpacity(
              opacity:
                  (_scrollController.hasClients && _scrollController.offset > 0)
                  ? 1
                  : 0,
              duration: const Duration(milliseconds: 120),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [shadowColor, shadowColor.withOpacity(0.0)],
                  ),
                ),
              ),
            ),
          ),
        ),

        // Bottom shadow
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: widget.shadowSize,
          child: IgnorePointer(
            child: AnimatedOpacity(
              opacity:
                  (_scrollController.hasClients &&
                      _scrollController.offset <
                          (_scrollController.position.maxScrollExtent - 1))
                  ? 1
                  : 0,
              duration: const Duration(milliseconds: 120),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [shadowColor, shadowColor.withOpacity(0.0)],
                  ),
                ),
              ),
            ),
          ),
        ),

        // Empty message overlay
        if (widget.items.isEmpty)
          Center(
            child: Text(
              widget.emptyListMessage ?? 'No items',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),

        // Scroll-to-bottom button
        if (_showScrollButton)
          Positioned(
            bottom: widget.shadowSize + 8,
            left: 0,
            right: 0,
            child: Center(
              child: TertiaryIconButton(
                onPressed: () {
                  if (!_scrollController.hasClients) return;
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                  setState(() {
                    _showScrollButton = false;
                  });
                },
                iconData: Icons.arrow_drop_down_circle_outlined,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildListView() {
    if (widget.items.isEmpty) {
      // still provide a scrollable box to keep layout stable
      return SingleChildScrollView(
        controller: _scrollController,
        child: const SizedBox(height: 1),
      );
    }

    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      itemCount: widget.items.length,
      itemBuilder: (context, index) =>
          widget.listBuilder(context, index) ?? const SizedBox.shrink(),
      separatorBuilder:
          widget.separatorBuilder ??
          (context, index) => const SizedBox(height: 8),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_checkScrollOverflowed);
    _scrollController.dispose();
    super.dispose();
  }
}
