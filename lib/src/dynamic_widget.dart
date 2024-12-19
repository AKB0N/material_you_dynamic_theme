import 'package:flutter/material.dart';
import 'package:material_you_dynamic_theme/material_you_dynamic_theme.dart';
import 'package:provider/provider.dart';

/// A helper function to run your app with dynamic theming.
///
/// This function initializes the [ThemeSettingsModel] and [BrightnessGetColorScheme]
/// and provides them to the widget tree via [MultiProvider]. It then runs the app
/// using the provided `home` widget or other routing parameters.
///
/// Most parameters correspond to the parameters of [MaterialApp]. Refer to the
/// [MaterialApp] documentation for more details.
///
/// `themeAnimationStyle` allows you to customize the animation used when changing the theme.
/// If not provided, no animation will be used.
Future<void> runAppDynamic({
  GlobalKey<NavigatorState>? navigatorKey,
  GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey,
  Widget? home,
  Map<String, WidgetBuilder> routes = const <String, WidgetBuilder>{},
  String? initialRoute,
  RouteFactory? onGenerateRoute,
  InitialRouteListFactory? onGenerateInitialRoutes,
  RouteFactory? onUnknownRoute,
  NotificationListenerCallback<NavigationNotification>?
      onNavigationNotification,
  List<NavigatorObserver> navigatorObservers = const <NavigatorObserver>[],
  RouteInformationProvider? routeInformationProvider,
  RouteInformationParser<Object>? routeInformationParser,
  RouterDelegate<Object>? routerDelegate,
  BackButtonDispatcher? backButtonDispatcher,
  RouterConfig<Object>? routerConfig,
  TransitionBuilder? builder,
  String title = '',
  GenerateAppTitle? onGenerateTitle,
  ThemeData? theme,
  ThemeData? darkTheme,
  ThemeData? highContrastTheme,
  ThemeData? highContrastDarkTheme,
  ThemeMode? themeMode,
  Duration themeAnimationDuration = kThemeAnimationDuration,
  Curve themeAnimationCurve = Curves.linear,
  Color? color,
  Locale? locale,
  Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates,
  LocaleListResolutionCallback? localeListResolutionCallback,
  LocaleResolutionCallback? localeResolutionCallback,
  Iterable<Locale> supportedLocales = const <Locale>[Locale('en', 'US')],
  bool debugShowMaterialGrid = false,
  bool showPerformanceOverlay = false,
  bool checkerboardRasterCacheImages = false,
  bool checkerboardOffscreenLayers = false,
  bool showSemanticsDebugger = false,
  bool debugShowCheckedModeBanner = true,
  Map<ShortcutActivator, Intent>? shortcuts,
  Map<Type, Action<Intent>>? actions,
  String? restorationScopeId,
  ScrollBehavior? scrollBehavior,
  bool useInheritedMediaQuery = false,
  AnimationStyle? themeAnimationStyle,
}) async {
  final themeSettings = await getThemeSettings();
  final appColorScheme =
      await loadColorScheme(fallbackSeedColor: themeSettings.seedColor);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeSettingsModel>.value(value: themeSettings),
        Provider<BrightnessGetColorScheme>.value(value: appColorScheme),
      ],
      child: AppDynamic(
        home: home,
        actions: actions,
        builder: builder,
        checkerboardOffscreenLayers: checkerboardOffscreenLayers,
        checkerboardRasterCacheImages: checkerboardRasterCacheImages,
        color: color,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        debugShowMaterialGrid: debugShowMaterialGrid,
        highContrastDarkTheme: highContrastDarkTheme,
        highContrastTheme: highContrastTheme,
        initialRoute: initialRoute,
        locale: locale,
        localeListResolutionCallback: localeListResolutionCallback,
        localeResolutionCallback: localeResolutionCallback,
        localizationsDelegates: localizationsDelegates,
        navigatorKey: navigatorKey,
        navigatorObservers: navigatorObservers,
        onGenerateInitialRoutes: onGenerateInitialRoutes,
        onGenerateRoute: onGenerateRoute,
        onGenerateTitle: onGenerateTitle,
        onNavigationNotification: onNavigationNotification,
        onUnknownRoute: onUnknownRoute,
        routes: routes,
        scaffoldMessengerKey: scaffoldMessengerKey,
        scrollBehavior: scrollBehavior,
        shortcuts: shortcuts,
        showPerformanceOverlay: showPerformanceOverlay,
        showSemanticsDebugger: showSemanticsDebugger,
        supportedLocales: supportedLocales,
        themeAnimationCurve: themeAnimationCurve,
        themeAnimationDuration: themeAnimationDuration,
        themeAnimationStyle: themeAnimationStyle,
        title: title,
        // useInheritedMediaQuery: useInheritedMediaQuery,
      ),
    ),
  );
}

/// A dynamically themed [MaterialApp] widget.
///
/// This widget uses [BrightnessGetColorSchemeBuilder] to dynamically apply the
/// appropriate color scheme based on the current theme settings and whether
/// dynamic color is supported.
///
/// Most parameters correspond to the parameters of [MaterialApp]. Refer to the
/// [MaterialApp] documentation for more details.
///
/// `themeAnimationStyle` allows you to customize the animation used when changing the theme.
/// If not provided, no animation will be used.
class AppDynamic extends StatelessWidget {
  /// Creates a [AppDynamic] that uses the [MaterialApp] constructor.
  const AppDynamic({
    super.key,
    this.navigatorKey,
    this.scaffoldMessengerKey,
    this.home,
    Map<String, WidgetBuilder> this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.onNavigationNotification,
    List<NavigatorObserver> this.navigatorObservers =
        const <NavigatorObserver>[],
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode = ThemeMode.system,
    this.themeAnimationDuration = kThemeAnimationDuration,
    this.themeAnimationCurve = Curves.linear,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    @Deprecated('Remove this parameter as it is now ignored. '
        'MaterialApp never introduces its own MediaQuery; the View widget takes care of that. '
        'This feature was deprecated after v3.7.0-29.0.pre.')
    this.useInheritedMediaQuery = false,
    this.themeAnimationStyle,
  })  : routeInformationProvider = null,
        routeInformationParser = null,
        routerDelegate = null,
        backButtonDispatcher = null,
        routerConfig = null;

  /// Creates a [AppDynamic] that uses the [MaterialApp.router] constructor.
  const AppDynamic.router({
    super.key,
    this.scaffoldMessengerKey,
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.routerConfig,
    this.backButtonDispatcher,
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.onNavigationNotification,
    this.color,
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode = ThemeMode.system,
    this.themeAnimationDuration = kThemeAnimationDuration,
    this.themeAnimationCurve = Curves.linear,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    @Deprecated('Remove this parameter as it is now ignored. '
        'MaterialApp never introduces its own MediaQuery; the View widget takes care of that. '
        'This feature was deprecated after v3.7.0-29.0.pre.')
    this.useInheritedMediaQuery = false,
    this.themeAnimationStyle,
  })  : assert(routerDelegate != null || routerConfig != null),
        navigatorObservers = null,
        navigatorKey = null,
        onGenerateRoute = null,
        home = null,
        onGenerateInitialRoutes = null,
        onUnknownRoute = null,
        routes = null,
        initialRoute = null;

  /// The key for the [Navigator] used by this app.
  final GlobalKey<NavigatorState>? navigatorKey;

  /// The key for the [ScaffoldMessenger] used by this app.
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  /// The widget to display as the home screen of the app.
  final Widget? home;

  /// The routes for the app.
  final Map<String, WidgetBuilder>? routes;

  /// The initial route for the app.
  final String? initialRoute;

  /// The route factory for the app.
  final RouteFactory? onGenerateRoute;

  /// The initial route list factory for the app.
  final InitialRouteListFactory? onGenerateInitialRoutes;

  /// The unknown route factory for the app.
  final RouteFactory? onUnknownRoute;

  /// The navigation notification callback for the app.
  final NotificationListenerCallback<NavigationNotification>?
      onNavigationNotification;

  /// The navigator observers for the app.
  final List<NavigatorObserver>? navigatorObservers;

  /// The route information provider for the app.
  final RouteInformationProvider? routeInformationProvider;

  /// The route information parser for the app.
  final RouteInformationParser<Object>? routeInformationParser;

  /// The router delegate for the app.
  final RouterDelegate<Object>? routerDelegate;

  /// The back button dispatcher for the app.
  final BackButtonDispatcher? backButtonDispatcher;

  /// The router config for the app.
  final RouterConfig<Object>? routerConfig;

  /// The builder for the app.
  final TransitionBuilder? builder;

  /// The title of the app.
  final String title;

  /// The generate title callback for the app.
  final GenerateAppTitle? onGenerateTitle;

  /// The theme for the app.
  final ThemeData? theme;

  /// The dark theme for the app.
  final ThemeData? darkTheme;

  /// The high contrast theme for the app.
  final ThemeData? highContrastTheme;

  /// The high contrast dark theme for the app.
  final ThemeData? highContrastDarkTheme;

  /// The theme mode for the app.
  final ThemeMode? themeMode;

  /// The theme animation duration for the app.
  final Duration themeAnimationDuration;

  /// The theme animation curve for the app.
  final Curve themeAnimationCurve;

  /// The color for the app.
  final Color? color;

  /// The locale for the app.
  final Locale? locale;

  /// The localizations delegates for the app.
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  /// The locale list resolution callback for the app.
  final LocaleListResolutionCallback? localeListResolutionCallback;

  /// The locale resolution callback for the app.
  final LocaleResolutionCallback? localeResolutionCallback;

  /// The supported locales for the app.
  final Iterable<Locale> supportedLocales;

  /// Whether to show the performance overlay.
  final bool showPerformanceOverlay;

  /// Whether to checkerboard raster cache images.
  final bool checkerboardRasterCacheImages;

  /// Whether to checkerboard offscreen layers.
  final bool checkerboardOffscreenLayers;

  /// Whether to show the semantics debugger.
  final bool showSemanticsDebugger;

  /// Whether to show the debug banner.
  final bool debugShowCheckedModeBanner;

  /// The shortcuts for the app.
  final Map<ShortcutActivator, Intent>? shortcuts;

  /// The actions for the app.
  final Map<Type, Action<Intent>>? actions;

  /// The restoration scope ID for the app.
  final String? restorationScopeId;

  /// The scroll behavior for the app.
  final ScrollBehavior? scrollBehavior;

  /// Whether to show the material grid.
  final bool debugShowMaterialGrid;

  /// Whether to use inherited media query.
  @Deprecated('This setting is now ignored. '
      'MaterialApp never introduces its own MediaQuery; the View widget takes care of that. '
      'This feature was deprecated after v3.7.0-29.0.pre.')
  final bool useInheritedMediaQuery;

  /// The animation style to use when changing the theme.
  final AnimationStyle? themeAnimationStyle;

  @override
  Widget build(BuildContext context) {
    final themeSettings = context.watch<ThemeSettingsModel>();
    return BrightnessGetColorSchemeBuilder(
        builder: (BrightnessGetColorScheme colorScheme) => MaterialApp(
              actions: actions,
              builder: builder,
              checkerboardOffscreenLayers: checkerboardOffscreenLayers,
              checkerboardRasterCacheImages: checkerboardRasterCacheImages,
              color: color,
              debugShowCheckedModeBanner: debugShowCheckedModeBanner,
              debugShowMaterialGrid: debugShowMaterialGrid,
              highContrastDarkTheme: highContrastDarkTheme,
              highContrastTheme: highContrastTheme,
              initialRoute: initialRoute,
              locale: locale,
              localeListResolutionCallback: localeListResolutionCallback,
              localeResolutionCallback: localeResolutionCallback,
              localizationsDelegates: localizationsDelegates,
              navigatorKey: navigatorKey,
              navigatorObservers: const [],
              onGenerateInitialRoutes: onGenerateInitialRoutes,
              onGenerateRoute: onGenerateRoute,
              onGenerateTitle: onGenerateTitle,
              onNavigationNotification: onNavigationNotification,
              onUnknownRoute: onUnknownRoute,
              routes: routes!,
              scaffoldMessengerKey: scaffoldMessengerKey,
              scrollBehavior: scrollBehavior,
              shortcuts: shortcuts,
              showPerformanceOverlay: showPerformanceOverlay,
              showSemanticsDebugger: showSemanticsDebugger,
              supportedLocales: supportedLocales,
              themeAnimationCurve: themeAnimationCurve,
              themeAnimationDuration: themeAnimationDuration,
              themeAnimationStyle: themeAnimationStyle,
              title: title,
              // useInheritedMediaQuery: useInheritedMediaQuery,
              theme: ThemeData(
                colorScheme: colorScheme.light,
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                colorScheme: colorScheme.dark,
                useMaterial3: true,
              ),
              themeMode: themeSettings.themeMode,
              restorationScopeId: 'app',
              home: home,
              // builder: (context, child) => child ?? const Offstage(),
            ));
  }

  /// Creates a [HeroController] that uses the [MaterialRectArcTween] for
  /// [Hero] animations.
  static HeroController createMaterialHeroController() {
    return HeroController(
      createRectTween: (Rect? begin, Rect? end) {
        return MaterialRectArcTween(begin: begin, end: end);
      },
    );
  }
}
