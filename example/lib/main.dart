import 'dart:async';
import 'package:flutter/material.dart';
import 'package:material_you_dynamic_theme/material_you_dynamic_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runAppDynamic(
    home: MyHomePage(
      title: 'M3DC',
    ),
    debugShowCheckedModeBanner: false,
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title});

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with RestorationMixin<MyHomePage> {
  final _counter = RestorableInt(0);
  final _page = RestorableInt(0);

  @override
  String? get restorationId => 'home_page';

  @override
  Future<void> restoreState(
      RestorationBucket? oldBucket, bool initialRestore) async {
    registerForRestoration(_counter, '_counter');
    registerForRestoration(_page, '_page');
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _counter.dispose();
    _page.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter.value++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${_counter.value}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        // key: navigationKey,
        animationDuration: const Duration(milliseconds: 300),
        selectedIndex: _page.value,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        indicatorColor: Theme.of(context).colorScheme.onInverseSurface,
        surfaceTintColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        overlayColor: WidgetStateColor.resolveWith(
          (states) => Theme.of(context).colorScheme.onInverseSurface,
        ),
        onDestinationSelected: (index) {
          setState(() {
            _page.value = index;
          });
        },
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: <NavigationDestination>[
          NavigationDestination(
            selectedIcon: const Icon(Icons.home_rounded),
            icon: const Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.grid_view_rounded),
            icon: const Icon(Icons.grid_view_outlined),
            label: 'Browse',
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.star),
            icon: const Icon(Icons.star_outline),
            label: 'Favorites',
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.account_circle),
            icon: const Icon(Icons.account_circle_outlined),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
