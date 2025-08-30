import 'package:flutter/material.dart';
import 'package:shadowed_carded_list/src/shadowed_scrollable_list.dart';

/// A compact, reusable carded list widget with a header, optional footer,
/// and a scrollable list body.
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

  final Widget header;
  final Widget? footer;
  final EdgeInsets? footerPadding;
  final List<T> items;
  final String? emptyListMessage;
  final Widget? Function(BuildContext context, int index) itemBuilder;
  final BoxDecoration? cardDecoration;
  final EdgeInsets headerPadding;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final decoration =
        cardDecoration ??
        BoxDecoration(
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
          Expanded(
            child: ShadowedScrollableList<T>(
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
