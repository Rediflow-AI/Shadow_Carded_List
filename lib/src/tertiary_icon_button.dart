import 'package:flutter/material.dart';

/// A minimal tertiary-style icon button used by the demo scroll button.
class TertiaryIconButton extends StatelessWidget {
  const TertiaryIconButton({
    super.key,
    required this.onPressed,
    required this.iconData,
    this.size = 40,
  });

  final VoidCallback onPressed;
  final IconData iconData;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
          ),
          child: Icon(
            iconData,
            size: size * 0.6,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
    );
  }
}
