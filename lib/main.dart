import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tk2_pbp/helpers/authenticated_request.dart';

import 'package:tk2_pbp/screens/login.dart';

import 'package:tk2_pbp/pages/home.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

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
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'KonvaSearch'),
          routes: {"/login": (BuildContext context) => const LoginPage()},
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
    _pages = <Widget>[const Home()];

    // Page controller
    _pageController = PageController(initialPage: _pageIndex);
  }

  void _setPage(int x) {
    setState(() {
      _pageIndex = x;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    if (!kIsWeb) request.init(context);
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
            child: Icon(Icons.bloodtype_outlined),
            padding: EdgeInsets.fromLTRB(0, 0, 0, 2.0)),
        activeIcon: Padding(
            child: Icon(Icons.bloodtype),
            padding: EdgeInsets.fromLTRB(0, 0, 0, 2.0)),
        label: 'Request',
      ),
      BottomNavigationBarItem(
        icon: Padding(
            child: Icon(Icons.support_agent_outlined),
            padding: EdgeInsets.fromLTRB(0, 0, 0, 2.0)),
        activeIcon: Padding(
            child: Icon(Icons.support_agent),
            padding: EdgeInsets.fromLTRB(0, 0, 0, 2.0)),
        label: 'Reports',
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
