## 0.1.2
* Refactor: Remove redundant documentationRemoved redundant documentation from `dynamic_wrapper.dart` that was already present in other parts of the codebase, improving code clarity.

## 0.1.1
- Refactor: Improve code documentation and structureThis commit refactors the codebase to improve documentation and structure:- Adds detailed documentation to all classes, methods, and properties, making the code easier to understand and maintain.
* Refactors code to enhance readability and organization.
* Improves code style and consistency.
* Introduces more informative assertions for debugging purposes.
* Provides clearer explanations of color schemes and dynamic color support.
* Improves the usability and clarity of the theme settings and dynamic widget functionality.
* 
## 0.1.0
* Updates Flutter SDK constraint to `>=3.27.0`.
* Refactors theme settings to store seed color as an integer.
* Updates DynamicWidget to use an empty list for `navigatorObservers`.
* Adds helper functions for color conversion.
* Fixes INFO: `deprecated_member_use` The analyzer produces this diagnostic when a deprecated library or class member is used in a different package.

## 0.0.9
* Removed the unused package_info_plus dependency.
* Updated version from 0.0.8 to 0.0.9.

## 0.0.8
* Update material_color_utilities version constraint

## 0.0.7
* Update material_color_utilities version constraint

## 0.0.6
* Update screenshots path to use raw.githubusercontent.com.

## 0.0.5
* Fixes static analysis issue: "An uninitialized field should have an explicit type annotation."
* Updated the minimum Flutter version to 3.24.5.
* Improved README.md with clearer instructions and updated screenshots.

## 0.0.4
* All of the package dependencies are supported in the latest version
* Adds `ChangeNotifier` class to include parameters to change theme using through the 
  implementation of `ChangeThemeSwitchWidget` & `ChangeThemeChoiceListTileWidget`.
* Adds `ChangeThemeChoiceListTileWidget` Widget to switching between `Light` `Dark` & `System` Theme.
* Adds `ChangeThemeSwitchWidget` Widget to switching between `Light` & `Dark` Theme.
* Fixes INFO: `useInheritedMediaQuery` is deprecated and shouldn't be used. Remove this parameter as it is now ignored. MaterialApp never introduces its own `MediaQuery;` the View widget takes care of that. This feature was deprecated after v3.7.0-29.0.pre.


## 0.0.3
* All of the package dependencies are supported in the latest version.


## 0.0.2
* Fixes INFO: `renderView` is deprecated and shouldn't be used. Consider using `RendererBinding.renderViews` instead as the binding may manage multiple RenderViews. This feature was deprecated after v3.10.0-12.0.pre.
* All of the package dependencies are supported in the latest version.


## 0.0.1
* Open beta release of the `Material You Dynamic Theme` plugin.
  Please see the [README](https://github.com/AKB0N/material_you_dynamic_theme/blob/main/README.md) for updated integration steps.
```bash
flutter pub add material_you_dynamic_theme
```

