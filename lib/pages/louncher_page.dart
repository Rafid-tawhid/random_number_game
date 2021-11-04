import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_number_game/main.dart';
import 'package:random_number_game/pages/login_page.dart';

class LauncherPage extends StatefulWidget {
  static const String routeName = '/louncher_page';

  @override
  _LauncherPageState createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
            body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, LoginPage.routeName);
                  },
                  child: Text(
                    "Sign Up Free ",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.blueAccent,
                        fontFamily: 'Cursive',
                        letterSpacing: 4),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: FlatButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 28.0, right: 28),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: new Text(
                        ' Play ',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, HomePage.routeName);
                  },
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
