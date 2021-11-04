import 'package:flutter/material.dart';
import 'package:random_number_game/auth/firebase_auth.dart';
import 'package:random_number_game/pages/login_page.dart';
import '../main.dart';
import 'louncher_page.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName='/splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  void initState() {

    Future.delayed(Duration.zero,(){

      if(FirebaseAuthService.current_user==null){
        Navigator.pushReplacementNamed(context, LauncherPage.routeName);
      }
      else
      {
        Navigator.pushReplacementNamed(context, HomePage.routeName);

      }
    });

    super.initState();
  }
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
                      "Lets go..",
                      style: TextStyle(
                          fontSize: 56, color: Colors.red, fontFamily: 'Cursive'),
                    ),
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
