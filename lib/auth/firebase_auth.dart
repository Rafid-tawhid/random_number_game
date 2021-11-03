
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService{
  static FirebaseAuth _auth=FirebaseAuth.instance;
  final ggleSignIn=GoogleSignIn();

  static User? get current_user=>_auth.currentUser;


  static Future<User?> loginUser(String email,String pass)async{

    final result=await _auth.signInWithEmailAndPassword(email: email, password: pass);


    return result.user;
  }
  static Future signUpUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
  static Future<void> logoutUser()async {
    return _auth.signOut();
  }

  Future googleSignUp()async{
    GoogleSignInAccount? googleSignInAccount=await ggleSignIn.signIn();
    if(googleSignInAccount!=null){
      GoogleSignInAuthentication googleSignInAuthentication=await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential result =
      await _auth.signInWithCredential(credential);
      User? user=await _auth.currentUser;
      print(user?.uid);
      return Future.value(true);

    }


  }

}