import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:random_number_game/auth/firebase_auth.dart';

class GoogleSignInController with ChangeNotifier {
  // object
  var _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;

  // function for login
  login() async {
    this.googleSignInAccount = await _googleSignIn.signIn();

    // call
    notifyListeners();
  }

  // function to logout
  logout() async {
    // empty the value after logut
    this.googleSignInAccount = await _googleSignIn.disconnect();

    // call
    notifyListeners();
  }
}
