
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService{
  static FirebaseAuth _auth=FirebaseAuth.instance;
  static User? get current_user=>_auth.currentUser;

  static Future<User?> loginUser(String email,String pass)async{

    final result=await _auth.signInWithEmailAndPassword(email: email, password: pass);
    return result.user;
  }
  static Future<void> logoutUser(){
    return _auth.signOut();
  }

}