# material_you_dynamic_theme

A Flutter package that dynamically changes the app's theme based on the dominant colors extracted from the device's wallpaper. This package leverages Android's Dynamic Colors feature (API level 31 and above) for a seamless and visually appealing user experience.

**Note:** This package currently focuses on Android.


## How to use it?
**1.  Add the package to pubspec.yaml dependency:**

```yaml
dependencies:
  material_you_dynamic_theme: ^0.0.2
```

**2. Import package:**

```dart
import 'package:material_you_dynamic_theme/material_you_dynamic_theme.dart';
```

**3. Initialize and use the package:**

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runAppDynamic(
    home: MyHomePage(),
  );
}
```

## Important Considerations:
Android API Level: This package requires Android API level 31 or higher to fully utilize the `Dynamic Colors API`. For older versions, a fallback theme will be used.

### Contributing:
Contributions are welcome! Please open issues for bug reports and feature requests.

## Developer
By [Ibrahim Fathelbab](https://www.akbon.dev/ "Ibrahim Fathelbab")

&copy; All rights reserved.

