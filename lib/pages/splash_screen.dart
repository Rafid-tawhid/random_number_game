import 'package:flutter/material.dart';

import 'package:random_number_game/pages/profile_page.dart';

import 'contact_page.dart';

import '../custom_widget/custom_drawer.dart';
import '../main.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName='/splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('img/anim5.gif'),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      "Let's go..",
                      style: TextStyle(
                          fontSize: 56, color: Colors.red, fontFamily: 'Cursive'),
                    ),
                  ),
                  FlatButton(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 28.0, right: 28),
                      child: new Text(
                        ' Play ',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MaterialApp(
                                  debugShowCheckedModeBanner: false,
                                  home: Scaffold(
                                    drawer: Drawer(
                                      child: CustomDrawer(),
                                    ),
                                    appBar: AppBar(
                                      title: const Text(
                                        "G-Game",
                                      ),
                                      centerTitle: true,
                                    ),
                                    body: HomePage(),
                                  ),
                                )
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
