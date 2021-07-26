import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/home_page/croissant_tab/croissant_tab.dart';
import 'package:flutter_boilerplate/home_page/home_tab/home_tab.dart';
import 'package:flutter_boilerplate/home_page/map_tab/map_tab.dart';
import 'package:flutter_boilerplate/home_page/notification_tab/notification_tab.dart';
import 'package:flutter_boilerplate/home_page/settings_tab/settings_tab.dart';
import 'package:flutter_boilerplate/inherited/kuzzle_sdk.dart';
import 'package:flutter_boilerplate/messages.i18n.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePageTab {
  final BottomNavigationBarItem item;
  final Widget child;
  final String title;

  HomePageTab({required this.item, required this.child, required this.title});
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final _m = const Messages();
  bool _isLoggingOut = false;
  List<HomePageTab> _homePageTabs = [];
  PageController? _pageController;
  int _currentTabIndex = 0;
  set currentTabIndex(int index) {
    setState(() {
      _currentTabIndex = index;
      _pageController!.animateToPage(
        index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    });
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _homePageTabs = <HomePageTab>[
      HomePageTab(
        item: BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: _m.menu.home.label,
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: HomeTab(),
        ),
        title: _m.menu.home.title,
      ),
      HomePageTab(
        item: BottomNavigationBarItem(
          icon: const Icon(Icons.map),
          label: _m.menu.map.label,
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: MapTab(),
        ),
        title: _m.menu.map.title,
      ),
      HomePageTab(
        item: BottomNavigationBarItem(
          icon: const Icon(Icons.notifications),
          label: _m.menu.notification.label,
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: NotificationTab(),
        ),
        title: _m.menu.notification.title,
      ),
      HomePageTab(
        item: BottomNavigationBarItem(
          icon: const Icon(Icons.bakery_dining_rounded),
          label: _m.menu.croissant.label,
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CroissantTab(),
        ),
        title: _m.menu.croissant.title,
      ),
      HomePageTab(
        item: BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: _m.menu.settings.label,
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: SettingsTab(),
        ),
        title: _m.menu.settings.title,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            _homePageTabs[_currentTabIndex].title,
          ),
          centerTitle: true,
          elevation: 0.0,
          actions: [
            GestureDetector(
              onTap: () async {
                if (!_isLoggingOut) {
                  _isLoggingOut = true;
                  try {
                    await KuzzleSdk.of(context).kuzzle.auth.logout();
                    await const FlutterSecureStorage()
                        .delete(key: 'kuzzleToken');
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  } catch (_) {
                    _isLoggingOut = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(_m.errors.logoutError),
                      ),
                    );
                  }
                }
              },
              child: const Icon(Icons.logout),
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentTabIndex = index);
          },
          children: _homePageTabs.map((e) => e.child).toList(),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color.fromRGBO(209, 209, 209, 1),
                width: 0.3,
              ),
            ),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.white,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: const Color.fromRGBO(189, 189, 189, 1),
            currentIndex: _currentTabIndex,
            onTap: (index) {
              setState(() {
                _currentTabIndex = index;
              });
              _pageController?.animateToPage(
                index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
              );
            },
            type: BottomNavigationBarType.fixed,
            items: _homePageTabs.map((tab) => tab.item).toList(),
          ),
        ),
      );
}
