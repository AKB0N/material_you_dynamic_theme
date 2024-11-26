import 'package:material_you_dynamic_theme/src/dynamic_scheme.dart';
import 'package:material_you_dynamic_theme/src/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A widget that provides a `BrightnessGetColorScheme` based on the current settings.
///
/// This widget takes a builder function that receives a `BrightnessGetColorScheme` and builds the widget tree.
/// It automatically selects the appropriate color scheme based on the `SettingsModel` and whether dynamic color is supported.
class BrightnessGetColorSchemeBuilder extends StatelessWidget {
  /// The builder function that receives the `BrightnessGetColorScheme` and builds the widget tree.
  final Widget Function(BrightnessGetColorScheme colorScheme) builder;

  /// Creates a `BrightnessGetColorSchemeBuilder`.
  const BrightnessGetColorSchemeBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsModel>();
    final systemColorScheme = context.read<BrightnessGetColorScheme>();

    /// Create a custom color scheme based on the user's seed color.
    final customColorScheme = BrightnessGetColorScheme.fromAccentColor(
      settings.seedColor,
      isDynamicColorSupported: systemColorScheme.isDynamicColorSupported,
    );

    /// If dynamic color is not supported, use the custom color scheme.
    if (!systemColorScheme.isDynamicColorSupported) {
      return builder(customColorScheme);
    }

    /// Otherwise, use the system color scheme if the user has selected "System" or the custom color scheme if the user has selected "Custom".
    switch (settings.colorSchemeType) {
      case ColorSchemeType.system:
        return builder(systemColorScheme);
      case ColorSchemeType.custom:
        return builder(customColorScheme);
    }
  }
}
