import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Extensions for removing a prefix from a string.
extension RemovePrefix on String {
  /// Removes a given prefix from the string if it starts with that prefix.
  ///
  /// [prefix] The prefix to remove.
  String removePrefix(String prefix) {
    if (startsWith(prefix)) {
      return substring(prefix.length);
    }
    return this;
  }
}

/// Enum representing different types of color schemes.
enum ColorSchemeType {
  /// System color scheme.
  system,

  /// Custom color scheme.
  custom,
}

/// Default settings model.
final defaults = ThemeSettingsModel(
  themeMode: ThemeMode.system,
  // Default theme mode is system.
  colorSchemeType: ColorSchemeType.system,
  // Default color scheme type is system.
  seedColor: Colors.blueAccent,
  // Default seed color is blueAccent.
  rememberedChoices: {}, // Default remembered choices is an empty map.
);

/// Enum representing keys used for storing settings in SharedPreferences.
enum _ThemeSettingsKeys {
  /// Theme mode key.
  theme,

  /// Color scheme type key.
  colorSchemeType,

  /// Seed color key.
  seedColor,
}

/// Converts a float value to an 8-bit integer.
///
/// [x] The float value to convert.
int floatToInt8(double x) {
  return (x * 255.0).round() & 0xff;
}

/// Converts ARGB values to an integer representation of a color.
///
/// [a] The alpha value (0.0 to 1.0).
/// [r] The red value (0.0 to 1.0).
/// [g] The green value (0.0 to 1.0).
/// [b] The blue value (0.0 to 1.0).
int value({a, r, g, b}) {
  return floatToInt8(a) << 24 |
      floatToInt8(r) << 16 |
      floatToInt8(g) << 8 |
      floatToInt8(b) << 0;
}

/// Prefix used for remembered choices keys in SharedPreferences.
const _rememberedChoicesKeyPrefix = 'remembered.';

/// Fetches settings from SharedPreferences.
///
/// This function retrieves settings from SharedPreferences and returns a `ThemeSettingsModel` object.
/// If any setting is not found in SharedPreferences, the corresponding default value from `defaults` is used.
Future<ThemeSettingsModel> getThemeSettings() async {
  final prefs = await SharedPreferences.getInstance();

  // Get the theme mode from SharedPreferences, or use the default if not found.
  final theme =
      prefs.getString(_ThemeSettingsKeys.theme.name) ?? defaults.themeMode.name;

  // Get the color scheme type from SharedPreferences, or use the default if not found.
  final colorSchemeTypeString =
      prefs.getString(_ThemeSettingsKeys.colorSchemeType.name) ??
          defaults.colorSchemeType.name;

  // Get the seed color from SharedPreferences, or use the default if not found.
  final seedColorInt = prefs.getInt(_ThemeSettingsKeys.seedColor.name) ??
      value(
        a: defaults.seedColor.a,
        r: defaults.seedColor.r,
        g: defaults.seedColor.g,
        b: defaults.seedColor.b,
      );

  // Convert the theme string to a ThemeMode enum.
  final ThemeMode themeMode;
  switch (theme) {
    case 'system':
      themeMode = ThemeMode.system;
      break;
    case 'light':
      themeMode = ThemeMode.light;
      break;
    case 'dark':
      themeMode = ThemeMode.dark;
      break;
    default:
      assert(false, 'Unknown theme mode: $theme'); // Fail for debug builds.
      themeMode = defaults.themeMode; // Use default for release builds.
      break;
  }

  // Convert the color scheme type string to a ColorSchemeType enum.
  final ColorSchemeType colorSchemeType;
  switch (colorSchemeTypeString) {
    case 'system':
      colorSchemeType = ColorSchemeType.system;
      break;
    case 'app' || 'custom':
      colorSchemeType = ColorSchemeType.custom;
      break;
    default:
      assert(false,
          'Unknown color scheme type: $colorSchemeTypeString'); // Fail for debug builds.
      colorSchemeType =
          defaults.colorSchemeType; // Use default for release builds.
      break;
  }

  // Convert the seed color integer to a Color object.
  final seedColor = Color(seedColorInt);

  // Get the remembered choices from SharedPreferences.
  final rememberedChoices = <String, bool>{};
  for (final key in prefs.getKeys()) {
    if (!key.startsWith(_rememberedChoicesKeyPrefix)) {
      continue;
    }
    final value = prefs.getBool(key);
    if (value != null) {
      rememberedChoices[key.removePrefix(_rememberedChoicesKeyPrefix)] = value;
    }
  }

  // Return a new ThemeSettingsModel object with the retrieved settings.
  return ThemeSettingsModel(
    themeMode: themeMode,
    colorSchemeType: colorSchemeType,
    seedColor: seedColor,
    rememberedChoices: rememberedChoices,
  );
}

/// Saves settings to SharedPreferences.
///
/// This function takes a `ThemeSettingsModel` object and saves its settings to SharedPreferences.
///
/// [themeSettings] The `ThemeSettingsModel` object containing the settings to save.
Future<void> saveThemeSettings(ThemeSettingsModel themeSettings) async {
  final prefs = await SharedPreferences.getInstance();

  // Save the theme mode.
  final theme = themeSettings.themeMode.name;

  // Save the color scheme type.
  final colorSchemeTypeString = themeSettings.colorSchemeType.name;

  // Save the seed color.
  final seedColorInt = value(
    a: themeSettings.seedColor.a,
    r: themeSettings.seedColor.r,
    g: themeSettings.seedColor.g,
    b: themeSettings.seedColor.b,
  );

  // Save the settings to SharedPreferences.
  await prefs.setString(_ThemeSettingsKeys.theme.name, theme);
  await prefs.setString(
      _ThemeSettingsKeys.colorSchemeType.name, colorSchemeTypeString);
  await prefs.setInt(_ThemeSettingsKeys.seedColor.name, seedColorInt);

  // Save the remembered choices.
  for (final key in themeSettings._rememberedChoices.keys) {
    final value = themeSettings._rememberedChoices[key];
    if (value != null) {
      await prefs.setBool('$_rememberedChoicesKeyPrefix$key', value);
    } else {
      await prefs.remove('$_rememberedChoicesKeyPrefix$key');
    }
  }
}

/// Model class for storing and managing application settings.
///
/// This class extends `ChangeNotifier` to notify listeners when any setting is changed.
class ThemeSettingsModel with ChangeNotifier {
  /// Theme mode setting.
  ThemeMode _themeMode;

  /// Color scheme type setting.
  ColorSchemeType _colorSchemeType;

  /// Seed color setting.
  Color _seedColor;

  /// Map to store remembered choices.
  final Map<String, bool?> _rememberedChoices;

  /// Getter for checking if dark mode is enabled.
  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  /// Constructor for `ThemeSettingsModel`.
  ///
  /// [themeMode] The initial theme mode.
  /// [colorSchemeType] The initial color scheme type.
  /// [seedColor] The initial seed color.
  /// [rememberedChoices] The initial remembered choices.
  ThemeSettingsModel({
    required ThemeMode themeMode,
    required ColorSchemeType colorSchemeType,
    required Color seedColor,
    required Map<String, bool?> rememberedChoices,
  })  : _themeMode = themeMode,
        _colorSchemeType = colorSchemeType,
        _seedColor = seedColor,
        _rememberedChoices = Map.of(rememberedChoices);

  /// Getter for theme mode.
  ThemeMode get themeMode => _themeMode;

  /// Getter for color scheme type.
  ColorSchemeType get colorSchemeType => _colorSchemeType;

  /// Getter for seed color.
  Color get seedColor => _seedColor;

  /// Getter for remembered choice value.
  ///
  /// [key] The key of the remembered choice.
  bool? getRememberedChoice(String key) => _rememberedChoices[key];

  /// Setter for theme mode.
  ///
  /// This method updates the theme mode setting and optionally saves it to SharedPreferences.
  ///
  /// [value] The new theme mode.
  /// [save] Whether to save the setting to SharedPreferences (default: true).
  void setThemeMode(ThemeMode value, {bool save = true}) {
    _themeMode = value;
    if (save) {
      saveThemeSettings(this);
    }
    notifyListeners();
  }

  /// Setter for color scheme type.
  ///
  /// This method updates the color scheme type setting and optionally saves it to SharedPreferences.
  ///
  /// [value] The new color scheme type.
  /// [save] Whether to save the setting to SharedPreferences (default: true).
  void setColorSchemeType(ColorSchemeType value, {bool save = true}) {
    _colorSchemeType = value;
    if (save) {
      saveThemeSettings(this);
    }
    notifyListeners();
  }

  /// Setter for seed color.
  ///
  /// This method updates the seed color setting and optionally saves it to SharedPreferences.
  ///
  /// [value] The new seed color.
  /// [save] Whether to save the setting to SharedPreferences (default: true).
  void setSeedColor(Color value, {bool save = true}) {
    _seedColor = value;
    if (save) {
      saveThemeSettings(this);
    }
    notifyListeners();
  }

  /// Setter for remembered choice value.
  ///
  /// This method updates the remembered choice value for a given key and optionally saves it to SharedPreferences.
  ///
  /// [key] The key of the remembered choice.
  /// [value] The new value of the remembered choice.
  /// [save] Whether to save the setting to SharedPreferences (default: true).
  void setRememberedChoice(String key, bool value, {bool save = true}) {
    _rememberedChoices[key] = value;
    if (save) {
      saveThemeSettings(this);
    }
  }

  /// Method to forget all remembered choices.
  ///
  /// This method removes all entries from the `_rememberedChoices` map and optionally saves the changes to SharedPreferences.
  ///
  /// [save] Whether to save the changes to SharedPreferences (default: true).
  void forgetRememberedChoices({bool save = true}) {
    for (final key in _rememberedChoices.keys) {
      _rememberedChoices[key] = null;
    }
    if (save) {
      saveThemeSettings(this);
    }
  }
}

/// Widget for changing the application theme.
class ChangeThemeSwitchWidget extends StatelessWidget {
  /// EdgeInsets for padding.
  final EdgeInsets edgeInsets;

  /// Constructor for `ChangeThemeSwitchWidget`.
  ///
  /// [key] The key for the widget.
  /// [edgeInsets] The padding around the switch (default: EdgeInsets.symmetric(horizontal: 8)).
  const ChangeThemeSwitchWidget({
    super.key,
    this.edgeInsets = const EdgeInsets.symmetric(horizontal: 8),
  });

  @override
  Widget build(BuildContext context) {
    // Get the ThemeSettingsModel from the context.
    final themeSettings = context.watch<ThemeSettingsModel>();
    // Build a Padding widget with a Switch.adaptive inside.
    return Padding(
      padding: edgeInsets,
      child: Switch.adaptive(
        value: themeSettings.isDarkMode,
        // The switch is on if dark mode is enabled.
        // Set the thumb icon based on the current theme mode.
        thumbIcon: themeSettings.isDarkMode
            ? WidgetStateProperty.all(const Icon(Icons.dark_mode_outlined))
            : WidgetStateProperty.all(const Icon(Icons.wb_sunny_outlined)),
        onChanged: (value) {
          // When the switch is toggled, update the theme mode.
          themeSettings.isDarkMode
              ? themeSettings.setThemeMode(ThemeMode.light)
              : themeSettings.setThemeMode(ThemeMode.dark);
        },
      ),
    );
  }
}

/// Widget for changing the application theme using a ChoiceListTile.
class ChangeThemeChoiceListTileWidget extends StatelessWidget {
  /// EdgeInsets for padding.
  final EdgeInsets edgeInsets;

  /// Constructor for `ChangeThemeChoiceListTileWidget`.
  ///
  /// [key] The key for the widget.
  /// [edgeInsets] The padding around the list tile (default: EdgeInsets.symmetric(horizontal: 8)).
  const ChangeThemeChoiceListTileWidget({
    super.key,
    this.edgeInsets = const EdgeInsets.symmetric(horizontal: 8),
  });

  @override
  Widget build(BuildContext context) {
    // Get the ThemeSettingsModel from the context.
    final themeSettings = context.watch<ThemeSettingsModel>();
    // Build a Padding widget with a ChoiceListTile inside.
    return Padding(
      padding: edgeInsets,
      child: ChoiceListTile(
        // Set the leading icon based on the current theme mode.
        leading: switch (themeSettings.themeMode) {
          ThemeMode.system => const Icon(Icons.brightness_auto),
          ThemeMode.dark => const Icon(Icons.dark_mode),
          ThemeMode.light => const Icon(Icons.light_mode),
        },
        title: const Text('Theme'),
        // The title of the list tile.
        items: ThemeMode.values,
        // The list of available theme modes.
        // Convert the ThemeMode enum to a string representation.
        itemToString: (item) => switch (item) {
          ThemeMode.system => 'System',
          ThemeMode.light => 'Light',
          ThemeMode.dark => 'Dark',
        },
        index: themeSettings.themeMode.index,
        // The currently selected theme mode index.
        onChanged: themeSettings
            .setThemeMode, // Update the theme mode when a new one is selected.
      ),
    );
  }
}

/// A generic list tile that allows the user to select an item from a list of options.
///
/// The options are presented in a dialog when the tile is tapped.
class ChoiceListTile<T> extends StatelessWidget {
  /// The widget to display before the title.
  final Widget? leading;

  /// The primary content of the list tile.
  final Widget title;

  /// Additional content displayed below the title.
  final Widget? subtitle;

  /// The list of items to choose from.
  final List<T> items;

  /// A function to convert an item to a string representation.
  final ConverterFunction<T, String>? itemToString;

  /// The index of the currently selected item.
  final int index;

  /// Called when the user selects an item.
  final ValueChanged<T> onChanged;

  /// Whether this list tile is interactive.
  final bool enabled;

  /// Creates a `ChoiceListTile`.
  ///
  /// [key] The key for the widget.
  /// [leading] The widget to display before the title.
  /// [title] The primary content of the list tile.
  /// [subtitle] Additional content displayed below the title.
  /// [items] The list of items to choose from.
  /// [itemToString] A function to convert an item to a string representation.
  /// [index] The index of the currently selected item.
  /// [onChanged] Called when the user selects an item.
  /// [enabled] Whether this list tile is interactive (default: true).
  const ChoiceListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    required this.items,
    this.itemToString,
    required this.index,
    required this.onChanged,
    this.enabled = true,
  });

  /// Converts an item to a string representation using the provided `itemToString` function or the item's `toString` method.
  ///
  /// [item] The item to convert.
  String _itemToString(T item) =>
      itemToString == null ? item.toString() : itemToString!(item);

  /// Handles the tile tap event. Shows a dialog with the list of items and calls `onChanged` when an item is selected.
  ///
  /// [context] The build context.
  Future<void> _onTileClick(BuildContext context) async {
    final res = await _showChoiceDialog(
      context: context,
      items: items,
      itemToString: _itemToString,
      title: title,
      selectedIndex: index,
    );
    if (res != null) {
      onChanged(res);
    }
  }

  @override
  Widget build(BuildContext context) => ListTile(
        enabled: enabled,
        // Whether the list tile is interactive.
        leading: leading ?? const SizedBox.shrink(),
        // The leading widget.
        title: title,
        // The primary content of the list tile.
        subtitle: subtitle ?? Text(_itemToString(items[index])),
        // The subtitle, which defaults to the string representation of the selected item.
        onTap: () => _onTileClick(
            context), // Show the choice dialog when the tile is tapped.
      );
}

/// Shows a dialog with a list of items and returns the selected item.
///
/// [context] The build context.
/// [items] The list of items to display.
/// [itemToString] A function to convert an item to a string representation.
/// [title] The title of the dialog.
/// [selectedIndex] The index of the currently selected item.
Future<T?> _showChoiceDialog<T>({
  required BuildContext context,
  required List<T> items,
  ConverterFunction<T, String>? itemToString,
  required Widget title,
  required int? selectedIndex,
}) async =>
    showDialog<T>(
      context: context,
      builder: (context) => SimpleDialog(
        title: title, // The title of the dialog.
        children: [
          // Create a SimpleDialogOption for each item.
          for (var i = 0; i < items.length; i++)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, items[i]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Display the string representation of the item.
                  Text(itemToString?.call(items[i]) ?? items[i].toString()),
                  // Show a checkmark icon if the item is selected.
                  if (i == selectedIndex) const Icon(Icons.check),
                ],
              ),
            ),
        ],
      ),
    );

/// A type definition for a function that converts a value of type [T] to a value of type [R].
///
/// [value] The value to convert.
typedef ConverterFunction<T, R> = R Function(T value);
