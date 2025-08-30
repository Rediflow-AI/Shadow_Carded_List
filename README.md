<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# shadowed_carded_list

Lightweight Flutter package that provides a polished card-style container
with a shadowed, scrollable list area. The package includes a small set of
UI helpers (a tertiary icon button) and an example app demonstrating usage.

This package is intended for apps that need a reusable, visually consistent
carded list with subtle shadow gradients and a convenient scroll-to-bottom
control.

## Features

- Carded container with configurable decoration and spacing
- Shadowed scroll area with top/bottom fade shadows that appear when
  content overflows
- Optional scroll-to-bottom control (tertiary icon button)
- Empty-list messaging
- Small, dependency-free API suitable for publishing to pub.dev

## Quick example

```dart
import 'package:shadowed_carded_list/shadowed_carded_list.dart';
import 'package:flutter/material.dart';

class Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = List.generate(10, (i) => 'Item ${i + 1}');

    return CardedList<String>(
      header: const Text('My list'),
      footer: Text('${items.length} items'),
      items: items,
      itemBuilder: (context, index) => ListTile(title: Text(items[index])),
    );
  }
}
```

## Getting started

1. Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  shadowed_carded_list: ^0.1.0
```

2. Import the package and use `CardedList` as shown in the quick example.

## API

Public symbols exported from the package:

- `CardedList<T>` — Primary widget. Key parameters:
  - `header`: required header widget
  - `footer`: optional footer widget
  - `items`: required `List<T>` of items
  - `itemBuilder`: required builder `(BuildContext, int) -> Widget?`
  - `emptyListMessage`: optional text shown when list is empty
  - `cardDecoration`, `headerPadding`, `spacing` for styling

- `ShadowedScrollableList<T>` — Lower-level widget if you need the scroll
  region without the outer card.

- `TertiaryIconButton` — Small circular icon control used by the
  scroll-to-bottom behavior.

See the `example/` folder for a working demo.

## Example app

Run the example app to see the widget in action:

```bash
cd example
flutter pub get
flutter run
```

## Contributing

Contributions are welcome. Please open issues for bugs and feature requests
and send pull requests for improvements. Follow the repository coding style
and include tests where possible.

## License

This project includes a `LICENSE` file in the repository root. By
contributing you agree to the terms of that license.

---
Package maintained by Rediflow AI.
