# shadowed_carded_list example

This folder contains a small Flutter app demonstrating the `shadowed_carded_list` package.

## What the example shows

- A `CardedList` with a header that includes controls to add and clear items.
- A scrollable list body with top/bottom shadow fades that appear when the
  content overflows the card.
- A scroll-to-bottom tertiary icon button that appears when more content
  is available below the visible area.
- Footer showing current item count and an empty-list message when there
  are no items.

## Quick start

1. Ensure you have Flutter installed and a device/emulator available.
2. From the example folder, fetch dependencies and run the app:

    ```bash
    cd example
    flutter pub get
    flutter run
    ```

## Tips

- The example uses a local path dependency to the package; when testing
  changes to the package implementation, `flutter pub get` will pick up
  those changes automatically.
- To test the scroll shadows and scroll-to-bottom button, add enough items
  via the header `+` button so the list exceeds the vertical space.

## Contact

If you find bugs or need features, please open an issue on the repository:
https://github.com/Rediflow-AI/Shadow_Carded_List/issues

## Screenshots

The example includes placeholder screenshots located in `assets/screenshots`.
Replace with real images for README or pub.dev display.

![Example preview](../assets/screenshots/preview.png)
