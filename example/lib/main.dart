import 'dart:async';
import 'package:flutter/material.dart';
import 'package:material_you_dynamic_theme/material_you_dynamic_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runAppDynamic(
    home: MyHomePage(
      title: 'MYDT',
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
  final _scrollOffset = RestorableDouble(0);
  final _scrollController = ScrollController();

  @override
  String? get restorationId => 'home_page';

  @override
  Future<void> restoreState(
      RestorationBucket? oldBucket, bool initialRestore) async {
    registerForRestoration(_counter, '_counter');
    registerForRestoration(_page, '_page');
    registerForRestoration(_scrollOffset, 'scroll_offset_page');
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _counter.dispose();
    _page.dispose();
    _scrollController.dispose();
    _scrollOffset.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController
        .addListener(() => _scrollOffset.value = _scrollController.offset);
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => _scrollController.jumpTo(_scrollOffset.value));
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter.value++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.title!),
            ),
            actions: [ChangeThemeSwitchWidget()],
          ),
          SliverFillRemaining(
            child: ListView(
              physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
              children: <Widget>[
                title('Switch Example', hideDivider: true),
                ListTile(
                  title: Text('Dark Mode'),
                  trailing: ChangeThemeSwitchWidget(),
                ),
                title('Choice List Tile Example'),
                ChangeThemeChoiceListTileWidget(),
                title('Restore State Example'),
                ListTile(
                  title: Text('You have pushed the button this many times:'),
                  trailing: Text(
                    '${_counter.value}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ],
            ),
          )
        ],
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

  Widget title(
    text, {
    double height = 30,
    bool notTitle = false,
    bool hideDivider = false,
  }) =>
      Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height),
            notTitle
                ? SizedBox()
                : hideDivider
                    ? SizedBox()
                    : Divider(
                        color: Theme.of(context).colorScheme.inversePrimary),
            notTitle ? SizedBox() : SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      );
}
