library shadowed_carded_list;

import 'package:flutter/material.dart';

/// A compact, reusable carded list widget with a header, optional footer,
/// and a scrollable list body. This package-hosted implementation is
/// dependency-free (no GetX or app-specific controllers) so it can be
/// published and reused across projects.
class CardedList<T> extends StatelessWidget {
  const CardedList({
    super.key,
    required this.header,
    this.footer,
    this.footerPadding,
    required this.items,
    required this.itemBuilder,
    this.emptyListMessage,
    this.cardDecoration,
    this.headerPadding = const EdgeInsets.all(16),
    this.spacing = 8.0,
  });

  /// Widget shown at the top of the card.
  final Widget header;

  /// Optional widget shown at the bottom of the card.
  final Widget? footer;

  /// Padding around the footer area.
  final EdgeInsets? footerPadding;

  /// Items to render inside the list. Typed to allow static checking.
  final List<T> items;

  /// Message to display when [items] is empty.
  final String? emptyListMessage;

  /// Builder that produces each list item. Must return a Widget (can be null,
  /// which will be treated as an empty box).
  final Widget? Function(BuildContext context, int index) itemBuilder;

  /// Optional decoration for the outer card. If omitted a sensible default
  /// using the current theme is used.
  final BoxDecoration? cardDecoration;

  /// Padding applied to the header area.
  final EdgeInsets headerPadding;

  /// Vertical spacing used in the layout.
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final decoration = cardDecoration ?? BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );

    return Container(
      decoration: decoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(padding: headerPadding, child: header),
          const Divider(height: 1),
          SizedBox(height: spacing),
          // Expand the scrollable list to fill remaining space when used
          // inside a constrained parent (like a sized box or scaffold body).
          Expanded(
            child: _ShadowedScrollableList<T>(
              items: items,
              emptyListMessage: emptyListMessage,
              listBuilder: itemBuilder,
            ),
          ),
          SizedBox(height: spacing),
          const Divider(height: 1),
          if (footer != null)
            Padding(
              padding: footerPadding ?? const EdgeInsets.all(16),
              child: footer,
            ),
        ],
      ),
    );
  }
}

class _ShadowedScrollableList<T> extends StatelessWidget {
  const _ShadowedScrollableList({
    required this.items,
    required this.listBuilder,
    this.emptyListMessage,
  });

  final List<T> items;
  final String? emptyListMessage;
  final Widget? Function(BuildContext context, int index) listBuilder;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Text(emptyListMessage ?? 'No items'),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      itemCount: items.length,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) => listBuilder(context, index) ?? const SizedBox.shrink(),
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}
