import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Extensions for removing a prefix from a string.
extension RemovePrefix on String {
  /// Removes a given prefix from the string if it starts with that prefix.
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
final defaults = SettingsModel(
  themeMode: ThemeMode.system,
  colorSchemeType: ColorSchemeType.system,
  seedColor: Colors.blueAccent,
  rememberedChoices: {},
);

/// Enum representing keys used for storing settings in SharedPreferences.
enum _SettingsKeys {
  /// Theme mode key.
  theme,

  /// Color scheme type key.
  colorSchemeType,

  /// Seed color key.
  seedColor,
}

/// Prefix used for remembered choices keys in SharedPreferences.
const _rememberedChoicesKeyPrefix = 'remembered.';

/// Fetches settings from SharedPreferences.
///
/// This function retrieves settings from SharedPreferences and returns a `SettingsModel` object.
/// If any setting is not found in SharedPreferences, the corresponding default value from `defaults` is used.
Future<SettingsModel> getSettings() async {
  final prefs = await SharedPreferences.getInstance();
  final theme =
      prefs.getString(_SettingsKeys.theme.name) ?? defaults.themeMode.name;
  final colorSchemeTypeString =
      prefs.getString(_SettingsKeys.colorSchemeType.name) ??
          defaults.colorSchemeType.name;
  final seedColorInt =
      prefs.getInt(_SettingsKeys.seedColor.name) ?? defaults.seedColor.value;

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
      assert(false, 'Unknown theme mode: $theme'); // fail for debug builds
      themeMode = defaults.themeMode; // use default for release builds
      break;
  }

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
          'Unknown color scheme type: $colorSchemeTypeString'); // fail for debug builds
      colorSchemeType =
          defaults.colorSchemeType; // use default for release builds
      break;
  }

  final seedColor = Color(seedColorInt);

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

  return SettingsModel(
    themeMode: themeMode,
    colorSchemeType: colorSchemeType,
    seedColor: seedColor,
    rememberedChoices: rememberedChoices,
  );
}

/// Saves settings to SharedPreferences.
///
/// This function takes a `SettingsModel` object and saves its settings to SharedPreferences.
Future<void> saveSettings(SettingsModel settings) async {
  final prefs = await SharedPreferences.getInstance();
  final theme = settings.themeMode.name;
  final colorSchemeTypeString = settings.colorSchemeType.name;
  final seedColorInt = settings.seedColor.value;

  await prefs.setString(_SettingsKeys.theme.name, theme);
  await prefs.setString(
      _SettingsKeys.colorSchemeType.name, colorSchemeTypeString);
  await prefs.setInt(_SettingsKeys.seedColor.name, seedColorInt);

  for (final key in settings._rememberedChoices.keys) {
    final value = settings._rememberedChoices[key];
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
class SettingsModel with ChangeNotifier {
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

  /// Constructor for `SettingsModel`.
  SettingsModel({
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
  bool? getRememberedChoice(String key) => _rememberedChoices[key];

  /// Setter for theme mode.
  ///
  /// This method updates the theme mode setting and optionally saves it to SharedPreferences.
  void setThemeMode(ThemeMode value, {bool save = true}) {
    _themeMode = value;
    if (save) {
      saveSettings(this);
    }
    notifyListeners();
  }

  /// Setter for color scheme type.
  ///
  /// This method updates the color scheme type setting and optionally saves it to SharedPreferences.
  void setColorSchemeType(ColorSchemeType value, {bool save = true}) {
    _colorSchemeType = value;
    if (save) {
      saveSettings(this);
    }
    notifyListeners();
  }

  /// Setter for seed color.
  ///
  /// This method updates the seed color setting and optionally saves it to SharedPreferences.
  void setSeedColor(Color value, {bool save = true}) {
    _seedColor = value;
    if (save) {
      saveSettings(this);
    }
    notifyListeners();
  }

  /// Setter for remembered choice value.
  ///
  /// This method updates the remembered choice value for a given key and optionally saves it to SharedPreferences.
  void setRememberedChoice(String key, bool value, {bool save = true}) {
    _rememberedChoices[key] = value;
    if (save) {
      saveSettings(this);
    }
  }

  /// Method to forget all remembered choices.
  ///
  /// This method removes all entries from the `_rememberedChoices` map and optionally saves the changes to SharedPreferences.
  void forgetRememberedChoices({bool save = true}) {
    for (final key in _rememberedChoices.keys) {
      _rememberedChoices[key] = null;
    }
    if (save) {
      saveSettings(this);
    }
  }
}

/// Widget for changing the application theme.
class ChangeThemeButtonWidget extends StatelessWidget {
  /// EdgeInsets for padding.
  final EdgeInsets edgeInsets;

  /// Constructor for `ChangeThemeButtonWidget`.
  const ChangeThemeButtonWidget({
    super.key,
    required this.edgeInsets,
  });

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsModel>();
    return Padding(
      padding: edgeInsets,
      child: Switch.adaptive(
        value: settings.isDarkMode,
        thumbIcon: settings.isDarkMode
            ? WidgetStateProperty.all(const Icon(Icons.dark_mode_outlined))
            : WidgetStateProperty.all(const Icon(Icons.wb_sunny_outlined)),
        onChanged: (value) {
          settings.isDarkMode
              ? settings.setThemeMode(ThemeMode.light)
              : settings.setThemeMode(ThemeMode.dark);
        },
      ),
    );
  }
}
