Publishing to pub.dev (local dry-run)

Follow these steps locally to validate and publish the package.

1. Remove the local block in `pubspec.yaml` if present:
   - Remove `publish_to: 'none'` or set it to `https://pub.dev`.

2. Update `version:` in `pubspec.yaml` (semantic versioning).

3. Run analysis and tests:

```bash
flutter analyze
flutter test
```

4. Run the dry-run to see any publish-time issues:

```bash
dart pub publish --dry-run
```

5. If dry-run is clean, publish:

```bash
dart pub publish
```

Notes:
- You must be authenticated with pub.dev. Use `dart pub login` if needed.
- If publishing a major update, remember to follow semantic versioning and
  update CHANGELOG.md.
