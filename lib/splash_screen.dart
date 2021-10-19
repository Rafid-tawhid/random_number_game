import 'package:flutter/material.dart';

import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

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
                    padding: const EdgeInsets.only(left: 28.0,right: 28),
                    child: new Text(
                      ' Play ',
                      style: TextStyle(color: Colors.white,fontSize: 20),
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
                                    child: ListView(
                                      // Important: Remove any padding from the ListView.
                                      padding: EdgeInsets.zero,
                                      children: <Widget>[
                                        UserAccountsDrawerHeader(
                                          accountName: Text("Rafid Tawhid"),
                                          accountEmail:
                                              Text("rafid@pencilbox.edu.bd"),
                                          currentAccountPicture: CircleAvatar(
                                            backgroundColor: Colors.orange,
                                            child: Text(
                                              "PB",
                                              style: TextStyle(fontSize: 30.0),
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.home),
                                          title: Text("Home"),
                                          onTap: () {},
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.settings),
                                          title: Text("Settings"),
                                          onTap: () {},
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.contacts),
                                          title: Text("Contact Us"),
                                          onTap: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                  appBar: AppBar(
                                    title: const Text(
                                      "G-Game",
                                    ),
                                    centerTitle: true,
                                  ),
                                  body: HomePage(),
                                ),
                              )),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
