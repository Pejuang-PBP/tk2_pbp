import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:tk2_pbp/helpers/authenticated_request.dart';

import 'package:tk2_pbp/screens/request_donor.dart';

import 'package:tk2_pbp/pages/profile.dart';
import 'package:tk2_pbp/pages/dashboard.dart';

import 'package:tk2_pbp/screens/home_screen.dart';
import 'package:tk2_pbp/screens/account_screen.dart';
import 'package:tk2_pbp/screens/login_screen.dart';
import 'package:tk2_pbp/screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) {
          CookieRequest request = CookieRequest();

          return request;
        },
        child: MaterialApp(
            title: 'KonvaSearch',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            // home: const MyHomePage(title: 'KonvaSearch'),
            initialRoute: '/',
            routes: {
              '/': (ctx) => const MyHomePage(title: 'KonvaSearch'),
              LoginScreen.routeName: (ctx) => const LoginScreen(),
              RegisterScreen.routeName: (ctx) => const RegisterScreen(),
              '/request-donor': (ctx) => const RequestDonorPage()
            }));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _pageIndex = 0;

  List<Widget> _pages = [];
  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    // Page index for determining menu active state.
    _pageIndex = 0;

    // Page components
    _pages = <Widget>[
      const HomeScreen(),
      const Dashboard(),
      const AccountScreen(),
      //       Dashboard(updatePage: (int x) {
      //   _setPage(x);
      //   _pageController.jumpToPage(x);
      // }),
      // const Profile()
    ];

    // Page controller
    _pageController = PageController(initialPage: _pageIndex);

    // checkAuth();
  }

  // Future<void> checkAuth() async {
  //   if (req.loggedIn) {
  //     setState(() {
  //       _pages[4] = const AccountAuthedScreen();
  //     });
  //   }
  // }

  void _setPage(int x) {
    setState(() {
      _pageIndex = x;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    request.init(context);

    if (request.loggedIn) {
      _pages[2] = const Profile();
    }

    List<BottomNavigationBarItem> menuItems = const [
      BottomNavigationBarItem(
        icon: Padding(
            child: Icon(Icons.home_outlined),
            padding: EdgeInsets.fromLTRB(0, 0, 0, 2.0)),
        activeIcon: Padding(
            child: Icon(Icons.home),
            padding: EdgeInsets.fromLTRB(0, 0, 0, 2.0)),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Padding(
            child: Icon(Icons.dashboard_outlined),
            padding: EdgeInsets.fromLTRB(0, 0, 0, 2.0)),
        activeIcon: Padding(
            child: Icon(Icons.dashboard),
            padding: EdgeInsets.fromLTRB(0, 0, 0, 2.0)),
        label: 'Dashboard',
      ),
      BottomNavigationBarItem(
          icon: Padding(
              child: Icon(Icons.person_outline),
              padding: EdgeInsets.fromLTRB(0, 0, 0, 2.0)),
          activeIcon: Padding(
              child: Icon(Icons.person),
              padding: EdgeInsets.fromLTRB(0, 0, 0, 2.0)),
          label: 'Profile')
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Container(
              child: Image.asset(
                "assets/images/logo.png",
                width: 36.0,
                height: 36.0,
              ),
              margin: const EdgeInsets.fromLTRB(0, 0, 6.0, 0)),
          Text(widget.title,
              style: const TextStyle(fontWeight: FontWeight.w600)),
        ]),
        backgroundColor: const Color.fromRGBO(0, 41, 84, 1),
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (page) {
          setState(() {
            _pageIndex = page;
          });
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: SizedBox(
          child: BottomNavigationBar(
              elevation: 2.5,
              backgroundColor: const Color.fromRGBO(0, 41, 84, 1),
              items: menuItems,
              currentIndex: _pageIndex,
              unselectedItemColor: const Color.fromRGBO(194, 223, 255, 1),
              selectedItemColor: const Color.fromRGBO(255, 191, 89, 1),
              onTap: (int x) {
                _pageController.jumpToPage(x);
                _setPage(x);
              },
              selectedFontSize: 13.0,
              iconSize: 25.0,
              unselectedFontSize: 13.0,
              type: BottomNavigationBarType.fixed),
          height: 60),
    );
  }
}
