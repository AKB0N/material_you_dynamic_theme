import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

/// Extension to convert a `DynamicScheme` to a `ColorScheme`.
extension _DynamicSchemeToColorScheme on DynamicScheme {
  /// Converts a `DynamicScheme` to a `ColorScheme`.
  ///
  /// This method maps each color in the `DynamicScheme` to its corresponding color in the `ColorScheme`.
  ///
  /// **Color Explanation:**
  ///
  /// * **`primary`:**  The main color for your app's branding. It's often used for buttons, icons, and other interactive elements.
  /// * **`onPrimary`:**  The text color used on top of the `primary` color. It should provide good contrast.
  /// * **`primaryContainer`:**  A slightly darker shade of `primary` used for backgrounds of interactive elements (like containers or lists).
  /// * **`onPrimaryContainer`:** The text color used on top of the `primaryContainer` color.
  /// * **`primaryFixed`:** The base hue of the `primary` color, used in situations where a more saturated color is desired.
  /// * **`primaryFixedDim`:** A dimmer version of `primaryFixed`.
  /// * **`onPrimaryFixed`:**  The text color used on top of `primaryFixed`.
  /// * **`onPrimaryFixedVariant`:** The text color used on top of a darker shade of `primaryFixed`.
  /// * **`secondary`:** A secondary color that complements your `primary` color. It's used for less important elements than `primary`.
  /// * **`onSecondary`:** The text color used on top of the `secondary` color.
  /// * **`secondaryContainer`:** A slightly darker shade of `secondary`, used for backgrounds of elements.
  /// * **`onSecondaryContainer`:** The text color used on top of the `secondaryContainer` color.
  /// * **`secondaryFixed`:** The base hue of the `secondary` color.
  /// * **`secondaryFixedDim`:** A dimmer version of `secondaryFixed`.
  /// * **`onSecondaryFixed`:**  The text color used on top of `secondaryFixed`.
  /// * **`onSecondaryFixedVariant`:** The text color used on top of a darker shade of `secondaryFixed`.
  /// * **`tertiary`:** A third color used for accents or to provide visual variety.
  /// * **`onTertiary`:**  The text color used on top of the `tertiary` color.
  /// * **`tertiaryContainer`:** A slightly darker shade of `tertiary`, used for backgrounds of elements.
  /// * **`onTertiaryContainer`:** The text color used on top of the `tertiaryContainer` color.
  /// * **`tertiaryFixed`:** The base hue of the `tertiary` color.
  /// * **`tertiaryFixedDim`:** A dimmer version of `tertiaryFixed`.
  /// * **`onTertiaryFixed`:**  The text color used on top of `tertiaryFixed`.
  /// * **`onTertiaryFixedVariant`:** The text color used on top of a darker shade of `tertiaryFixed`.
  /// * **`error`:**  The color used for error messages.
  /// * **`onError`:**  The text color used on top of the `error` color.
  /// * **`errorContainer`:** A slightly darker shade of `error`, used for backgrounds of error elements.
  /// * **`onErrorContainer`:** The text color used on top of the `errorContainer` color.
  /// * **`outline`:**  The color used for borders and outlines.
  /// * **`outlineVariant`:** A slightly darker shade of `outline`.
  /// * **`surface`:**  The main background color of your app.
  /// * **`surfaceDim`:** A slightly darker shade of `surface`, used for backgrounds of elements.
  /// * **`surfaceBright`:** A slightly lighter shade of `surface`, used for backgrounds of elements.
  /// * **`surfaceContainerLowest`:** The lightest shade of the `surfaceContainer` color.
  /// * **`surfaceContainerLow`:** The second lightest shade of the `surfaceContainer` color.
  /// * **`surfaceContainer`:**  A base color used for the backgrounds of containers.
  /// * **`surfaceContainerHigh`:** The second darkest shade of the `surfaceContainer` color.
  /// * **`surfaceContainerHighest`:** The darkest shade of the `surfaceContainer` color.
  /// * **`onSurface`:** The text color used on top of the `surface` color.
  /// * **`onSurfaceVariant`:** The text color used on top of the `surface` color when there's a light background.
  /// * **`inverseSurface`:**  The background color used for a dark UI on a light background.
  /// * **`onInverseSurface`:** The text color used on top of `inverseSurface`.
  /// * **`inversePrimary`:** The primary color used in an inverse surface theme.
  /// * **`shadow`:**  The color used for shadows.
  /// * **`scrim`:**  The color used for a semi-transparent overlay.
  /// * **`surfaceTint`:**  The color used for the subtle tint of the surface.
  ColorScheme toColorScheme() => ColorScheme(
        primary: Color(MaterialDynamicColors.primary.getArgb(this)),
        // Get the primary color from the DynamicScheme
        onPrimary: Color(MaterialDynamicColors.onPrimary.getArgb(this)),
        // Get the onPrimary color from the DynamicScheme
        primaryContainer:
            Color(MaterialDynamicColors.primaryContainer.getArgb(this)),
        // Get the primaryContainer color from the DynamicScheme
        onPrimaryContainer:
            Color(MaterialDynamicColors.onPrimaryContainer.getArgb(this)),
        // Get the onPrimaryContainer color from the DynamicScheme
        primaryFixed: Color(MaterialDynamicColors.primaryFixed.getArgb(this)),
        // Get the primaryFixed color from the DynamicScheme
        primaryFixedDim:
            Color(MaterialDynamicColors.primaryFixedDim.getArgb(this)),
        // Get the primaryFixedDim color from the DynamicScheme
        onPrimaryFixed:
            Color(MaterialDynamicColors.onPrimaryFixed.getArgb(this)),
        // Get the onPrimaryFixed color from the DynamicScheme
        onPrimaryFixedVariant:
            Color(MaterialDynamicColors.onPrimaryFixedVariant.getArgb(this)),
        // Get the onPrimaryFixedVariant color from the DynamicScheme
        secondary: Color(MaterialDynamicColors.secondary.getArgb(this)),
        // Get the secondary color from the DynamicScheme
        onSecondary: Color(MaterialDynamicColors.onSecondary.getArgb(this)),
        // Get the onSecondary color from the DynamicScheme
        secondaryContainer:
            Color(MaterialDynamicColors.secondaryContainer.getArgb(this)),
        // Get the secondaryContainer color from the DynamicScheme
        onSecondaryContainer:
            Color(MaterialDynamicColors.onSecondaryContainer.getArgb(this)),
        // Get the onSecondaryContainer color from the DynamicScheme
        secondaryFixed:
            Color(MaterialDynamicColors.secondaryFixed.getArgb(this)),
        // Get the secondaryFixed color from the DynamicScheme
        secondaryFixedDim:
            Color(MaterialDynamicColors.secondaryFixedDim.getArgb(this)),
        // Get the secondaryFixedDim color from the DynamicScheme
        onSecondaryFixed:
            Color(MaterialDynamicColors.onSecondaryFixed.getArgb(this)),
        // Get the onSecondaryFixed color from the DynamicScheme
        onSecondaryFixedVariant:
            Color(MaterialDynamicColors.onSecondaryFixedVariant.getArgb(this)),
        // Get the onSecondaryFixedVariant color from the DynamicScheme
        tertiary: Color(MaterialDynamicColors.tertiary.getArgb(this)),
        // Get the tertiary color from the DynamicScheme
        onTertiary: Color(MaterialDynamicColors.onTertiary.getArgb(this)),
        // Get the onTertiary color from the DynamicScheme
        tertiaryContainer:
            Color(MaterialDynamicColors.tertiaryContainer.getArgb(this)),
        // Get the tertiaryContainer color from the DynamicScheme
        onTertiaryContainer:
            Color(MaterialDynamicColors.onTertiaryContainer.getArgb(this)),
        // Get the onTertiaryContainer color from the DynamicScheme
        tertiaryFixed: Color(MaterialDynamicColors.tertiaryFixed.getArgb(this)),
        // Get the tertiaryFixed color from the DynamicScheme
        tertiaryFixedDim:
            Color(MaterialDynamicColors.tertiaryFixedDim.getArgb(this)),
        // Get the tertiaryFixedDim color from the DynamicScheme
        onTertiaryFixed:
            Color(MaterialDynamicColors.onTertiaryFixed.getArgb(this)),
        // Get the onTertiaryFixed color from the DynamicScheme
        onTertiaryFixedVariant:
            Color(MaterialDynamicColors.onTertiaryFixedVariant.getArgb(this)),
        // Get the onTertiaryFixedVariant color from the DynamicScheme
        error: Color(MaterialDynamicColors.error.getArgb(this)),
        // Get the error color from the DynamicScheme
        onError: Color(MaterialDynamicColors.onError.getArgb(this)),
        // Get the onError color from the DynamicScheme
        errorContainer:
            Color(MaterialDynamicColors.errorContainer.getArgb(this)),
        // Get the errorContainer color from the DynamicScheme
        onErrorContainer:
            Color(MaterialDynamicColors.onErrorContainer.getArgb(this)),
        // Get the onErrorContainer color from the DynamicScheme
        outline: Color(MaterialDynamicColors.outline.getArgb(this)),
        // Get the outline color from the DynamicScheme
        outlineVariant:
            Color(MaterialDynamicColors.outlineVariant.getArgb(this)),
        // Get the outlineVariant color from the DynamicScheme
        surface: Color(MaterialDynamicColors.surface.getArgb(this)),
        // Get the surface color from the DynamicScheme
        surfaceDim: Color(MaterialDynamicColors.surfaceDim.getArgb(this)),
        // Get the surfaceDim color from the DynamicScheme
        surfaceBright: Color(MaterialDynamicColors.surfaceBright.getArgb(this)),
        // Get the surfaceBright color from the DynamicScheme
        surfaceContainerLowest:
            Color(MaterialDynamicColors.surfaceContainerLowest.getArgb(this)),
        // Get the surfaceContainerLowest color from the DynamicScheme
        surfaceContainerLow:
            Color(MaterialDynamicColors.surfaceContainerLow.getArgb(this)),
        // Get the surfaceContainerLow color from the DynamicScheme
        surfaceContainer:
            Color(MaterialDynamicColors.surfaceContainer.getArgb(this)),
        // Get the surfaceContainer color from the DynamicScheme
        surfaceContainerHigh:
            Color(MaterialDynamicColors.surfaceContainerHigh.getArgb(this)),
        // Get the surfaceContainerHigh color from the DynamicScheme
        surfaceContainerHighest:
            Color(MaterialDynamicColors.surfaceContainerHighest.getArgb(this)),
        // Get the surfaceContainerHighest color from the DynamicScheme
        onSurface: Color(MaterialDynamicColors.onSurface.getArgb(this)),
        // Get the onSurface color from the DynamicScheme
        onSurfaceVariant:
            Color(MaterialDynamicColors.onSurfaceVariant.getArgb(this)),
        // Get the onSurfaceVariant color from the DynamicScheme
        inverseSurface:
            Color(MaterialDynamicColors.inverseSurface.getArgb(this)),
        // Get the inverseSurface color from the DynamicScheme
        onInverseSurface:
            Color(MaterialDynamicColors.inverseOnSurface.getArgb(this)),
        // Get the onInverseSurface color from the DynamicScheme
        inversePrimary:
            Color(MaterialDynamicColors.inversePrimary.getArgb(this)),
        // Get the inversePrimary color from the DynamicScheme
        shadow: Color(MaterialDynamicColors.shadow.getArgb(this)),
        // Get the shadow color from the DynamicScheme
        scrim: Color(MaterialDynamicColors.scrim.getArgb(this)),
        // Get the scrim color from the DynamicScheme
        surfaceTint: Color(MaterialDynamicColors.primary.getArgb(this)),
        // Get the surfaceTint color from the DynamicScheme
        brightness: isDark
            ? Brightness.dark
            : Brightness.light, // Set the brightness based on the DynamicScheme
      );
}

/// Extension to convert a `CorePalette` to a `DynamicScheme`.
extension _CorePaletteToDynamicScheme on CorePalette {
  /// Converts a `CorePalette` to a `DynamicScheme`.
  ///
  /// This method uses the provided `brightness` to determine the correct dynamic color scheme.
  DynamicScheme toDynamicScheme({required Brightness brightness}) =>
      DynamicScheme(
        sourceColorArgb: primary.get(
          switch (brightness) {
            Brightness.light => 40,
            Brightness.dark => 80,
          },
        ),
        variant: Variant.tonalSpot,
        isDark: brightness == Brightness.dark,
        primaryPalette: primary,
        secondaryPalette: secondary,
        tertiaryPalette: tertiary,
        neutralPalette: neutral,
        neutralVariantPalette: neutralVariant,
      );
}

/// Asynchronously loads the color scheme, handling both dynamic and non-dynamic color scenarios.
///
/// This function attempts to load the color scheme using the `DynamicColorPlugin`.
/// If the plugin is not available or fails to load, it falls back to a static color scheme based on the provided `fallbackSeedColor`.
Future<BrightnessGetColorScheme> loadColorScheme(
    {required Color fallbackSeedColor}) async {
  try {
    final corePalette = await DynamicColorPlugin.getCorePalette();

    if (corePalette != null) {
      return BrightnessGetColorScheme.fromCorePaletteWorkaround(corePalette);
    }
  } on PlatformException {
    // ignore
  }

  try {
    final accentColor = await DynamicColorPlugin.getAccentColor();

    if (accentColor != null) {
      return BrightnessGetColorScheme.fromAccentColor(accentColor,
          isDynamicColorSupported: true);
    }
  } on PlatformException {
    // ignore
  }

  return BrightnessGetColorScheme.fromAccentColor(
    fallbackSeedColor,
    isDynamicColorSupported: false,
  );
}

/// Class to represent a color scheme that adapts to different brightness levels.
class BrightnessGetColorScheme {
  /// Color scheme for light mode.
  final ColorScheme light;

  /// Color scheme for dark mode.
  final ColorScheme dark;

  /// Flag indicating whether dynamic color is supported.
  final bool isDynamicColorSupported;

  /// Constructor for `BrightnessGetColorScheme`.
  BrightnessGetColorScheme({
    required this.light,
    required this.dark,
    required this.isDynamicColorSupported,
  });

  /// Creates a `BrightnessGetColorScheme` from a `CorePalette` using the workaround for Flutter 3.21+.
  ///
  /// This constructor converts the `CorePalette` to a `DynamicScheme` for both light and dark modes and then to `ColorScheme` objects.
  BrightnessGetColorScheme.fromCorePaletteWorkaround(CorePalette palette)
      : this(
          light: palette
              .toDynamicScheme(brightness: Brightness.light)
              .toColorScheme(),
          dark: palette
              .toDynamicScheme(brightness: Brightness.dark)
              .toColorScheme(),
          isDynamicColorSupported: true,
        );

  /// Creates a `BrightnessGetColorScheme` from a `CorePalette`.
  ///
  /// This constructor is deprecated in favor of `fromCorePaletteWorkaround` for Flutter 3.21+.
  @Deprecated(
    'Use fromCorePaletteWorkaround instead for Flutter 3.21+.'
    ' See https://github.com/material-foundation/flutter-packages/issues/574',
  )
  BrightnessGetColorScheme.fromCorePalette(CorePalette palette)
      : this(
          light: palette.toColorScheme(brightness: Brightness.light),
          dark: palette.toColorScheme(brightness: Brightness.dark),
          isDynamicColorSupported: true,
        );

  /// Creates a `BrightnessGetColorScheme` from an accent color.
  ///
  /// This constructor creates a static color scheme using the provided `accentColor` and the `isDynamicColorSupported` flag.
  BrightnessGetColorScheme.fromAccentColor(
    Color accentColor, {
    required bool isDynamicColorSupported,
  }) : this(
          light: ColorScheme.fromSeed(
              seedColor: accentColor, brightness: Brightness.light),
          dark: ColorScheme.fromSeed(
              seedColor: accentColor, brightness: Brightness.dark),
          isDynamicColorSupported: isDynamicColorSupported,
        );
}
