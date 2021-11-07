import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Log extends StatefulWidget {

  static const String routeName='/log';

  @override
  _LogState createState() => _LogState();
}

class _LogState extends State<Log> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Log"),
          onPressed: (){
            signInWithFacebook();

//             final AccessToken? accessToken = await FacebookAuth.instance.accessToken;
//
//             print("hi hello");
//             if (accessToken != null) {
//               print("hello Hii");
//             }
//
//             final LoginResult result = await FacebookAuth.instance.login(); // by default we request the email and the public profile
// // or FacebookAuth.i.login()
//             if (result.status == LoginStatus.success) {
//               // you are logged
//               final AccessToken accessToken = result.accessToken!;
//             } else {
//               print(result.status);
//               print(result.message);
//             }
          },
        ),
      ),
    );
  }
  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
