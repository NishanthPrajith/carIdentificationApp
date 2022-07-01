import 'dart:math';

import 'package:flutter/material.dart';
import 'firstPage.dart';
import 'accountPage.dart';
import 'searchPage.dart';

import 'package:flutter/services.dart';

import 'package:camera/camera.dart';

import './comps/infoCard.dart';

import 'package:google_fonts/google_fonts.dart';

// Firebase Configuration
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';



List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  cameras = await availableCameras();
  for (CameraDescription camera in cameras) {
    print(camera.lensDirection);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        fontFamily: GoogleFonts.manrope().fontFamily,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
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
  int _selection = 1;
  bool _active = false;
  bool _fullscreen = false;


  double edges = 25;

  final _pageController = PageController(initialPage: 1);
  double height = 0;
  double prevHeight = 0;

  void setActive() {
    print("Hello");
    setState(() {
      _active = true;
    });
  }

  void changeHeight(a) {
    setState(() {
      prevHeight = height;
      height = a;
      edges = 25;
      _fullscreen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    double done = (MediaQuery.of(context).size.height / 13) * 5 * 0.82 - 20;
    double a = max(done, height);
    return Scaffold(
      resizeToAvoidBottomInset: false, 
      body: Container(
          color: _active ? Colors.white : Colors.black,
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Column(
              children: <Widget>[
                Expanded(
                    flex: _active ? 8 : 12,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(_active ? 0 : 30),
                            bottomRight: Radius.circular(_active ? 0 : 30),
                          )),
                      child: PageView(
                          controller: _pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            SearchPage(),
                            // ignore: void_checks
                            FirstPage(onValueChanged: () => {setActive()}, cameras: cameras, active: _active),
                            const AccountPage(),
                          ]),
                    )),
                Expanded(
                    flex: _active ? 5 : 2,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(top: 15),
                        decoration: BoxDecoration(
                          color: _active ? Colors.black : Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(_active ? 30 : 0),
                            topRight: Radius.circular(_active ? 30 : 0),
                          )),
                        child: Stack(children: [
                          AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeIn,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              width:
                                  (MediaQuery.of(context).size.width - 40) / 3,
                              margin: EdgeInsets.only(
                                  left: (((MediaQuery.of(context).size.width -
                                                  40) /
                                              3) *
                                          _selection) +
                                      20),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 25),
                              child: const Text(
                                "",
                              )),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selection = 0;
                                          _active = false;
                                        });
                                        _pageController.animateToPage(
                                          0,
                                          duration:
                                              const Duration(milliseconds: 400),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 20),
                                          child: Text(
                                            'Search',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'sfPro',
                                              color: _selection == 0
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                          ))),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selection = 1;
                                          _active = false;
                                        });
                                        _pageController.animateToPage(
                                          1,
                                          duration:
                                              const Duration(milliseconds: 400),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 20),
                                          child: Text(
                                            'Camera',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'sfPro',
                                              color: _selection == 1
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                          ))),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selection = 2;
                                          _active = false;
                                        });
                                        _pageController.animateToPage(
                                          2,
                                          duration:
                                              const Duration(milliseconds: 400),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 20),
                                          child: Text(
                                            'Account',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'sfPro',
                                              color: _selection == 2
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                          ))),
                                ),
                              ],
                            ),
                          ),
                        ])))
              ],
            ),
            GestureDetector(
              onVerticalDragUpdate: (details) => {
                setState(() {
                  prevHeight = height;
                  bool original = _fullscreen;
                  height = (MediaQuery.of(context).size.height - details.globalPosition.dy);
                  edges = 25;
                  print(details.globalPosition.dy);
                  if (height > done && !original) {
                    height = (MediaQuery.of(context).size.height);
                    edges = 0;
                    _fullscreen = true;
                  }
                  if (original && details.globalPosition.dy > 0) {
                    print("Working");
                    height = done;
                    edges = 25;
                    _fullscreen = false;
                  }
                  if (height <= (done / 2)) {
                    height = 0;
                    _active = false;
                  } 
                })
              },
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeIn,
                  height: _active
                      ? a
                      : 0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xfff0f0f0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(edges),
                      topRight: Radius.circular(edges),
                    ),
                  ),
                  child: InfoCard(fullscreen : _fullscreen, maxHeight: done, onValueChanged: () => {changeHeight(done)})),
            )
          ])), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
